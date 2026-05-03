import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/workflow_notifier.dart';
import '../../domain/focus_workflow_state.dart';
import '../widgets/phase_widgets.dart';

const _accent = Color(0xFFEF4444); // red – danger/active

class FocusActiveScreen extends ConsumerStatefulWidget {
  const FocusActiveScreen({super.key});

  @override
  ConsumerState<FocusActiveScreen> createState() => _FocusActiveScreenState();
}

class _FocusActiveScreenState extends ConsumerState<FocusActiveScreen> {
  Timer? _uiTimer;
  Duration _remaining = Duration.zero;
  Duration _elapsed = Duration.zero;

  @override
  void initState() {
    super.initState();
    _uiTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      final state = ref.read(workflowNotifierProvider).valueOrNull;
      if (state?.workEndTime != null && state?.workStartTime != null) {
        final now = DateTime.now();
        final r = state!.workEndTime!.difference(now);
        final e = now.difference(state.workStartTime!);
        setState(() {
          _remaining = r.isNegative ? Duration.zero : r;
          _elapsed = e.isNegative ? Duration.zero : e;
        });
      }
    });
  }

  @override
  void dispose() {
    _uiTimer?.cancel();
    super.dispose();
  }

  Future<void> _endDay() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        backgroundColor: const Color(0xFF131929),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('End Focus Session?',
            style: TextStyle(color: Colors.white)),
        content: Text(
          'Your focus session is still active. Are you sure you want to end it early?',
          style: TextStyle(color: Colors.white.withOpacity(0.6)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c, false),
            child:
                const Text('Keep Going', style: TextStyle(color: Color(0xFF8B5CF6))),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(c, true),
            style: ElevatedButton.styleFrom(backgroundColor: _accent),
            child: const Text('End Session'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref.read(workflowNotifierProvider.notifier).completeDay();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(workflowNotifierProvider).valueOrNull ??
        FocusWorkflowState.initial(DateTime.now());

    final totalDuration = (state.workStartTime != null && state.workEndTime != null)
        ? state.workEndTime!.difference(state.workStartTime!)
        : const Duration(hours: 8);

    final progressFraction = totalDuration.inSeconds == 0
        ? 0.0
        : _elapsed.inSeconds / totalDuration.inSeconds;

    return PhaseScaffold(
      accent: _accent,
      actions: [
        TextButton.icon(
          onPressed: _endDay,
          icon: const Icon(Icons.stop_circle_outlined, size: 18),
          label: const Text('End'),
          style: TextButton.styleFrom(foregroundColor: Colors.white54),
        ),
      ],
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              // Phase badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
                decoration: BoxDecoration(
                  color: _accent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _accent.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _PulsingDot(color: _accent),
                    const SizedBox(width: 8),
                    const Text('FOCUS ACTIVE',
                        style: TextStyle(
                            color: _accent,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2)),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              // Big countdown
              CountdownRing(
                remaining: _remaining,
                total: totalDuration,
                accent: _accent,
                label: 'UNTIL DONE',
              ),
              const SizedBox(height: 32),
              const Text('Deep Work Mode',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: Colors.white)),
              const SizedBox(height: 8),
              Text(
                'Apps are blocked. Stay in the zone.',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white.withOpacity(0.45)),
              ),
              const SizedBox(height: 32),
              // Progress bar
              GlassCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Progress',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white.withOpacity(0.45))),
                        Text(
                          '${(progressFraction * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _accent),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progressFraction.clamp(0.0, 1.0),
                        minHeight: 10,
                        backgroundColor: Colors.white.withOpacity(0.08),
                        valueColor:
                            const AlwaysStoppedAnimation(_accent),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _statChip(Icons.lock_rounded, 'Apps Blocked',
                            state.appsBlocked),
                        _statChip(Icons.do_not_disturb_on_rounded,
                            'Strict Mode', state.strictFocusEnabled),
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statChip(IconData icon, String label, bool active) {
    final color = active ? _accent : Colors.white24;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        Text(label,
            style: TextStyle(
                fontSize: 12,
                color: active ? _accent : Colors.white38)),
      ],
    );
  }
}

// Pulsing animated dot
class _PulsingDot extends StatefulWidget {
  const _PulsingDot({required this.color});
  final Color color;

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat(reverse: true);
    _anim = Tween(begin: 0.4, end: 1.0).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _anim,
      child: Container(
        width: 8,
        height: 8,
        decoration:
            BoxDecoration(color: widget.color, shape: BoxShape.circle),
      ),
    );
  }
}
