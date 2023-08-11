import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();

  //instance of FlutterLocalNotificationsPlugin
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {

    //Initialization Settings for Android
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

    //Initialization Settings for iOS
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    //InitializationSettings for initializing settings for both platforms (Android & iOS)
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,);
  }

  Future<void> requestIOSPermissions() async {
  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

   NotificationDetails platformChannelSpecifics = const NotificationDetails(android: AndroidNotificationDetails(
     'ToDo App',
     'Due Task',
     channelDescription: 'ToDo App',
     playSound: true,
     priority: Priority.high,
     importance: Importance.high,
   ), iOS: DarwinNotificationDetails(
           presentAlert: true,
           presentBadge: true,
           presentSound: true,
       ));

  Future<void> showNotifications({String message = ''}) async {
    await flutterLocalNotificationsPlugin.show(
       DateTime.now().second,
      'Due Task',
      message,
      platformChannelSpecifics,
      payload: 'Notification Payload',
    );
  }
}


