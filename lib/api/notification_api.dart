import 'package:expiration_inventory_tracker_app/utils/utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future showScheduleNotifications({
    required int id,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduleDateTime,
  }) async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
        const IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

//when app is closed
    final details = await _notifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotifications.add(payload);
    }

    await _notifications.initialize(
      initializationSettings,
      onSelectNotification: (payload) async {
        onNotifications.add(payload);
      },
    );

    _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduleDateTime, tz.local),
      await _notificationDetails(),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future _notificationDetails() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_channel', 'High Importance Notification',
        description: "This channel is for important notification",
        importance: Importance.max);

    final bigPicturePath = await Utils.dowloadFile(
        'https://drive.google.com/uc?export=view&id=1nRptyW5gAt4RkWSQuWU0oVMHvAzYYy5h',
        'bigPicture');
    final largeIconPath = await Utils.dowloadFile(
        'https://drive.google.com/uc?export=view&id=1nRptyW5gAt4RkWSQuWU0oVMHvAzYYy5h',
        'largeIcon');

    final styleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      largeIcon: FilePathAndroidBitmap(largeIconPath),
    );

    return NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        importance: Importance.max,
        styleInformation: styleInformation,
      ),
      iOS: IOSNotificationDetails(),
    );
  }
}
