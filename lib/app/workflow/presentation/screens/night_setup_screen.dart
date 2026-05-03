import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/workflow_notifier.dart';
import '../widgets/phase_widgets.dart';

const _accent = Color(0xFFF59E0B); // amber – night vibes

class NightSetupScreen extends ConsumerStatefulWidget {
  const NightSetupScreen({super.key});

  @override
  ConsumerState<NightSetupScreen> createState() => _NightSetupScreenState();
}

class _NightSetupScreenState extends ConsumerState<NightSetupScreen> {
  TimeOfDay _wakeTime = const TimeOfDay(hour: 7, minute: 0);
  bool _loading = false;

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _wakeTime,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.dark(primary: _accent),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _wakeTime = picked);
  }

  Future<void> _commit() async {
    setState(() => _loading = true);
    final now = DateTime.now();
    final wakeDateTime = DateTime(
        now.year, now.month, now.day, _wakeTime.hour, _wakeTime.minute);
    await ref.read(workflowNotifierProvider.notifier).commitWakeUpTime(wakeDateTime);
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return PhaseScaffold(
      accent: _accent,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              // Header
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _accent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('NIGHT SETUP',
                    style: TextStyle(
                        color: _accent,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2)),
              ),
              const SizedBox(height: 20),
              const Text('Commit to\nTomorrow',
                  style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.15)),
              const SizedBox(height: 12),
              Text(
                'Set the time you will wake up.\nYour commitment starts here.',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.55),
                    height: 1.5),
              ),
              const SizedBox(height: 48),
              // Time picker card
              GlassCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Wake-Up Time',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.5),
                            letterSpacing: 1)),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _wakeTime.format(context),
                            style: const TextStyle(
                                fontSize: 52,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -1),
                          ),
                        ),
                        IconButton.filled(
                          onPressed: _pickTime,
                          icon: const Icon(Icons.edit_rounded),
                          style: IconButton.styleFrom(
                            backgroundColor: _accent.withOpacity(0.2),
                            foregroundColor: _accent,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Planning lock: 30 min after wake-up',
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.35)),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // Moon/stars decoration
              Center(
                child: Icon(Icons.nights_stay_rounded,
                    size: 80, color: _accent.withOpacity(0.12)),
              ),
              const SizedBox(height: 32),
              AccentButton(
                label: _loading ? 'Committing…' : 'Commit & Start Planning',
                accent: _accent,
                icon: Icons.lock_clock_rounded,
                enabled: !_loading,
                onPressed: _commit,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
