# Focusy

Focusy is a hardcore, single-purpose productivity app designed to force deep work by actively locking down your phone and blocking access to highly distracting apps.

Unlike typical productivity apps that rely purely on willpower or soft timers, Focusy leverages native Android system-level APIs to physically prevent you from leaving the app or launching distractions while your focus timer is active.

## Core Features

- **One-Tap Focus Mode:** A completely simplified, distraction-free UI. Set a timer and hit "START FOCUS."
- **Screen Pinning (App Pinning):** Once activated, Focusy natively calls Android's `startLockTask()`, locking the phone screen directly to the Focusy app. You cannot leave the app until the timer stops or you explicitly choose to stop it.
- **Aggressive Distraction Blocking:** Uses an Android `AccessibilityService` running silently in the background. Even if you somehow bypass the App Pinning, attempting to launch specific distracting apps (like Instagram, TikTok, YouTube) will result in Focusy immediately kicking you back to the home screen.

## Tech Stack

Focusy is built by combining beautiful, reactive UI with low-level Android native code.

- **Frontend / UI:** Flutter & Dart
- **Native Android Communication:** MethodChannels (`io.flutter.plugin.common.MethodChannel`)
- **Native Android Logic:** Kotlin
- **System APIs Used:**
  - `AccessibilityService` (Listens to `typeWindowStateChanged` to detect when banned apps open)
  - `Activity.startLockTask()` / `stopLockTask()` (App Pinning)

## How to Use & Test

Because Focusy uses aggressive, system-level Android permissions to control the device, you must grant it specific rights the very first time you install it.

### Step 1: Install the app
Connect your physical Android device and run:
```bash
flutter run
```

### Step 2: Grant Accessibility Permissions
Before pressing "Start Focus" in the app, you need to allow it to monitor your screen.
1. Open your Android phone's **Settings**.
2. Go to **Accessibility**.
3. Go to **Installed apps** (or "Downloaded apps").
4. Find **focusy** in the list.
5. Toggle it to **ON**.

*(Note: Without this, the background distraction blocker will silently fail).*

### Step 3: Start a Session
Open the Focusy app and click **START FOCUS**.
You will immediately notice two things happen:
1. Android will show a system dialog asking if you want to **Pin this app**. Tap "Got it" or "Yes". The phone is now locked to Focusy.
2. The `AccessibilityService` wakes up.

If you hit **STOP EARLY**, Focusy will gracefully unpin itself and turn off the background blocker.

## Currently Blocked Apps

For the sake of simplicity, the initial version of Focusy has a hardcoded set of distracting apps that it looks for when active:
- Instagram (`com.instagram.android`)
- TikTok (`com.zhiliaoapp.musically`)
- YouTube (`com.google.android.youtube`)

*(In future updates, this list can be dynamically populated from the Flutter UI via the `updateBlockedApps` MethodChannel).*
