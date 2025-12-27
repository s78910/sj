package com.jiangtaigong.app

import android.Manifest
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Environment
import android.provider.Settings
import android.app.AlertDialog
import android.graphics.Color
import android.text.SpannableStringBuilder
import android.text.Spanned
import android.text.style.ForegroundColorSpan
import android.widget.Button
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.lifecycle.lifecycleScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.io.BufferedReader
import java.io.File
import java.io.InputStreamReader

/**
 * 主Activity - 提供清理功能界面
 * 支持Root权限执行shell脚本
 * 支持自定义SU路径
 */
class MainActivity : AppCompatActivity() {

    private lateinit var btnClean: Button
    private lateinit var btnReboot: Button
    private lateinit var tvOutput: TextView
    private lateinit var suPathManager: SuPathManager
    private val PERMISSION_REQUEST_CODE = 1001
    private val MANAGE_STORAGE_REQUEST_CODE = 1002

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        suPathManager = SuPathManager(this)
        initViews()
        showStartupDialog()
    }

    /**
     * 初始化视图组件
     */
    private fun initViews() {
        btnClean = findViewById(R.id.btnClean)
        btnReboot = findViewById(R.id.btnReboot)
        tvOutput = findViewById(R.id.tvOutput)

        btnClean.setOnClickListener {
            showCleanNoticeDialog()
        }
        
        btnReboot.setOnClickListener {
            showRebootConfirmDialog()
        }
    }

    /**
     * 请求必要的权限
     */
    private fun requestPermissions() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val permissions = mutableListOf<String>()

            // Android 11-12 需要的权限
            if (Build.VERSION.SDK_INT <= Build.VERSION_CODES.S_V2) {
                if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_EXTERNAL_STORAGE)
                    != PackageManager.PERMISSION_GRANTED) {
                    permissions.add(Manifest.permission.READ_EXTERNAL_STORAGE)
                }
                if (ContextCompat.checkSelfPermission(this, Manifest.permission.WRITE_EXTERNAL_STORAGE)
                    != PackageManager.PERMISSION_GRANTED) {
                    permissions.add(Manifest.permission.WRITE_EXTERNAL_STORAGE)
                }
            }

            // Android 13+ 需要的权限
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                if (ContextCompat.checkSelfPermission(this, Manifest.permission.READ_MEDIA_IMAGES)
                    != PackageManager.PERMISSION_GRANTED) {
                    permissions.add(Manifest.permission.READ_MEDIA_IMAGES)
                }
            }

            if (permissions.isNotEmpty()) {
                ActivityCompat.requestPermissions(this, permissions.toTypedArray(), PERMISSION_REQUEST_CODE)
            }
        }
        
        // Android 11+ 请求MANAGE_EXTERNAL_STORAGE权限
        requestManageStoragePermission()
    }
    
    /**
     * 请求MANAGE_EXTERNAL_STORAGE权限 (Android 11+)
     */
    private fun requestManageStoragePermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            if (!Environment.isExternalStorageManager()) {
                AlertDialog.Builder(this)
                    .setTitle(getString(R.string.startup_dialog_title))
                    .setMessage(getString(R.string.manage_storage_required))
                    .setPositiveButton(getString(R.string.go_to_settings)) { _, _ ->
                        try {
                            val intent = Intent(Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION)
                            intent.data = Uri.parse("package:$packageName")
                            startActivityForResult(intent, MANAGE_STORAGE_REQUEST_CODE)
                        } catch (e: Exception) {
                            val intent = Intent(Settings.ACTION_MANAGE_ALL_FILES_ACCESS_PERMISSION)
                            startActivityForResult(intent, MANAGE_STORAGE_REQUEST_CODE)
                        }
                    }
                    .setNegativeButton(getString(R.string.no), null)
                    .show()
            }
        }
    }
    
    /**
     * 显示启动弹窗
     * 每次启动都显示权限请求和推广信息
     */
    private fun showStartupDialog() {
        AlertDialog.Builder(this)
            .setTitle(getString(R.string.startup_dialog_title))
            .setMessage(getString(R.string.startup_dialog_message))
            .setPositiveButton(getString(R.string.startup_dialog_confirm)) { _, _ ->
                requestPermissions()
            }
            .setCancelable(false)
            .show()
    }
    
    /**
     * 显示SU路径输入对话框
     * 当Root权限检测失败时调用
     */
    private fun showSuPathInputDialog(onPathValidated: () -> Unit) {
        val editText = EditText(this).apply {
            hint = getString(R.string.su_path_hint)
            setPadding(50, 30, 50, 30)
            // 如果有保存的路径，显示出来
            if (suPathManager.hasCustomSuPath()) {
                setText(suPathManager.getSuPath())
            }
        }
        
        AlertDialog.Builder(this)
            .setTitle(getString(R.string.su_path_dialog_title))
            .setMessage(getString(R.string.su_path_dialog_message))
            .setView(editText)
            .setPositiveButton(getString(R.string.yes)) { _, _ ->
                val inputPath = editText.text.toString().trim()
                if (inputPath.isNotEmpty()) {
                    validateAndSaveSuPath(inputPath, onPathValidated)
                } else {
                    Toast.makeText(this, getString(R.string.su_path_invalid), Toast.LENGTH_SHORT).show()
                }
            }
            .setNegativeButton(getString(R.string.no), null)
            .setCancelable(false)
            .show()
    }
    
    /**
     * 验证并保存SU路径
     */
    private fun validateAndSaveSuPath(path: String, onSuccess: () -> Unit) {
        lifecycleScope.launch {
            updateOutput(getString(R.string.su_path_validating))
            
            val isValid = suPathManager.validateSuPath(path)
            
            if (isValid) {
                suPathManager.saveSuPath(path)
                updateOutput(getString(R.string.su_path_valid), true)
                Toast.makeText(this@MainActivity, getString(R.string.su_path_saved), Toast.LENGTH_SHORT).show()
                onSuccess()
            } else {
                updateOutput(getString(R.string.su_path_invalid) + "\n", true)
                Toast.makeText(this@MainActivity, getString(R.string.su_path_invalid), Toast.LENGTH_SHORT).show()
                // 重新显示输入对话框
                showSuPathInputDialog(onSuccess)
            }
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == PERMISSION_REQUEST_CODE) {
            val allGranted = grantResults.all { it == PackageManager.PERMISSION_GRANTED }
            if (!allGranted) {
                Toast.makeText(this, getString(R.string.permission_storage_required), Toast.LENGTH_SHORT).show()
            }
        }
    }

    /**
     * 执行清理脚本
     */
    private fun executeCleanScript() {
        lifecycleScope.launch {
            try {
                btnClean.isEnabled = false
                
                // 首先从assets复制脚本到应用私有目录
                updateOutput(getString(R.string.copying_script))
                copyScriptFromAssets("anqu.sh")
                
                updateOutput(getString(R.string.checking_root))

                // 检查Root权限
                val hasRoot = checkRootAccess()
                if (!hasRoot) {
                    updateOutput(getString(R.string.root_denied), true)
                    // 显示SU路径输入对话框
                    withContext(Dispatchers.Main) {
                        showSuPathInputDialog {
                            // 路径验证成功后重新执行清理
                            executeCleanScript()
                        }
                    }
                    btnClean.isEnabled = true
                    return@launch
                }

                // 显示使用的SU路径
                if (suPathManager.hasCustomSuPath()) {
                    updateOutput(getString(R.string.su_path_using_custom, suPathManager.getSuPath()), true)
                }
                updateOutput(getString(R.string.root_granted), true)

                // 查找脚本文件
                val scriptFile = findScriptFile("anqu.sh")
                if (scriptFile == null || !scriptFile.exists()) {
                    updateOutput(getString(R.string.script_not_found), true)
                    Toast.makeText(this@MainActivity, getString(R.string.script_not_found_toast), Toast.LENGTH_SHORT).show()
                    btnClean.isEnabled = true
                    return@launch
                }

                // 执行脚本（删除了"找到脚本"和"正在执行"提示）
                val result = executeRootCommand("sh ${scriptFile.absolutePath}")
                
                // 过滤掉sed错误和chmod错误
                val filteredResult = result.split("\n").filter { line ->
                    !line.contains("sed: no previous regex") &&
                    !line.contains("chmod:") &&
                    !line.contains("No such file or directory") ||
                    (!line.contains("chmod") && line.contains("No such file or directory"))
                }.joinToString("\n")
                
                updateOutputWithColor(filteredResult)

                Toast.makeText(this@MainActivity, getString(R.string.execution_complete), Toast.LENGTH_SHORT).show()

            } catch (e: Exception) {
                updateOutput(getString(R.string.execution_error, e.message ?: ""), true)
                Toast.makeText(this@MainActivity, getString(R.string.execution_failed, e.message ?: ""), Toast.LENGTH_SHORT).show()
            } finally {
                btnClean.isEnabled = true
            }
        }
    }

    /**
     * 检查Root权限
     * 使用SuPathManager获取SU路径
     * @return 是否有Root权限
     */
    private suspend fun checkRootAccess(): Boolean = withContext(Dispatchers.IO) {
        try {
            val suPath = suPathManager.getSuPath()
            val process = Runtime.getRuntime().exec(suPath)
            val outputStream = process.outputStream
            outputStream.write("exit\n".toByteArray())
            outputStream.flush()
            outputStream.close()
            process.waitFor()
            process.exitValue() == 0
        } catch (e: Exception) {
            false
        }
    }

    /**
     * 从assets复制脚本到应用私有目录
     */
    private fun copyScriptFromAssets(scriptName: String) {
        try {
            val outputFile = File(filesDir, scriptName)
            
            // 从assets读取
            assets.open(scriptName).use { input ->
                outputFile.outputStream().use { output ->
                    input.copyTo(output)
                }
            }
            
            // 设置可执行权限
            outputFile.setExecutable(true, false)
            outputFile.setReadable(true, false)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    /**
     * 查找脚本文件
     * 按优先级在多个可能的位置查找
     */
    private fun findScriptFile(scriptName: String): File? {
        // 优先使用应用私有目录（已从assets复制）
        val appPrivateScript = File(filesDir, scriptName)
        if (appPrivateScript.exists() && appPrivateScript.canRead()) {
            return appPrivateScript
        }
        
        // 其他可能的脚本位置列表
        val possibleLocations = listOf(
            File(Environment.getExternalStorageDirectory(), scriptName),
            File(Environment.getExternalStoragePublicDirectory(Environment.DIRECTORY_DOWNLOADS), scriptName),
            File(getExternalFilesDir(null), scriptName),
            File("/sdcard/$scriptName"),
            File("/data/local/tmp/$scriptName")
        )

        for (location in possibleLocations) {
            if (location.exists() && location.canRead()) {
                return location
            }
        }

        return null
    }

    /**
     * 递归搜索文件
     */
    private fun searchFileRecursively(directory: File, fileName: String, maxDepth: Int = 3, currentDepth: Int = 0): File? {
        if (currentDepth > maxDepth) return null
        if (!directory.isDirectory || !directory.canRead()) return null

        try {
            directory.listFiles()?.forEach { file ->
                if (file.name == fileName && file.isFile) {
                    return file
                }
                if (file.isDirectory && currentDepth < maxDepth) {
                    searchFileRecursively(file, fileName, maxDepth, currentDepth + 1)?.let {
                        return it
                    }
                }
            }
        } catch (e: Exception) {
            // 忽略无权限访问的目录
        }

        return null
    }

    /**
     * 执行Root命令
     * 使用SuPathManager获取SU路径
     * @param command 要执行的命令
     * @return 命令输出结果
     */
    private suspend fun executeRootCommand(command: String): String = withContext(Dispatchers.IO) {
        val output = StringBuilder()
        var process: Process? = null

        try {
            // 使用自定义SU路径请求su权限并执行命令
            val suPath = suPathManager.getSuPath()
            process = Runtime.getRuntime().exec(suPath)
            val outputStream = process.outputStream
            val inputStream = process.inputStream
            val errorStream = process.errorStream

            // 写入命令
            outputStream.write("$command\n".toByteArray())
            outputStream.write("exit\n".toByteArray())
            outputStream.flush()

            // 读取标准输出
            val reader = BufferedReader(InputStreamReader(inputStream))
            val errorReader = BufferedReader(InputStreamReader(errorStream))

            // 在协程中同时读取输出和错误流
            val outputLines = mutableListOf<String>()
            val errorLines = mutableListOf<String>()

            // 读取标准输出
            var line: String?
            while (reader.readLine().also { line = it } != null) {
                line?.let {
                    outputLines.add(it)
                    // 实时更新UI
                    withContext(Dispatchers.Main) {
                        updateOutput("$it\n", true)
                    }
                }
            }

            // 读取错误输出
            while (errorReader.readLine().also { line = it } != null) {
                line?.let {
                    errorLines.add(it)
                }
            }

            // 等待进程结束
            val exitCode = process.waitFor()

            // 组合输出
            if (outputLines.isNotEmpty()) {
                output.append(outputLines.joinToString("\n"))
            }

            if (errorLines.isNotEmpty()) {
                output.append("\n[错误输出]:\n")
                output.append(errorLines.joinToString("\n"))
            }

            if (exitCode != 0) {
                output.append("\n\n[进程退出码: $exitCode]")
            }

            reader.close()
            errorReader.close()
            outputStream.close()

        } catch (e: Exception) {
            output.append("\n执行异常: ${e.message}\n")
            e.printStackTrace()
        } finally {
            process?.destroy()
        }

        output.toString()
    }

    /**
     * 更新输出文本
     * @param text 要显示的文本
     * @param append 是否追加(true)还是替换(false)
     */
    private suspend fun updateOutput(text: String, append: Boolean = false) {
        withContext(Dispatchers.Main) {
            if (append) {
                tvOutput.append(text)
            } else {
                tvOutput.text = text
            }

            // 自动滚动到底部
            val scrollView = tvOutput.parent as? android.widget.ScrollView
            scrollView?.post {
                scrollView.fullScroll(android.view.View.FOCUS_DOWN)
            }
        }
    }
    
    /**
     * 更新输出文本并支持ANSI颜色代码
     * @param text 包含ANSI颜色代码的文本
     */
    private suspend fun updateOutputWithColor(text: String) {
        withContext(Dispatchers.Main) {
            val spannable = SpannableStringBuilder()
            
            // ANSI颜色代码映射
            val ansiColorMap = mapOf(
                "30" to Color.BLACK,
                "31" to Color.RED,
                "32" to Color.GREEN,
                "33" to Color.YELLOW,
                "34" to Color.BLUE,
                "35" to Color.MAGENTA,
                "36" to Color.CYAN,
                "37" to Color.WHITE,
                "90" to Color.DKGRAY,
                "91" to Color.rgb(255, 100, 100),
                "92" to Color.rgb(100, 255, 100),
                "93" to Color.rgb(255, 255, 100),
                "94" to Color.rgb(100, 100, 255),
                "95" to Color.rgb(255, 100, 255),
                "96" to Color.rgb(100, 255, 255),
                "97" to Color.rgb(240, 240, 240)
            )
            
            // 解析ANSI颜色代码
            val ansiRegex = Regex("\\x1B\\[(\\d+)m")
            var lastEnd = 0
            var currentColor: Int? = null
            
            ansiRegex.findAll(text).forEach { match ->
                // 添加前面的普通文本
                val beforeText = text.substring(lastEnd, match.range.first)
                val start = spannable.length
                spannable.append(beforeText)
                
                // 如果有当前颜色，应用到前面的文本
                if (currentColor != null && beforeText.isNotEmpty()) {
                    spannable.setSpan(
                        ForegroundColorSpan(currentColor!!),
                        start,
                        spannable.length,
                        Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
                    )
                }
                
                // 更新当前颜色
                val colorCode = match.groupValues[1]
                currentColor = when (colorCode) {
                    "0" -> null  // 重置颜色
                    else -> ansiColorMap[colorCode]
                }
                
                lastEnd = match.range.last + 1
            }
            
            // 添加剩余文本
            val remainingText = text.substring(lastEnd)
            val start = spannable.length
            spannable.append(remainingText)
            if (currentColor != null && remainingText.isNotEmpty()) {
                spannable.setSpan(
                    ForegroundColorSpan(currentColor!!),
                    start,
                    spannable.length,
                    Spanned.SPAN_EXCLUSIVE_EXCLUSIVE
                )
            }
            
            // 显示处理后的文本
            tvOutput.append(spannable)
            
            // 自动滚动到底部
            val scrollView = tvOutput.parent as? android.widget.ScrollView
            scrollView?.post {
                scrollView.fullScroll(android.view.View.FOCUS_DOWN)
            }
        }
    }
    
    /**
     * 显示清理前的重要提示对话框
     */
    private fun showCleanNoticeDialog() {
        AlertDialog.Builder(this)
            .setTitle(getString(R.string.clean_notice_title))
            .setMessage(getString(R.string.clean_notice_message))
            .setPositiveButton(getString(R.string.i_know)) { _, _ ->
                executeCleanScript()
            }
            .setCancelable(false)
            .show()
    }
    
    /**
     * 显示重启确认对话框
     */
    private fun showRebootConfirmDialog() {
        AlertDialog.Builder(this)
            .setTitle(getString(R.string.btn_reboot))
            .setMessage(getString(R.string.reboot_confirm))
            .setPositiveButton(getString(R.string.yes)) { _, _ ->
                executeReboot()
            }
            .setNegativeButton(getString(R.string.no), null)
            .show()
    }
    
    /**
     * 执行重启命令
     */
    private fun executeReboot() {
        lifecycleScope.launch {
            try {
                Toast.makeText(this@MainActivity, getString(R.string.rebooting), Toast.LENGTH_SHORT).show()
                
                withContext(Dispatchers.IO) {
                    val suPath = suPathManager.getSuPath()
                    val process = Runtime.getRuntime().exec(suPath)
                    val outputStream = process.outputStream
                    outputStream.write("reboot\n".toByteArray())
                    outputStream.flush()
                    outputStream.close()
                }
            } catch (e: Exception) {
                Toast.makeText(this@MainActivity, "重启失败: ${e.message}", Toast.LENGTH_SHORT).show()
            }
        }
    }
}
