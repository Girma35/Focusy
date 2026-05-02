import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/focus_workflow_state.dart';
import '../infrastructure/workflow_services.dart';

typedef Clock = DateTime Function();

final workflowServicesProvider = Provider<WorkflowServices>((ref) {
  return WorkflowServices.noop();
});

final workflowControllerProvider =
    StateNotifierProvider<FocusWorkflowController, FocusWorkflowState>((ref) {
      final services = ref.watch(workflowServicesProvider);
      return FocusWorkflowController(services: services, clock: DateTime.now);
    });

class FocusWorkflowController extends StateNotifier<FocusWorkflowState> {
  FocusWorkflowController({required WorkflowServices services, required Clock clock})
      : _services = services,
        _clock = clock,
        super(FocusWorkflowState.initial(clock()));

  final WorkflowServices _services;
  final Clock _clock;

  Future<void> setWakeUpTime(TimeOfDay timeOfDay) async {
    final now = _clock();
    var wake = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    if (!wake.isAfter(now)) {
      wake = wake.add(const Duration(days: 1));
    }

    await _services.alarmScheduler.scheduleWakeUpAlarm(wake);
    state = state.copyWith(now: now, wakeUpTime: wake);
  }

  Future<void> triggerMorningAlarm() async {
    final now = _clock();
    final planningEndsAt = now.add(const Duration(minutes: 20));
    await _services.deviceControlService.enablePlanningLock(until: planningEndsAt);
    await _services.distractionBlockService.blockDistractingApps();

    state = state.copyWith(
      phase: FocusPhase.planningLocked,
      now: now,
      planningEndsAt: planningEndsAt,
      controlledModeEnabled: true,
      appsBlocked: true,
      strictFocusEnabled: false,
    );
  }

  Future<void> completePlanningIfReady() async {
    final now = _clock();
    final ready = state.phase == FocusPhase.planningLocked &&
        state.planningEndsAt != null &&
        !now.isBefore(state.planningEndsAt!);
    if (!ready) {
      state = state.copyWith(now: now);
      return;
    }

    state = state.copyWith(phase: FocusPhase.scheduleSetup, now: now);
  }

  Future<void> setWorkSchedule({
    required TimeOfDay start,
    required TimeOfDay end,
  }) async {
    final now = _clock();
    var workStart = DateTime(
      now.year,
      now.month,
      now.day,
      start.hour,
      start.minute,
    );
    var workEnd = DateTime(
      now.year,
      now.month,
      now.day,
      end.hour,
      end.minute,
    );

    if (workStart.isBefore(now)) {
      workStart = now;
    }
    if (!workEnd.isAfter(workStart)) {
      workEnd = workStart.add(const Duration(hours: 2));
    }

    await _services.productivitySyncService.syncCalendarAndTasks(
      workStartTime: workStart,
      workEndTime: workEnd,
    );

    state = state.copyWith(
      phase: FocusPhase.focusArmed,
      now: now,
      workStartTime: workStart,
      workEndTime: workEnd,
      calendarSynced: true,
    );

    await tick();
  }

  Future<void> tick() async {
    final now = _clock();
    state = state.copyWith(now: now);

    if (state.phase == FocusPhase.planningLocked &&
        state.planningEndsAt != null &&
        !now.isBefore(state.planningEndsAt!)) {
      state = state.copyWith(phase: FocusPhase.scheduleSetup);
    }

    if (state.phase == FocusPhase.focusArmed &&
        state.workStartTime != null &&
        !now.isBefore(state.workStartTime!)) {
      await _startFocusSession(now);
    }

    if (state.phase == FocusPhase.focusActive &&
        state.workEndTime != null &&
        !now.isBefore(state.workEndTime!)) {
      await completeSession();
    }
  }

  Future<void> startFocusNow() async {
    await _startFocusSession(_clock());
  }

  Future<void> completeSession() async {
    final now = _clock();
    await _services.distractionBlockService.unblockDistractingApps();
    await _services.deviceControlService.restoreNormalPhoneAccess();

    state = state.copyWith(
      phase: FocusPhase.completed,
      now: now,
      strictFocusEnabled: false,
      controlledModeEnabled: false,
      appsBlocked: false,
    );
  }

  Future<void> restartForNextDay() async {
    state = FocusWorkflowState.initial(_clock());
  }

  Future<void> _startFocusSession(DateTime now) async {
    await _services.deviceControlService.enableStrictFocusMode();
    await _services.distractionBlockService.blockDistractingApps();

    state = state.copyWith(
      phase: FocusPhase.focusActive,
      now: now,
      strictFocusEnabled: true,
      controlledModeEnabled: true,
      appsBlocked: true,
    );
  }
}
