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
import kotlinx.coroutines.*
import java.io.BufferedReader
import java.io.DataOutputStream
import java.io.InputStreamReader

/**
 * Root权限授予工具主界面
 * 功能：列出所有已安装应用，点击后触发该应用的Root权限申请弹窗
 */
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

    /**
     * 初始化视图组件
     */
    private fun initViews() {
        tvHeader = findViewById(R.id.tvHeader)
        tvStatus = findViewById(R.id.tvStatus)
        recyclerView = findViewById(R.id.recyclerView)

        // 设置顶部提示文本
        tvHeader.text = "刷机做环境找微信S78910JQKKKAA"

        // 配置RecyclerView
        recyclerView.layoutManager = LinearLayoutManager(this)
        adapter = AppListAdapter(appList) { appInfo ->
            onAppClick(appInfo)
        }
        recyclerView.adapter = adapter
    }

    /**
     * 检查Root权限
     */
    private fun checkRootAccess() {
        CoroutineScope(Dispatchers.IO).launch {
            hasRootAccess = checkRoot()
            withContext(Dispatchers.Main) {
                if (hasRootAccess) {
                    tvStatus.text = "✓ 已获取Root权限 - 点击应用触发授权"
                    tvStatus.setTextColor(0xFF4CAF50.toInt())
                } else {
                    tvStatus.text = "✗ 未获取Root权限 - 请先授予本应用Root权限"
                    tvStatus.setTextColor(0xFFF44336.toInt())
                    // 尝试请求Root权限
                    requestRootAccess()
                }
            }
        }
    }

    /**
     * 检查是否有Root权限
     */
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

    /**
     * 请求Root权限
     */
    private fun requestRootAccess() {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                val process = Runtime.getRuntime().exec("su")
                val os = DataOutputStream(process.outputStream)
                os.writeBytes("id\n")
                os.writeBytes("exit\n")
                os.flush()
                process.waitFor()
                
                // 重新检查Root状态
                delay(1000)
                hasRootAccess = checkRoot()
                withContext(Dispatchers.Main) {
                    if (hasRootAccess) {
                        tvStatus.text = "✓ 已获取Root权限 - 点击应用触发授权"
                        tvStatus.setTextColor(0xFF4CAF50.toInt())
                    }
                }
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }

    /**
     * 加载已安装的应用列表
     */
    private fun loadInstalledApps() {
        CoroutineScope(Dispatchers.IO).launch {
            val pm = packageManager
            val packages = try {
                pm.getInstalledApplications(PackageManager.GET_META_DATA)
            } catch (e: Exception) {
                withContext(Dispatchers.Main) {
                    Toast.makeText(this@MainActivity, "无法获取应用列表，请检查权限", Toast.LENGTH_LONG).show()
                }
                return@launch
            }

            val apps = packages.mapNotNull { appInfo ->
                try {
                    val appName = pm.getApplicationLabel(appInfo).toString()
                    val packageName = appInfo.packageName
                    val icon = pm.getApplicationIcon(appInfo)
                    val uid = appInfo.uid
                    val isSystemApp = (appInfo.flags and ApplicationInfo.FLAG_SYSTEM) != 0
                    AppInfo(appName, packageName, icon, uid, isSystemApp)
                } catch (e: Exception) {
                    null
                }
            }.sortedWith(compareBy({ it.isSystemApp }, { it.appName.lowercase() }))

            withContext(Dispatchers.Main) {
                appList.clear()
                appList.addAll(apps)
                adapter.notifyDataSetChanged()
            }
        }
    }

    /**
     * 应用点击事件 - 触发目标应用的Root权限申请
     */
    private fun onAppClick(appInfo: AppInfo) {
        if (!hasRootAccess) {
            Toast.makeText(this, "请先授予本应用Root权限", Toast.LENGTH_SHORT).show()
            requestRootAccess()
            return
        }

        AlertDialog.Builder(this)
            .setTitle("触发Root授权")
            .setMessage("是否为 ${appInfo.appName} 触发Root权限申请弹窗？\n\n包名: ${appInfo.packageName}\nUID: ${appInfo.uid}")
            .setPositiveButton("确定") { _, _ ->
                triggerRootRequest(appInfo)
            }
            .setNegativeButton("取消", null)
            .show()
    }

    /**
     * 以目标应用身份触发Root权限申请
     * 原理：使用su命令切换到目标应用的UID，然后执行su请求
     */
    private fun triggerRootRequest(appInfo: AppInfo) {
        CoroutineScope(Dispatchers.IO).launch {
            try {
                // 方法1: 使用su的uid参数以目标应用身份请求root
                val commands = arrayOf(
                    "su ${appInfo.uid} -c su",
                    "su -c 'su ${appInfo.uid} -c su'"
                )
                
                var success = false
                for (cmd in commands) {
                    try {
                        val process = Runtime.getRuntime().exec(arrayOf("su", "-c", cmd))
                        // 不等待完成，让授权弹窗显示
                        delay(500)
                        success = true
                        break
                    } catch (e: Exception) {
                        continue
                    }
                }

                withContext(Dispatchers.Main) {
                    if (success) {
                        Toast.makeText(
                            this@MainActivity,
                            "已触发 ${appInfo.appName} 的Root授权请求",
                            Toast.LENGTH_SHORT
                        ).show()
                    } else {
                        Toast.makeText(
                            this@MainActivity,
                            "触发失败，请检查Root管理器设置",
                            Toast.LENGTH_SHORT
                        ).show()
                    }
                }
            } catch (e: Exception) {
                withContext(Dispatchers.Main) {
                    Toast.makeText(
                        this@MainActivity,
                        "执行失败: ${e.message}",
                        Toast.LENGTH_SHORT
                    ).show()
                }
            }
        }
    }

    /**
     * 应用信息数据类
     */
    data class AppInfo(
        val appName: String,
        val packageName: String,
        val icon: Drawable,
        val uid: Int,
        val isSystemApp: Boolean
    )

    /**
     * 应用列表适配器
     */
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
            val view = LayoutInflater.from(parent.context)
                .inflate(R.layout.item_app, parent, false)
            return ViewHolder(view)
        }

        override fun onBindViewHolder(holder: ViewHolder, position: Int) {
            val app = apps[position]
            holder.ivIcon.setImageDrawable(app.icon)
            holder.tvAppName.text = app.appName
            holder.tvPackageName.text = app.packageName
            holder.tvUid.text = "UID: ${app.uid}"
            
            // 系统应用标记
            if (app.isSystemApp) {
                holder.tvAppName.setTextColor(0xFF888888.toInt())
            } else {
                holder.tvAppName.setTextColor(0xFF000000.toInt())
            }

            holder.itemView.setOnClickListener {
                onItemClick(app)
            }
        }

        override fun getItemCount() = apps.size
    }
}
