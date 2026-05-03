import 'package:flutter/services.dart';

abstract class AlarmScheduler {
  Future<void> scheduleWakeUpAlarm(DateTime wakeUpTime);
}

abstract class DeviceControlService {
  Future<void> enablePlanningLock({required DateTime until});
  Future<void> enableStrictFocusMode();
  Future<void> restoreNormalPhoneAccess();
}

abstract class DistractionBlockService {
  Future<void> blockDistractingApps();
  Future<void> unblockDistractingApps();
}

abstract class ProductivitySyncService {
  Future<void> syncCalendarAndTasks({
    required DateTime workStartTime,
    required DateTime workEndTime,
  });
}

class NoopAlarmScheduler implements AlarmScheduler {
  @override
  Future<void> scheduleWakeUpAlarm(DateTime wakeUpTime) async {}
}

class NoopDeviceControlService implements DeviceControlService {
  @override
  Future<void> enablePlanningLock({required DateTime until}) async {}

  @override
  Future<void> enableStrictFocusMode() async {}

  @override
  Future<void> restoreNormalPhoneAccess() async {}
}

class NoopDistractionBlockService implements DistractionBlockService {
  @override
  Future<void> blockDistractingApps() async {}

  @override
  Future<void> unblockDistractingApps() async {}
}

class NativeDistractionBlockService implements DistractionBlockService {
  static const _channel = MethodChannel('com.focusy/blocker');

  @override
  Future<void> blockDistractingApps() async {
    try {
      await _channel.invokeMethod('startBlocking');
    } catch (e) {
      // Ignored for now
    }
  }

  @override
  Future<void> unblockDistractingApps() async {
    try {
      await _channel.invokeMethod('stopBlocking');
    } catch (e) {
      // Ignored for now
    }
  }
}

class NoopProductivitySyncService implements ProductivitySyncService {
  @override
  Future<void> syncCalendarAndTasks({
    required DateTime workStartTime,
    required DateTime workEndTime,
  }) async {}
}

class WorkflowServices {
  const WorkflowServices({
    required this.alarmScheduler,
    required this.deviceControlService,
    required this.distractionBlockService,
    required this.productivitySyncService,
  });

  final AlarmScheduler alarmScheduler;
  final DeviceControlService deviceControlService;
  final DistractionBlockService distractionBlockService;
  final ProductivitySyncService productivitySyncService;

  factory WorkflowServices.noop() {
    return WorkflowServices(
      alarmScheduler: NoopAlarmScheduler(),
      deviceControlService: NoopDeviceControlService(),
      distractionBlockService: NoopDistractionBlockService(),
      productivitySyncService: NoopProductivitySyncService(),
    );
  }

  factory WorkflowServices.native() {
    return WorkflowServices(
      alarmScheduler: NoopAlarmScheduler(),
      deviceControlService: NoopDeviceControlService(),
      distractionBlockService: NativeDistractionBlockService(),
      productivitySyncService: NoopProductivitySyncService(),
    );
  }
}
