import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/isar_providers.dart';
import '../domain/focus_workflow_state.dart';
import '../infrastructure/isar_workflow_repository.dart';
import '../infrastructure/workflow_services.dart';

/// How long the planning lock lasts after waking up.
const kPlanningDuration = Duration(minutes: 30);

final workflowServicesProvider = Provider<WorkflowServices>(
  (_) => WorkflowServices.noop(),
);

// ---------------------------------------------------------------------------
// Notifier
// ---------------------------------------------------------------------------

class WorkflowNotifier extends AsyncNotifier<FocusWorkflowState> {
  late IsarWorkflowRepository _repo;
  Timer? _ticker;

  @override
  Future<FocusWorkflowState> build() async {
    final isar = await ref.watch(isarProvider.future);
    _repo = IsarWorkflowRepository(isar);
    final loaded = await _repo.loadTodayState();
    _startTicker();
    ref.onDispose(() => _ticker?.cancel());
    return _autoAdvance(loaded);
  }

  // ── helpers ───────────────────────────────────────────────────────────────

  FocusWorkflowState _autoAdvance(FocusWorkflowState s) {
    final now = DateTime.now();
    var updated = s.copyWith(now: now);

    if (s.phase == FocusPhase.focusArmed &&
        s.workStartTime != null &&
        now.isAfter(s.workStartTime!)) {
      updated = updated.copyWith(phase: FocusPhase.focusActive);
    }

    if (s.phase == FocusPhase.focusActive &&
        s.workEndTime != null &&
        now.isAfter(s.workEndTime!)) {
      updated = updated.copyWith(phase: FocusPhase.completed);
    }

    return updated;
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 30), (_) async {
      final current = state.valueOrNull;
      if (current == null) return;
      final next = _autoAdvance(current);
      if (next.phase != current.phase) await _repo.save(next);
      state = AsyncData(next);
    });
  }

  Future<void> _update(FocusWorkflowState next) async {
    state = AsyncData(next);
    await _repo.save(next);
  }

  // ── public API ────────────────────────────────────────────────────────────

  /// Phase 1 → 2 : user commits their wake-up time.
  Future<void> commitWakeUpTime(DateTime wakeUpTime) async {
    final current = state.value!;
    final planningEndsAt = DateTime.now().add(kPlanningDuration);
    await _update(current.copyWith(
      phase: FocusPhase.planningLocked,
      wakeUpTime: wakeUpTime,
      planningEndsAt: planningEndsAt,
    ));
  }

  /// Phase 2 → 3 : user finishes planning (only allowed when timer is up).
  Future<void> completePlanning() async {
    final current = state.value!;
    if (!current.canLeavePlanning) return;
    await _update(current.copyWith(phase: FocusPhase.scheduleSetup));
  }

  /// Phase 3 → 4 : user locks in work schedule.
  Future<void> setWorkSchedule({
    required DateTime workStart,
    required DateTime workEnd,
  }) async {
    final current = state.value!;
    final services = ref.read(workflowServicesProvider);
    await services.productivitySyncService.syncCalendarAndTasks(
      workStartTime: workStart,
      workEndTime: workEnd,
    );
    await _update(current.copyWith(
      phase: FocusPhase.focusArmed,
      workStartTime: workStart,
      workEndTime: workEnd,
      calendarSynced: true,
    ));
  }

  /// Phase 4 → 5 : manually start focus (or auto-triggered by ticker).
  Future<void> startFocusActive() async {
    final current = state.value!;
    final services = ref.read(workflowServicesProvider);
    await services.distractionBlockService.blockDistractingApps();
    await services.deviceControlService.enableStrictFocusMode();
    await _update(current.copyWith(
      phase: FocusPhase.focusActive,
      appsBlocked: true,
      strictFocusEnabled: true,
    ));
  }

  /// Phase 5 → 6 : work day is complete.
  Future<void> completeDay() async {
    final current = state.value!;
    final services = ref.read(workflowServicesProvider);
    await services.distractionBlockService.unblockDistractingApps();
    await services.deviceControlService.restoreNormalPhoneAccess();
    await _update(current.copyWith(
      phase: FocusPhase.completed,
      appsBlocked: false,
      strictFocusEnabled: false,
    ));
  }

  /// Reset to Night Setup (start a new day).
  Future<void> resetForNewDay() async {
    await _update(FocusWorkflowState.initial(DateTime.now()));
  }
}

final workflowNotifierProvider =
    AsyncNotifierProvider<WorkflowNotifier, FocusWorkflowState>(
  WorkflowNotifier.new,
);
