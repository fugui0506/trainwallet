package com.example.cgwallet

import android.content.ContentValues
import android.content.Context
import android.os.Build
import android.provider.MediaStore
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File
import java.io.FileInputStream

class ImageHandler(private val context: Context) : MethodChannel.MethodCallHandler {
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "saveImageToGallery" -> {
                val imagePath = call.argument<String>("path")
                if (imagePath != null) {
                    saveImageToGallery(imagePath, result)
                } else {
                    result.error("INVALID_ARGUMENT", "Image path is required", null)
                }
            }
            else -> result.notImplemented()
        }
    }

    private fun saveImageToGallery(imagePath: String, result: MethodChannel.Result) {
        try {
            val file = File(imagePath)
            val values = ContentValues().apply {
                put(MediaStore.Images.Media.DISPLAY_NAME, file.name)
                put(MediaStore.Images.Media.MIME_TYPE, "image/png")
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                    put(MediaStore.Images.Media.RELATIVE_PATH, "Pictures/Wallet")
                    put(MediaStore.Images.Media.IS_PENDING, 1)
                }
            }

            val resolver = context.contentResolver
            val uri = resolver.insert(MediaStore.Images.Media.EXTERNAL_CONTENT_URI, values)

            uri?.let { contentUri ->
                resolver.openOutputStream(contentUri)?.use { outputStream ->
                    FileInputStream(file).use { inputStream ->
                        inputStream.copyTo(outputStream)
                    }

                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                        values.clear()
                        values.put(MediaStore.Images.Media.IS_PENDING, 0)
                        resolver.update(contentUri, values, null, null)
                    }

                    result.success(true)
                } ?: run {
                    result.error("SAVE_FAILED", "Failed to open output stream", null)
                }
            } ?: run {
                result.error("SAVE_FAILED", "Failed to create new MediaStore record", null)
            }
        } catch (e: Exception) {
            result.error("SAVE_FAILED", "Exception occurred: ${e.message}", null)
        }
    }
}
