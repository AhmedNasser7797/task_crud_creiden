import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_crud/core/constants/vars.dart';
import 'package:task_crud/core/theme/theme.dart';
import 'package:task_crud/features/to_do_list/data/models/todo_model.dart';

class NotificationController {
  // static ReceivedAction? initialAction;

  Future<void> initNotification() async {
    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        // 'resource://drawable/ic_launcher',
        null,
        [
          NotificationChannel(
            channelGroupKey: 'basic_channel_group',
            channelKey: 'task_crud_Schedule',
            channelName: 'task_crud',
            channelDescription: 'Notifications for task_crud application',
            playSound: true,
            onlyAlertOnce: true,
            groupAlertBehavior: GroupAlertBehavior.Children,
            importance: NotificationImportance.High,
            defaultPrivacy: NotificationPrivacy.Private,
            criticalAlerts: true,
            enableLights: true,
            defaultRingtoneType: DefaultRingtoneType.Notification,
            enableVibration: true,
            defaultColor: AppTheme.primary,
          ),
        ],
        // Channel groups are only visual and are not required
        debug: kDebugMode);
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    await _startListeningNotificationEvents();

    await AwesomeNotifications()
        .getInitialNotificationAction(removeFromActionEvents: false);
  }

  static Future<void> _startListeningNotificationEvents() async {
    // Only after at least the action method is set, the notification events are delivered
    AwesomeNotifications().setListeners(
        onActionReceivedMethod: NotificationController.onActionReceivedMethod,
        onNotificationCreatedMethod:
            NotificationController._onNotificationCreatedMethod,
        onNotificationDisplayedMethod:
            NotificationController.onNotificationDisplayedMethod,
        onDismissActionReceivedMethod:
            NotificationController.onDismissActionReceivedMethod);
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> _onNotificationCreatedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
      ReceivedNotification receivedNotification) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
      ReceivedAction receivedAction) async {
    // if (receivedAction.actionType == ActionType.Default) {
    // if (navigatorKey.currentContext != null) {
    //   BuildContext context = navigatorKey.currentContext!;
    //   final auth = context.read<AuthProvider>();
    //   if (auth.authLogged) {
    //     navigateAndRemoveUntilTo(
    //         navigatorKey.currentContext!,
    //         const MainScreen(
    //           index: 1,
    //         ));
    //   } else {
    //     navigateTo(
    //         context,
    //         const SplashScreen(
    //           openAppointments: true,
    //         ));
    //   }
    //   // showToast("auth.authLogged ${auth.authLogged}");
    // } else {
    //   // showToast("navigatorKey ${navigatorKey.currentContext != null}");
    // }
    // For background actions, you must hold the execution until the end
    log('Message sent via notification input: "${receivedAction.buttonKeyInput}"');
    // await executeLongTaskInBackground();
    // }
    // print("onActionReceivedMethod");
  }

  Future createScheduleNotification(TodoModel todoItem) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: todoItem.id,
          channelKey: 'task_crud_Schedule',
          body: getBody(todoItem),
          title: "Task Reminder ${todoItem.name}",
          displayOnBackground: true,
          showWhen: true,
          wakeUpScreen: true,
          displayOnForeground: true,
          criticalAlert: true,
          fullScreenIntent: true,
          color: AppTheme.primary,
          // payload: {'uuid': 'uuid-test'},
        ),
        schedule: NotificationCalendar.fromDate(
          date: getSchaduledDate(todoItem.date, todoItem.time),
          preciseAlarm: true,
          allowWhileIdle: true,
        ));
  }

  String getBody(TodoModel todoItem) {
    DateTime date = todoItem.date ?? DateTime.now();
    TimeOfDay time = todoItem.time ?? TimeOfDay.now();

    String body = "we remind you about the task ${todoItem.description} at "
        "${DateFormat.yMMMMEEEEd().format(date)} ";
    if (navigatorKey.currentContext != null) {
      body += " ${time.format(navigatorKey.currentContext!)}";
    } else {
      body += "${time.hour}:${time.minute}";
    }
    return body;
  }

  Future<void> disableScheduledNotification(int id) async {
    await AwesomeNotifications().cancelSchedule(id);
  }

  DateTime getSchaduledDate(DateTime? value, TimeOfDay? timeValue) {
    DateTime date = value ?? DateTime.now();
    TimeOfDay time = timeValue ?? TimeOfDay.now();

    return DateTime.parse(
        "${date.year}-${_getCorrectFormat(date.month.toString())}-"
        "${_getCorrectFormat(date.day.toString())} "
        "${_getCorrectFormat(time.hour.toString())}:${_getCorrectFormat(time.minute.toString())}:00");
  }

  String _getCorrectFormat(String value) {
    if (value.length == 1) {
      return "0$value";
    } else {
      return value;
    }
  }
// Method 2
}
