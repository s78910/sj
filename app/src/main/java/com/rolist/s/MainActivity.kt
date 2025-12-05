package com.rolist.s

import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.graphics.drawable.Drawable
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import java.io.BufferedReader
import java.io.DataOutputStream
import java.io.InputStreamReader
import java.util.concurrent.Executors

class MainActivity : AppCompatActivity() {

    private lateinit var recyclerView: RecyclerView
    private lateinit var tvHeader: TextView
    private lateinit var tvStatus: TextView
    private lateinit var adapter: AppListAdapter
    private val appList = mutableListOf<AppInfo>()
    private var hasRootAccess = false
    private val executor = Executors.newSingleThreadExecutor()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        initViews()
        checkRootAccess()
        loadInstalledApps()
    }

    private fun initViews() {
        tvHeader = findViewById(R.id.tvHeader)
        tvStatus = findViewById(R.id.tvStatus)
        recyclerView = findViewById(R.id.recyclerView)
        recyclerView.layoutManager = LinearLayoutManager(this)
        adapter = AppListAdapter(appList) { appInfo -> onAppClick(appInfo) }
        recyclerView.adapter = adapter
    }

    private fun checkRootAccess() {
        executor.execute {
            hasRootAccess = checkRoot()
            runOnUiThread { updateRootStatus() }
        }
    }

    private fun updateRootStatus() {
        if (hasRootAccess) {
            tvStatus.text = "Root OK"
            tvStatus.setTextColor(0xFF4CAF50.toInt())
        } else {
            tvStatus.text = "No Root"
            tvStatus.setTextColor(0xFFF44336.toInt())
        }
    }

    private fun checkRoot(): Boolean {
        return try {
            val process = Runtime.getRuntime().exec("su -c id")
            val reader = BufferedReader(InputStreamReader(process.inputStream))
            val result = reader.readLine()
            process.waitFor()
            result?.contains("uid=0") == true
        } catch (e: Exception) {
            false
        }
    }

    private fun loadInstalledApps() {
        executor.execute {
            val pm = packageManager
            val packages = pm.getInstalledApplications(PackageManager.GET_META_DATA)
            val apps = packages.mapNotNull { appInfo ->
                try {
                    AppInfo(
                        pm.getApplicationLabel(appInfo).toString(),
                        appInfo.packageName,
                        pm.getApplicationIcon(appInfo),
                        appInfo.uid,
                        (appInfo.flags and ApplicationInfo.FLAG_SYSTEM) != 0
                    )
                } catch (e: Exception) { null }
            }.sortedBy { it.appName.lowercase() }
            runOnUiThread {
                appList.clear()
                appList.addAll(apps)
                adapter.notifyDataSetChanged()
            }
        }
    }

    private fun onAppClick(appInfo: AppInfo) {
        if (!hasRootAccess) {
            Toast.makeText(this, "Need Root", Toast.LENGTH_SHORT).show()
            return
        }
        AlertDialog.Builder(this)
            .setTitle("Trigger Root")
            .setMessage("Request root for ${appInfo.appName}?")
            .setPositiveButton("OK") { _, _ -> triggerRootRequest(appInfo) }
            .setNegativeButton("Cancel", null)
            .show()
    }

    private fun triggerRootRequest(appInfo: AppInfo) {
        executor.execute {
            try {
                Runtime.getRuntime().exec(arrayOf("su", "-c", "su ${appInfo.uid} -c su"))
                runOnUiThread {
                    Toast.makeText(this, "Triggered: ${appInfo.appName}", Toast.LENGTH_SHORT).show()
                }
            } catch (e: Exception) {
                runOnUiThread {
                    Toast.makeText(this, "Failed", Toast.LENGTH_SHORT).show()
                }
            }
        }
    }

    data class AppInfo(
        val appName: String,
        val packageName: String,
        val icon: Drawable,
        val uid: Int,
        val isSystemApp: Boolean
    )

    class AppListAdapter(
        private val apps: List<AppInfo>,
        private val onItemClick: (AppInfo) -> Unit
    ) : RecyclerView.Adapter<AppListAdapter.ViewHolder>() {

        class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
            val ivIcon: ImageView = view.findViewById(R.id.ivIcon)
            val tvAppName: TextView = view.findViewById(R.id.tvAppName)
            val tvPackageName: TextView = view.findViewById(R.id.tvPackageName)
            val tvUid: TextView = view.findViewById(R.id.tvUid)
        }

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
            val view = LayoutInflater.from(parent.context).inflate(R.layout.item_app, parent, false)
            return ViewHolder(view)
        }

        override fun onBindViewHolder(holder: ViewHolder, position: Int) {
            val app = apps[position]
            holder.ivIcon.setImageDrawable(app.icon)
            holder.tvAppName.text = app.appName
            holder.tvPackageName.text = app.packageName
            holder.tvUid.text = "UID: ${app.uid}"
            holder.itemView.setOnClickListener { onItemClick(app) }
        }

        override fun getItemCount() = apps.size
    }
}
