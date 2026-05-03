import 'package:isar/isar.dart';
import '../domain/focus_session.dart';
import '../domain/focus_workflow_state.dart';

String _dateKey(DateTime dt) =>
    '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';

class IsarWorkflowRepository {
  IsarWorkflowRepository(this._isar);
  final Isar _isar;

  Future<FocusWorkflowState> loadTodayState() async {
    final today = _dateKey(DateTime.now());
    final session =
        await _isar.focusSessions.where().dateEqualTo(today).findFirst();
    if (session == null) return FocusWorkflowState.initial(DateTime.now());
    return _fromSession(session);
  }

  Future<void> save(FocusWorkflowState s) async {
    final today = _dateKey(DateTime.now());
    final existing =
        await _isar.focusSessions.where().dateEqualTo(today).findFirst();
    final session = FocusSession(
      id: existing?.id ?? Isar.autoIncrement,
      date: today,
      phase: s.phase.index,
      wakeUpTime: s.wakeUpTime,
      planningEndsAt: s.planningEndsAt,
      workStartTime: s.workStartTime,
      workEndTime: s.workEndTime,
      controlledModeEnabled: s.controlledModeEnabled,
      strictFocusEnabled: s.strictFocusEnabled,
      appsBlocked: s.appsBlocked,
      calendarSynced: s.calendarSynced,
    );
    await _isar.writeTxn(() async {
      await _isar.focusSessions.put(session);
    });
  }

  FocusWorkflowState _fromSession(FocusSession s) {
    return FocusWorkflowState(
      phase: FocusPhase.values[s.phase.clamp(0, FocusPhase.values.length - 1)],
      now: DateTime.now(),
      wakeUpTime: s.wakeUpTime,
      planningEndsAt: s.planningEndsAt,
      workStartTime: s.workStartTime,
      workEndTime: s.workEndTime,
      controlledModeEnabled: s.controlledModeEnabled,
      strictFocusEnabled: s.strictFocusEnabled,
      appsBlocked: s.appsBlocked,
      calendarSynced: s.calendarSynced,
    );
  }
}
