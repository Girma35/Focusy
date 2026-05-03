import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/workflow_notifier.dart';
import '../../domain/focus_workflow_state.dart';
import '../widgets/phase_widgets.dart';

const _accent = Color(0xFF8B5CF6); // purple – planning vibes

class PlanningLockedScreen extends ConsumerStatefulWidget {
  const PlanningLockedScreen({super.key});

  @override
  ConsumerState<PlanningLockedScreen> createState() =>
      _PlanningLockedScreenState();
}

class _PlanningLockedScreenState extends ConsumerState<PlanningLockedScreen> {
  Timer? _uiTimer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _uiTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      final state = ref.read(workflowNotifierProvider).valueOrNull;
      if (state != null) {
        setState(() => _remaining = state.planningRemaining);
      }
    });
  }

  @override
  void dispose() {
    _uiTimer?.cancel();
    super.dispose();
  }

  Future<void> _proceed() async {
    await ref.read(workflowNotifierProvider.notifier).completePlanning();
  }

  Widget _checkItem(String text, {bool done = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: done ? _accent : Colors.transparent,
              border: Border.all(
                  color: done ? _accent : Colors.white.withOpacity(0.25),
                  width: 2),
            ),
            child: done
                ? const Icon(Icons.check_rounded, size: 14, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 14),
          Text(text,
              style: TextStyle(
                  fontSize: 15,
                  color: done
                      ? Colors.white
                      : Colors.white.withOpacity(0.55))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(workflowNotifierProvider).valueOrNull ??
        FocusWorkflowState.initial(DateTime.now());
    _remaining = state.planningRemaining;
    final canLeave = state.canLeavePlanning;

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
                    Icon(Icons.lock_rounded, size: 11, color: _accent),
                    const SizedBox(width: 6),
                    const Text('PLANNING LOCKED',
                        style: TextStyle(
                            color: _accent,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Deep\nPlanning Mode',
                  style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1.15)),
              const SizedBox(height: 12),
              Text(
                canLeave
                    ? 'Planning complete. You\'re ready to lock in your schedule.'
                    : 'No distractions. Use this time to plan your most important work.',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.55),
                    height: 1.5),
              ),
              const SizedBox(height: 36),
              // Countdown ring
              Center(
                child: CountdownRing(
                  remaining: _remaining,
                  total: kPlanningDuration,
                  accent: canLeave ? const Color(0xFF10B981) : _accent,
                  label: canLeave ? 'DONE' : 'REMAINING',
                ),
              ),
              const SizedBox(height: 36),
              // Planning checklist
              GlassCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Planning Checklist',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.white.withOpacity(0.4),
                            letterSpacing: 1)),
                    const SizedBox(height: 8),
                    _checkItem('Review yesterday\'s tasks'),
                    _checkItem('Identify your top 3 priorities'),
                    _checkItem('Block time on your calendar'),
                    _checkItem('Clear your inbox'),
                  ],
                ),
              ),
              const Spacer(),
              AccentButton(
                label: canLeave
                    ? 'Planning Done — Set Schedule'
                    : 'Locked (${_remaining.inMinutes}m ${_remaining.inSeconds.remainder(60)}s remaining)',
                accent: canLeave ? const Color(0xFF10B981) : _accent,
                icon: canLeave ? Icons.arrow_forward_rounded : Icons.lock_rounded,
                enabled: canLeave,
                onPressed: _proceed,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
