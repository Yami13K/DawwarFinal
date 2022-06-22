

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const String _backgroundName =
    'yamiDaemoner';


void yamiWorker() {
  WidgetsFlutterBinding.ensureInitialized();

  const _channel = MethodChannel(_backgroundName, JSONMethodCodec());

  _channel.setMethodCallHandler((MethodCall call) async {
    final dynamic args = call.arguments;
    final handle = CallbackHandle.fromRawHandle(args[0]);

    final closure = PluginUtilities.getCallbackFromHandle(handle);

    if (closure == null) {
      print('Fatal: could not find callback');
      exit(-1);
    }

    if (closure is Function()) {
      closure();
    } else if (closure is Function(int)) {
      final int id = args[1];
      closure(id);
    }
  });


  _channel.invokeMethod<void>('AlarmService.initialized');
}

typedef _Now = DateTime Function();
typedef _GetCallbackHandle = CallbackHandle Function(Function callback);


class AndroidAlarmManager {
  static const String _channelName = _backgroundName;
  static final MethodChannel _channel =
  const MethodChannel(_channelName, JSONMethodCodec());


  static _Now _now = () => DateTime.now();


  static _GetCallbackHandle _getCallbackHandle =
      (Function callback) => PluginUtilities.getCallbackHandle(callback);

  @visibleForTesting
  static void setTestOverides(
      {_Now now, _GetCallbackHandle getCallbackHandle}) {
    _now = (now ?? _now);
    _getCallbackHandle = (getCallbackHandle ?? _getCallbackHandle);
  }


  static Future<bool> initialize() async {
    final handle = _getCallbackHandle(yamiWorker);
    if (handle == null) {
      return false;
    }
    final r = await _channel.invokeMethod<bool>(
        'AlarmService.start', <dynamic>[handle.toRawHandle()]);
    return r ?? false;
  }


  static Future<bool> oneShot(
      Duration delay,
      int id,
      Function callback, {
        bool alarmClock = false,
        bool allowWhileIdle = false,
        bool exact = false,
        bool wakeup = false,
        bool rescheduleOnReboot = false,
      }) =>
      oneShotAt(
        _now().add(delay),
        id,
        callback,
        alarmClock: alarmClock,
        allowWhileIdle: allowWhileIdle,
        exact: exact,
        wakeup: wakeup,
        rescheduleOnReboot: rescheduleOnReboot,
      );

  static Future<bool> oneShotAt(
      DateTime time,
      int id,
      Function callback, {
        bool alarmClock = false,
        bool allowWhileIdle = false,
        bool exact = false,
        bool wakeup = false,
        bool rescheduleOnReboot = false,
      }) async {
    // ignore: inference_failure_on_function_return_type
    assert(callback is Function() || callback is Function(int));
    assert(id.bitLength < 32);
    final startMillis = time.millisecondsSinceEpoch;
    final handle = _getCallbackHandle(callback);
    if (handle == null) {
      return false;
    }
    final r = await _channel.invokeMethod<bool>('Alarm.oneShotAt', <dynamic>[
      id,
      alarmClock,
      allowWhileIdle,
      exact,
      wakeup,
      startMillis,
      rescheduleOnReboot,
      handle.toRawHandle(),
    ]);
    return (r == null) ? false : r;
  }


  static Future<bool> periodic(
      Duration duration,
      int id,
      Function callback, {
        DateTime startAt,
        bool exact = false,
        bool wakeup = false,
        bool rescheduleOnReboot = false,
      }) async {
    // ignore: inference_failure_on_function_return_type
    assert(callback is Function() || callback is Function(int));
    assert(id.bitLength < 32);
    final now = _now().millisecondsSinceEpoch;
    final period = duration.inMilliseconds;
    final first =
    startAt != null ? startAt.millisecondsSinceEpoch : now + period;
    final handle = _getCallbackHandle(callback);
    if (handle == null) {
      return false;
    }
    final r = await _channel.invokeMethod<bool>('Alarm.periodic', <dynamic>[
      id,
      exact,
      wakeup,
      first,
      period,
      rescheduleOnReboot,
      handle.toRawHandle()
    ]);
    return (r == null) ? false : r;
  }

  static Future<bool> cancel(int id) async {
    final r = await _channel.invokeMethod<bool>('Alarm.cancel', <dynamic>[id]);
    return (r == null) ? false : r;
  }
}
