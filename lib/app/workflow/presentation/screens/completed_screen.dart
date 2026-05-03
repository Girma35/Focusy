import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/workflow_notifier.dart';
import '../../domain/focus_workflow_state.dart';
import '../widgets/phase_widgets.dart';

const _accent = Color(0xFF10B981); // emerald – victory

class CompletedScreen extends ConsumerWidget {
  const CompletedScreen({super.key});

  String _formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    if (h == 0) return '${m}m';
    if (m == 0) return '${h}h';
    return '${h}h ${m}m';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(workflowNotifierProvider).valueOrNull ??
        FocusWorkflowState.initial(DateTime.now());

    final focusDuration =
        (state.workStartTime != null && state.workEndTime != null)
            ? state.workEndTime!.difference(state.workStartTime!)
            : Duration.zero;

    return PhaseScaffold(
      accent: _accent,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),
              // Trophy icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _accent.withOpacity(0.12),
                  border: Border.all(color: _accent.withOpacity(0.3), width: 2),
                ),
                child: const Icon(Icons.emoji_events_rounded,
                    size: 52, color: _accent),
              ),
              const SizedBox(height: 28),
              const Text('Day Complete!',
                  style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w800,
                      color: Colors.white)),
              const SizedBox(height: 12),
              Text(
                'You committed. You executed. You won the day.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.55),
                    height: 1.5),
              ),
              const SizedBox(height: 40),
              // Stats
              GlassCard(
                child: Column(
                  children: [
                    _statRow('Focus Duration',
                        focusDuration > Duration.zero
                            ? _formatDuration(focusDuration)
                            : '—'),
                    const Divider(color: Colors.white12, height: 28),
                    _statRow('Wake-Up Time',
                        state.wakeUpTime != null
                            ? TimeOfDay.fromDateTime(state.wakeUpTime!)
                                .format(context)
                            : '—'),
                    const Divider(color: Colors.white12, height: 28),
                    _statRow('Apps Blocked',
                        state.appsBlocked ? 'Yes ✓' : 'No'),
                    const Divider(color: Colors.white12, height: 28),
                    _statRow('Calendar Synced',
                        state.calendarSynced ? 'Yes ✓' : 'No'),
                  ],
                ),
              ),
              const Spacer(),
              // Action buttons
              AccentButton(
                label: 'Plan Tomorrow',
                accent: _accent,
                icon: Icons.nights_stay_rounded,
                onPressed: () => ref
                    .read(workflowNotifierProvider.notifier)
                    .resetForNewDay(),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () => ref
                      .read(workflowNotifierProvider.notifier)
                      .resetForNewDay(),
                  icon: const Icon(Icons.refresh_rounded, size: 18),
                  label: const Text('Reset'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white54,
                    side: const BorderSide(color: Colors.white12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style:
                TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.5))),
        Text(value,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white)),
      ],
    );
  }
}
