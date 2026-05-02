import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/focus_workflow_controller.dart';
import '../domain/focus_workflow_state.dart';

class WorkflowPage extends ConsumerStatefulWidget {
  const WorkflowPage({super.key});

  @override
  ConsumerState<WorkflowPage> createState() => _WorkflowPageState();
}

class _WorkflowPageState extends ConsumerState<WorkflowPage> {
  Timer? _ticker;
  TimeOfDay _selectedWakeUp = const TimeOfDay(hour: 7, minute: 0);
  TimeOfDay _selectedWorkStart = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _selectedWorkEnd = const TimeOfDay(hour: 11, minute: 0);

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      ref.read(workflowControllerProvider.notifier).tick();
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(workflowControllerProvider);
    final controller = ref.read(workflowControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Focusy')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _StatusCard(state: state),
          const SizedBox(height: 16),
          switch (state.phase) {
            FocusPhase.nightSetup => _NightSetup(
                selectedWakeUp: _selectedWakeUp,
                onPickWakeTime: () => _pickWakeTime(context),
                onSetWakeAlarm: () => controller.setWakeUpTime(_selectedWakeUp),
                onSimulateMorningAlarm: controller.triggerMorningAlarm,
              ),
            FocusPhase.planningLocked => _PlanningLocked(
                state: state,
                onContinue: controller.completePlanningIfReady,
              ),
            FocusPhase.scheduleSetup => _ScheduleSetup(
                selectedStart: _selectedWorkStart,
                selectedEnd: _selectedWorkEnd,
                onPickStart: () => _pickWorkStart(context),
                onPickEnd: () => _pickWorkEnd(context),
                onConfirm: () => controller.setWorkSchedule(
                  start: _selectedWorkStart,
                  end: _selectedWorkEnd,
                ),
              ),
            FocusPhase.focusArmed => _FocusArmed(
                state: state,
                onStartNow: controller.startFocusNow,
              ),
            FocusPhase.focusActive => _FocusActive(
                state: state,
                onEndNow: controller.completeSession,
              ),
            FocusPhase.completed => _Completed(
                onRestart: controller.restartForNextDay,
              ),
          },
        ],
      ),
    );
  }

  Future<void> _pickWakeTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedWakeUp,
    );
    if (picked != null && mounted) {
      setState(() {
        _selectedWakeUp = picked;
      });
    }
  }

  Future<void> _pickWorkStart(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedWorkStart,
    );
    if (picked != null && mounted) {
      setState(() {
        _selectedWorkStart = picked;
      });
    }
  }

  Future<void> _pickWorkEnd(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedWorkEnd,
    );
    if (picked != null && mounted) {
      setState(() {
        _selectedWorkEnd = picked;
      });
    }
  }
}

class _StatusCard extends StatelessWidget {
  const _StatusCard({required this.state});

  final FocusWorkflowState state;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text(
              'Current phase: ${_phaseLabel(state.phase)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text('Controlled mode: ${state.controlledModeEnabled ? 'ON' : 'OFF'}'),
            Text('Strict focus: ${state.strictFocusEnabled ? 'ON' : 'OFF'}'),
            Text('Distracting apps blocked: ${state.appsBlocked ? 'YES' : 'NO'}'),
            Text('Calendar synced: ${state.calendarSynced ? 'YES' : 'NO'}'),
          ],
        ),
      ),
    );
  }

  String _phaseLabel(FocusPhase phase) {
    return switch (phase) {
      FocusPhase.nightSetup => 'Night setup',
      FocusPhase.planningLocked => 'Mandatory planning',
      FocusPhase.scheduleSetup => 'Define work schedule',
      FocusPhase.focusArmed => 'Waiting for work start',
      FocusPhase.focusActive => 'Strict focus in progress',
      FocusPhase.completed => 'Session completed',
    };
  }
}

class _NightSetup extends StatelessWidget {
  const _NightSetup({
    required this.selectedWakeUp,
    required this.onPickWakeTime,
    required this.onSetWakeAlarm,
    required this.onSimulateMorningAlarm,
  });

