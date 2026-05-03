import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/workflow_notifier.dart';
import '../widgets/phase_widgets.dart';

const _accent = Color(0xFF06B6D4); // cyan – scheduling vibes

class ScheduleSetupScreen extends ConsumerStatefulWidget {
  const ScheduleSetupScreen({super.key});

  @override
  ConsumerState<ScheduleSetupScreen> createState() =>
      _ScheduleSetupScreenState();
}

class _ScheduleSetupScreenState extends ConsumerState<ScheduleSetupScreen> {
  TimeOfDay _workStart = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _workEnd = const TimeOfDay(hour: 17, minute: 0);
  bool _loading = false;

  Future<void> _pickStart() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _workStart,
      helpText: 'Work Start Time',
      builder: (c, child) => Theme(
          data: Theme.of(c).copyWith(
              colorScheme: const ColorScheme.dark(primary: _accent)),
          child: child!),
    );
    if (picked != null) setState(() => _workStart = picked);
  }

  Future<void> _pickEnd() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _workEnd,
      helpText: 'Work End Time',
      builder: (c, child) => Theme(
          data: Theme.of(c).copyWith(
              colorScheme: const ColorScheme.dark(primary: _accent)),
          child: child!),
    );
    if (picked != null) setState(() => _workEnd = picked);
  }

  Future<void> _lockIn() async {
    final now = DateTime.now();
    final start = DateTime(
        now.year, now.month, now.day, _workStart.hour, _workStart.minute);
    final end =
        DateTime(now.year, now.month, now.day, _workEnd.hour, _workEnd.minute);
    if (!end.isAfter(start)) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('End time must be after start time'),
        backgroundColor: Color(0xFFEF4444),
      ));
      return;
    }
    setState(() => _loading = true);
    await ref.read(workflowNotifierProvider.notifier).setWorkSchedule(
          workStart: start,
          workEnd: end,
        );
    if (mounted) setState(() => _loading = false);
  }

  Widget _timeCard(String label, TimeOfDay time, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: GlassCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 11,
                      color: Colors.white.withOpacity(0.45),
                      letterSpacing: 1.5)),
              const SizedBox(height: 10),
              Text(time.format(context),
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _accent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text('Tap to change',
                    style:
                        TextStyle(fontSize: 10, color: _accent)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Duration display
    final now = DateTime.now();
    final start =
        DateTime(now.year, now.month, now.day, _workStart.hour, _workStart.minute);
    final end =
        DateTime(now.year, now.month, now.day, _workEnd.hour, _workEnd.minute);
    final focusDuration = end.isAfter(start) ? end.difference(start) : Duration.zero;
    final hours = focusDuration.inHours;
    final minutes = focusDuration.inMinutes.remainder(60);

    return PhaseScaffold(
      accent: _accent,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _accent.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('SCHEDULE SETUP',
                    style: TextStyle(
                        color: _accent,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2)),
              ),
              const SizedBox(height: 20),
              const Text('Lock In\nYour Day',
                  style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.15)),
              const SizedBox(height: 12),
              Text(
                'Define your focus window. Once set, the app arms itself for deep work.',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.55),
                    height: 1.5),
              ),
              const SizedBox(height: 36),
              Row(
                children: [
                  _timeCard('WORK START', _workStart, _pickStart),
                  const SizedBox(width: 12),
                  _timeCard('WORK END', _workEnd, _pickEnd),
                ],
              ),
              const SizedBox(height: 16),
              // Focus duration summary
              GlassCard(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Row(
                  children: [
                    Icon(Icons.timer_rounded, color: _accent),
                    const SizedBox(width: 12),
                    Text(
                      focusDuration > Duration.zero
                          ? 'Focus session: ${hours}h ${minutes}m'
                          : 'Set a valid time window',
                      style: const TextStyle(
                          fontSize: 15, color: Colors.white),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              AccentButton(
                label: _loading ? 'Arming…' : 'Lock In & Arm Focus',
                accent: _accent,
                icon: Icons.shield_rounded,
                enabled: !_loading && focusDuration > Duration.zero,
                onPressed: _lockIn,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
