package com.jiangtaigong.app

import android.content.Context
import android.content.SharedPreferences
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

/**
 * SU路径管理器
 * 负责管理自定义SU路径的存储、读取和验证
 */
class SuPathManager(context: Context) {
    
    companion object {
        private const val PREFS_NAME = "su_path_prefs"
        private const val KEY_CUSTOM_SU_PATH = "custom_su_path"
        private const val DEFAULT_SU_PATH = "su"
    }
    
    private val prefs: SharedPreferences = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
    
    /**
     * 获取SU路径
     * 如果有自定义路径则返回自定义路径，否则返回默认"su"
     */
    fun getSuPath(): String {
        val customPath = prefs.getString(KEY_CUSTOM_SU_PATH, null)
        return if (customPath.isNullOrBlank()) DEFAULT_SU_PATH else customPath
    }
    
    /**
     * 保存自定义SU路径
     */
    fun saveSuPath(path: String) {
        prefs.edit().putString(KEY_CUSTOM_SU_PATH, path.trim()).apply()
    }
    
    /**
     * 清除保存的SU路径
     */
    fun clearSuPath() {
        prefs.edit().remove(KEY_CUSTOM_SU_PATH).apply()
    }
    
    /**
     * 检查是否有自定义SU路径
     */
    fun hasCustomSuPath(): Boolean {
        val customPath = prefs.getString(KEY_CUSTOM_SU_PATH, null)
        return !customPath.isNullOrBlank()
    }
    
    /**
     * 验证SU路径是否有效
     * 通过执行测试命令来验证
     */
    suspend fun validateSuPath(path: String): Boolean = withContext(Dispatchers.IO) {
        try {
            val process = Runtime.getRuntime().exec(path.trim())
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
}
