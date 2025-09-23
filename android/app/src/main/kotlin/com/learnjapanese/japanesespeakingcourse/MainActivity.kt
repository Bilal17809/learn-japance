package com.learnjapanese.japanesespeakingcourse

import android.Manifest
import android.content.Intent
import android.speech.RecognizerIntent
import android.app.Activity
import android.content.pm.PackageManager
import android.os.Build
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "speech_channel"
    private val SPEECH_REQUEST_CODE = 1001
    private val PERMISSION_REQUEST_CODE = 1002
    private var pendingResult: MethodChannel.Result? = null
    private var pendingLanguageISO: String? = null

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "getTextFromSpeech" -> {
                        val languageISO: String = call.argument("languageISO") ?: "en_US"

                        if (checkAudioPermission()) {
                            startSpeechRecognition(languageISO, result)
                        } else {
                            requestAudioPermission(languageISO, result)
                        }
                    }
                    "translateText" -> {
                        val text: String = call.argument("text") ?: ""
                        val sourceLanguage: String = call.argument("sourceLanguage") ?: ""
                        val targetLanguage: String = call.argument("targetLanguage") ?: ""
                        val translatedText = "$text [Translated to $targetLanguage]"
                        result.success(translatedText)
                    }
                    else -> result.notImplemented()
                }
            }
    }

    private fun checkAudioPermission(): Boolean {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            ContextCompat.checkSelfPermission(this, Manifest.permission.RECORD_AUDIO) == PackageManager.PERMISSION_GRANTED
        } else {
            true
        }
    }

    private fun requestAudioPermission(languageISO: String, result: MethodChannel.Result) {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            pendingResult = result
            pendingLanguageISO = languageISO
            ActivityCompat.requestPermissions(
                this,
                arrayOf(Manifest.permission.RECORD_AUDIO),
                PERMISSION_REQUEST_CODE
            )
        } else {
            startSpeechRecognition(languageISO, result)
        }
    }

    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<out String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == PERMISSION_REQUEST_CODE) {
            if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                pendingLanguageISO?.let { languageISO ->
                    pendingResult?.let { result ->
                        startSpeechRecognition(languageISO, result)
                    }
                }
            } else {
                pendingResult?.error("PermissionError", "Audio recording permission is required for speech recognition", null)
                pendingResult = null
            }
            pendingLanguageISO = null
        }
    }

    private fun startSpeechRecognition(languageISO: String, result: MethodChannel.Result) {
        pendingResult = result
        val intent = Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH).apply {
            putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM)
            // Use the dynamic language instead of hardcoded "en-US"
            putExtra(RecognizerIntent.EXTRA_LANGUAGE, languageISO)
            putExtra(RecognizerIntent.EXTRA_PROMPT, "Speak now...")
            putExtra(RecognizerIntent.EXTRA_MAX_RESULTS, 1)
            putExtra(RecognizerIntent.EXTRA_PREFER_OFFLINE, false)
            if (languageISO.isNotEmpty()) {
                val supportedLanguages = arrayOf(languageISO)
                putExtra(RecognizerIntent.EXTRA_SUPPORTED_LANGUAGES, supportedLanguages)
            }
        }

        try {
            if (intent.resolveActivity(packageManager) != null) {
                startActivityForResult(intent, SPEECH_REQUEST_CODE)
            } else {
                pendingResult?.error("SpeechError", "Speech recognition not available on this device", null)
                pendingResult = null
            }
        } catch (e: Exception) {
            pendingResult?.error("SpeechError", "Failed to start speech recognition: ${e.message}", null)
            pendingResult = null
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == SPEECH_REQUEST_CODE) {
            when (resultCode) {
                Activity.RESULT_OK -> {
                    data?.let {
                        val results = it.getStringArrayListExtra(RecognizerIntent.EXTRA_RESULTS)
                        if (results != null && results.isNotEmpty()) {
                            pendingResult?.success(results[0])
                        } else {
                            pendingResult?.error("SpeechError", "No speech recognized", null)
                        }
                    } ?: run {
                        pendingResult?.error("SpeechError", "No data received from speech recognition", null)
                    }
                }
                Activity.RESULT_CANCELED -> {
                    pendingResult?.error("SpeechError", "Speech recognition was cancelled", null)
                }
                else -> {
                    pendingResult?.error("SpeechError", "Speech recognition failed with result code: $resultCode", null)
                }
            }
            pendingResult = null
        }
    }
}