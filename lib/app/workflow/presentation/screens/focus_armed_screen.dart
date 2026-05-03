import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/workflow_notifier.dart';
import '../../domain/focus_workflow_state.dart';
import '../widgets/phase_widgets.dart';

const _accent = Color(0xFFF97316); // orange – armed/ready

class FocusArmedScreen extends ConsumerStatefulWidget {
  const FocusArmedScreen({super.key});

  @override
  ConsumerState<FocusArmedScreen> createState() => _FocusArmedScreenState();
}

class _FocusArmedScreenState extends ConsumerState<FocusArmedScreen> {
  Timer? _uiTimer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _uiTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      final state = ref.read(workflowNotifierProvider).valueOrNull;
      if (state?.workStartTime != null) {
        final r = state!.workStartTime!.difference(DateTime.now());
        setState(() => _remaining = r.isNegative ? Duration.zero : r);
      }
    });
  }

  @override
  void dispose() {
    _uiTimer?.cancel();
    super.dispose();
  }

  Future<void> _startNow() async {
    await ref.read(workflowNotifierProvider.notifier).startFocusActive();
  }

  String _fmt(TimeOfDay t, BuildContext ctx) => t.format(ctx);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(workflowNotifierProvider).valueOrNull ??
        FocusWorkflowState.initial(DateTime.now());

    final startTime = state.workStartTime;
    final endTime = state.workEndTime;

    final isReady = _remaining == Duration.zero;

    final startTOD = startTime != null
        ? TimeOfDay.fromDateTime(startTime)
        : const TimeOfDay(hour: 9, minute: 0);
    final endTOD = endTime != null
        ? TimeOfDay.fromDateTime(endTime)
        : const TimeOfDay(hour: 17, minute: 0);

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
                  color: _accent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                            color: _accent, shape: BoxShape.circle)),
                    const SizedBox(width: 6),
                    const Text('FOCUS ARMED',
                        style: TextStyle(
                            color: _accent,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                isReady ? 'Ready\nto Focus' : 'Counting\nDown',
                style: const TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.15),
              ),
              const SizedBox(height: 32),
              // Countdown ring
              Center(
                child: CountdownRing(
                  remaining: _remaining,
                  total: const Duration(hours: 3),
                  accent: isReady ? const Color(0xFF10B981) : _accent,
                  label: isReady ? 'START NOW' : 'UNTIL FOCUS',
                ),
              ),
              const SizedBox(height: 32),
              // Session info
              GlassCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _infoRow(
                        Icons.play_arrow_rounded,
                        'Work Starts',
                        _fmt(startTOD, context)),
                    const SizedBox(height: 12),
                    _infoRow(
                        Icons.stop_rounded,
                        'Work Ends',
                        _fmt(endTOD, context)),
                    const SizedBox(height: 12),
                    _infoRow(
                        Icons.block_rounded,
                        'Distraction Block',
                        'Will activate at start'),
                  ],
                ),
              ),
              const Spacer(),
              AccentButton(
                label: isReady ? 'Begin Focus Session' : 'Start Early',
                accent: isReady ? const Color(0xFF10B981) : _accent,
                icon: isReady
                    ? Icons.rocket_launch_rounded
                    : Icons.skip_next_rounded,
                onPressed: _startNow,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: _accent, size: 18),
        const SizedBox(width: 12),
        Expanded(
          child: Text(label,
              style: TextStyle(
                  fontSize: 14, color: Colors.white.withOpacity(0.5))),
        ),
        Text(value,
            style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600)),
      ],
    );
  }
}
