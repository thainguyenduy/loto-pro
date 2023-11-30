import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  static Future<NotificationService> init() async {
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: "dependo_notification_channel",
          channelName: "DependoNotification",
          channelDescription: "Dependo notification channel",
          importance: NotificationImportance.Max,
          enableVibration: true,
          playSound: true,
          defaultRingtoneType: DefaultRingtoneType.Ringtone,
        ),
        NotificationChannel(
            channelKey: "dependo_basic_notification",
            channelName: "BasicNotification",
            channelDescription: "Handles basic notifications",
            importance: NotificationImportance.Default,
            defaultRingtoneType: DefaultRingtoneType.Notification),
      ],
    );

    final isAllowed = await AwesomeNotifications().isNotificationAllowed();

    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications(
        permissions: [
          NotificationPermission.Sound,
          NotificationPermission.Alert,
          NotificationPermission.FullScreenIntent
        ],
      );
    }
    return NotificationService();
  }
}
