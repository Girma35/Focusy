package com.focusy.focusy

import android.accessibilityservice.AccessibilityService
import android.content.Intent
import android.view.accessibility.AccessibilityEvent
import android.util.Log

class AppBlockerService : AccessibilityService() {

    companion object {
        private const val TAG = "AppBlockerService"
        // In a real app, this list comes from Flutter
        var blockedApps = setOf("com.instagram.android", "com.zhiliaoapp.musically", "com.google.android.youtube")
        var isBlockingEnabled = false
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (!isBlockingEnabled) return

        if (event?.eventType == AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED) {
            val packageName = event.packageName?.toString() ?: return
            
            // Check if the opened app is in our blocked list
            if (blockedApps.contains(packageName)) {
                Log.d(TAG, "Blocked app launched: $packageName")
                
                // Immediately return to Home Screen
                val homeIntent = Intent(Intent.ACTION_MAIN).apply {
                    addCategory(Intent.CATEGORY_HOME)
                    flags = Intent.FLAG_ACTIVITY_NEW_TASK
                }
                startActivity(homeIntent)
                
                // Optional: You could launch a "Blocked" overlay screen here instead of just going home
            }
        }
    }

    override fun onInterrupt() {
        // Required method, called when the system interrupts the service
    }
}
