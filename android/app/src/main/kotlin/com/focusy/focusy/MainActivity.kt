package com.focusy.focusy

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.focusy/blocker"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            when (call.method) {
                "startBlocking" -> {
                    AppBlockerService.isBlockingEnabled = true
                    result.success(null)
                }
                "stopBlocking" -> {
                    AppBlockerService.isBlockingEnabled = false
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
