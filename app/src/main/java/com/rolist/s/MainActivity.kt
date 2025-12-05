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
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.io.BufferedReader
import java.io.DataOutputStream
import java.io.InputStreamReader

class MainActivity : AppCompatActivity() {

    private lateinit var recyclerView: RecyclerView
    private lateinit var tvHeader: TextView
    private lateinit var tvStatus: TextView
    private lateinit var adapter: AppListAdapter
    private val appList = mutableListOf<AppInfo>()
    private var hasRootAccess = false

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
        tvHeader.text = getString(R.string.header_text)
        recyclerView.layoutManager = LinearLayoutManager(this)
        adapter = AppListAdapter(appList) { appInfo -> onAppClick(appInfo) }
        recyclerView.adapter = adapter
    }

    private fun checkRootAccess() {
        CoroutineScope(Dispatchers.IO).launch {
            hasRootAccess = checkRoot()
            withContext(Dispatchers.Main) {
                updateRootStatus()
            }
        }
    }

    private fun updateRootStatus() {
        if (hasRootAccess) {
            tvStatus.text = getString(R.string.root_granted)
            tvStatus.setTextColor(0xFF4CAF50.toInt())
        } else {
            tvStatus.text = getString(R.string.root_not_granted)
            tvStatus.setTextColor(0xFFF44336.toInt())
            requestRootAccess()
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

    private fun requestRootAccess() {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val process = Runtime.getRuntime().exec("su")
                val os = DataOutputStream(process.outputStream)
                os.writeBytes("id\n")
                os.writeBytes("exit\n")
                os.flush()
                process.waitFor()
                delay(1000)
                hasRootAccess = checkRoot()
                withContext(Dispatchers.Main) { updateRootStatus() }
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }

    private fun loadInstalledApps() {
        CoroutineScope(Dispatchers.IO).launch {
            val pm = packageManager
            val packages = try {
                pm.getInstalledApplications(PackageManager.GET_META_DATA)
            } catch (e: Exception) {
                withContext(Dispatchers.Main) {
                    Toast.makeText(this@MainActivity, R.string.permission_error, Toast.LENGTH_LONG).show()
                }
                return@launch
            }
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
            }.sortedWith(compareBy({ it.isSystemApp }, { it.appName.lowercase() }))
            withContext(Dispatchers.Main) {
                appList.clear()
                appList.addAll(apps)
                adapter.notifyDataSetChanged()
            }
        }
    }

    private fun onAppClick(appInfo: AppInfo) {
        if (!hasRootAccess) {
            Toast.makeText(this, R.string.need_root_first, Toast.LENGTH_SHORT).show()
            requestRootAccess()
            return
        }
        AlertDialog.Builder(this)
            .setTitle(R.string.trigger_root_title)
            .setMessage(getString(R.string.trigger_root_message, appInfo.appName, appInfo.packageName, appInfo.uid))
            .setPositiveButton(R.string.confirm) { _, _ -> triggerRootRequest(appInfo) }
            .setNegativeButton(R.string.cancel, null)
            .show()
    }

    private fun triggerRootRequest(appInfo: AppInfo) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                Runtime.getRuntime().exec(arrayOf("su", "-c", "su ${appInfo.uid} -c su"))
                delay(500)
                withContext(Dispatchers.Main) {
                    Toast.makeText(this@MainActivity, getString(R.string.trigger_success, appInfo.appName), Toast.LENGTH_SHORT).show()
                }
            } catch (e: Exception) {
                withContext(Dispatchers.Main) {
                    Toast.makeText(this@MainActivity, getString(R.string.trigger_failed, e.message), Toast.LENGTH_SHORT).show()
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
            holder.tvAppName.setTextColor(if (app.isSystemApp) 0xFF888888.toInt() else 0xFF000000.toInt())
            holder.itemView.setOnClickListener { onItemClick(app) }
        }

        override fun getItemCount() = apps.size
    }
}
