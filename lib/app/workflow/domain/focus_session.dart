import 'package:isar/isar.dart';

part 'focus_session.g.dart';

/// Isar-persisted record of a focus session day.
@Collection()
class FocusSession {
  FocusSession({
    this.id = Isar.autoIncrement,
    required this.date,
    this.wakeUpTime,
    this.planningEndsAt,
    this.workStartTime,
    this.workEndTime,
    this.phase = 0,
    this.controlledModeEnabled = false,
    this.strictFocusEnabled = false,
    this.appsBlocked = false,
    this.calendarSynced = false,
  });

  /// Isar auto-increment primary key.
  Id id;

  /// The calendar date this session belongs to (stored as ISO-8601 string).
  @Index(unique: true)
  late String date;

  DateTime? wakeUpTime;
  DateTime? planningEndsAt;
  DateTime? workStartTime;
  DateTime? workEndTime;

  /// Serialized [FocusPhase] index.
  int phase;

  bool controlledModeEnabled;
  bool strictFocusEnabled;
  bool appsBlocked;
  bool calendarSynced;
}
