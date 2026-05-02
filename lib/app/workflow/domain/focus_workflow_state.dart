import 'package:flutter/material.dart';

enum FocusPhase {
  nightSetup,
  planningLocked,
  scheduleSetup,
  focusArmed,
  focusActive,
  completed,
}

class FocusWorkflowState {
  const FocusWorkflowState({
    required this.phase,
    required this.now,
    this.wakeUpTime,
    this.planningEndsAt,
    this.workStartTime,
    this.workEndTime,
    this.controlledModeEnabled = false,
    this.strictFocusEnabled = false,
    this.appsBlocked = false,
    this.calendarSynced = false,
  });

  final FocusPhase phase;
  final DateTime now;
  final DateTime? wakeUpTime;
  final DateTime? planningEndsAt;
  final DateTime? workStartTime;
  final DateTime? workEndTime;
  final bool controlledModeEnabled;
  final bool strictFocusEnabled;
  final bool appsBlocked;
  final bool calendarSynced;

  Duration get planningRemaining {
    if (planningEndsAt == null) {
      return Duration.zero;
    }
    final remaining = planningEndsAt!.difference(now);
    if (remaining.isNegative) {
      return Duration.zero;
    }
    return remaining;
  }

  bool get canLeavePlanning => planningRemaining == Duration.zero;

  TimeOfDay get suggestedWakeUpTime => const TimeOfDay(hour: 7, minute: 0);

  FocusWorkflowState copyWith({
    FocusPhase? phase,
    DateTime? now,
    DateTime? wakeUpTime,
    DateTime? planningEndsAt,
    DateTime? workStartTime,
    DateTime? workEndTime,
    bool? controlledModeEnabled,
    bool? strictFocusEnabled,
    bool? appsBlocked,
    bool? calendarSynced,
    bool clearWakeUpTime = false,
    bool clearPlanningEndsAt = false,
    bool clearWorkStartTime = false,
    bool clearWorkEndTime = false,
  }) {
    return FocusWorkflowState(
      phase: phase ?? this.phase,
      now: now ?? this.now,
      wakeUpTime: clearWakeUpTime ? null : (wakeUpTime ?? this.wakeUpTime),
      planningEndsAt:
          clearPlanningEndsAt ? null : (planningEndsAt ?? this.planningEndsAt),
      workStartTime:
          clearWorkStartTime ? null : (workStartTime ?? this.workStartTime),
      workEndTime: clearWorkEndTime ? null : (workEndTime ?? this.workEndTime),
      controlledModeEnabled: controlledModeEnabled ?? this.controlledModeEnabled,
      strictFocusEnabled: strictFocusEnabled ?? this.strictFocusEnabled,
      appsBlocked: appsBlocked ?? this.appsBlocked,
      calendarSynced: calendarSynced ?? this.calendarSynced,
    );
  }

  static FocusWorkflowState initial(DateTime now) {
    return FocusWorkflowState(phase: FocusPhase.nightSetup, now: now);
  }
}