  final TimeOfDay selectedWakeUp;
  final VoidCallback onPickWakeTime;
  final VoidCallback onSetWakeAlarm;
  final VoidCallback onSimulateMorningAlarm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        const Text(
          'Night before: set your wake-up alarm.',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        Text('Selected wake-up: ${selectedWakeUp.format(context)}'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            OutlinedButton(
              onPressed: onPickWakeTime,
              child: const Text('Pick wake-up time'),
            ),
            FilledButton(
              onPressed: onSetWakeAlarm,
              child: const Text('Set wake-up alarm'),
            ),
            FilledButton.tonal(
              onPressed: onSimulateMorningAlarm,
              child: const Text('Simulate morning alarm'),
            ),
          ],
        ),
      ],
    );
  }
}

class _PlanningLocked extends StatelessWidget {
  const _PlanningLocked({required this.state, required this.onContinue});

  final FocusWorkflowState state;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final remaining = state.planningRemaining;
    final minutes = remaining.inMinutes;
    final seconds = remaining.inSeconds.remainder(60);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        const Text(
          'Mandatory 20-minute planning session is active.',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const Text('Distractions and exiting are blocked until planning ends.'),
        Text(
          'Time left: ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
        ),
        FilledButton(
          onPressed: state.canLeavePlanning ? onContinue : null,
          child: const Text('Continue to schedule setup'),
        ),
      ],
    );
  }
}

class _ScheduleSetup extends StatelessWidget {
  const _ScheduleSetup({
    required this.selectedStart,
    required this.selectedEnd,
    required this.onPickStart,
    required this.onPickEnd,
    required this.onConfirm,
  });

  final TimeOfDay selectedStart;
  final TimeOfDay selectedEnd;
  final VoidCallback onPickStart;
  final VoidCallback onPickEnd;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        const Text(
          'Define your work schedule.',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        Text('Work start: ${selectedStart.format(context)}'),
        Text('Work end: ${selectedEnd.format(context)}'),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            OutlinedButton(onPressed: onPickStart, child: const Text('Pick start')),
            OutlinedButton(onPressed: onPickEnd, child: const Text('Pick end')),
            FilledButton(
              onPressed: onConfirm,
              child: const Text('Save schedule and sync tasks'),
            ),
          ],
        ),
      ],
    );
  }
}

class _FocusArmed extends StatelessWidget {
  const _FocusArmed({required this.state, required this.onStartNow});

  final FocusWorkflowState state;
  final VoidCallback onStartNow;

  @override
  Widget build(BuildContext context) {
    final start = state.workStartTime;
    final end = state.workEndTime;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        const Text(
          'Schedule saved. Phone is in controlled mode and waiting for work start.',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        if (start != null) Text('Work starts at: ${TimeOfDay.fromDateTime(start).format(context)}'),
        if (end != null) Text('Work ends at: ${TimeOfDay.fromDateTime(end).format(context)}'),
        FilledButton(
          onPressed: onStartNow,
          child: const Text('Start work session now'),
        ),
      ],
    );
  }
}

class _FocusActive extends StatelessWidget {
  const _FocusActive({required this.state, required this.onEndNow});

  final FocusWorkflowState state;
  final VoidCallback onEndNow;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        const Text(
          'Strict focus mode is active.',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const Text('Distracting apps are blocked.'),
        if (state.workEndTime != null)
          Text('Session ends at: ${TimeOfDay.fromDateTime(state.workEndTime!).format(context)}'),
        FilledButton(
          onPressed: onEndNow,
          child: const Text('End session now'),
        ),
      ],
    );
  }
}

class _Completed extends StatelessWidget {
  const _Completed({required this.onRestart});

  final VoidCallback onRestart;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        const Text(
          'Session ended. Normal phone access restored.',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        FilledButton(
          onPressed: onRestart,
          child: const Text('Start next day setup'),
        ),
      ],
    );
  }
}
