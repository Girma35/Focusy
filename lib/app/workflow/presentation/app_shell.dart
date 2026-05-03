import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/workflow_notifier.dart';
import '../../domain/focus_workflow_state.dart';
import '../screens/night_setup_screen.dart';
import '../screens/planning_locked_screen.dart';
import '../screens/schedule_setup_screen.dart';
import '../screens/focus_armed_screen.dart';
import '../screens/focus_active_screen.dart';
import '../screens/completed_screen.dart';

class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workflowAsync = ref.watch(workflowNotifierProvider);

    return workflowAsync.when(
      loading: () => const _SplashScreen(),
      error: (e, _) => _ErrorScreen(error: e.toString()),
      data: (state) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        child: _screenFor(state.phase),
      ),
    );
  }

  Widget _screenFor(FocusPhase phase) {
    return switch (phase) {
      FocusPhase.nightSetup => const NightSetupScreen(key: ValueKey('night')),
      FocusPhase.planningLocked =>
        const PlanningLockedScreen(key: ValueKey('planning')),
      FocusPhase.scheduleSetup =>
        const ScheduleSetupScreen(key: ValueKey('schedule')),
      FocusPhase.focusArmed =>
        const FocusArmedScreen(key: ValueKey('armed')),
      FocusPhase.focusActive =>
        const FocusActiveScreen(key: ValueKey('active')),
      FocusPhase.completed =>
        const CompletedScreen(key: ValueKey('completed')),
    };
  }
}

// ── Splash ──────────────────────────────────────────────────────────────────

class _SplashScreen extends StatelessWidget {
  const _SplashScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF0A0E1A),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('focusy',
                style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: -1)),
            SizedBox(height: 24),
            CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation(Color(0xFF8B5CF6))),
          ],
        ),
      ),
    );
  }
}

// ── Error ────────────────────────────────────────────────────────────────────

class _ErrorScreen extends StatelessWidget {
  const _ErrorScreen({required this.error});
  final String error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline_rounded,
                  color: Color(0xFFEF4444), size: 48),
              const SizedBox(height: 16),
              const Text('Initialization Error',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
              const SizedBox(height: 8),
              Text(error,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13, color: Colors.white.withOpacity(0.5))),
            ],
          ),
        ),
      ),
    );
  }
}
