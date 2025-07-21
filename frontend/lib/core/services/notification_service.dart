import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';

class NotificationService {
  // Initializing firebase messaging plugin
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  // final box = GetStorage();
  // final String _notificationsKey = 'notifications';

  Future<void> _showPermissionDeniedDialog(
    BuildContext context,
    String title,
  ) async {
    if (!context.mounted) return; // Ensure context is still mounted

    final result = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: KColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(KSizes.xs),
          ),
          title: Text('$title Denied'),
          content: const Text(
            "You've denied notification permission. To receive updates, please enable notifications in your device settings.",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'cancel'),
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'retry'),
              child: const Text('RETRY'),
            ),
          ],
        );
      },
    );

    if (result == 'retry') {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
    }
  }

  Future<void> requestNotificationPermission(BuildContext context) async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      if (kDebugMode) {
        print('User granted permission');
      }
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      if (kDebugMode) {
        print('User granted provisional permission');
      }
    } else {
      if (kDebugMode) {
        print('User denied permission');
      }
      await _showPermissionDeniedDialog(context, "Notification");
    }
  }

  Future<String?> getDeviceToken() async {
    String? token = await messaging.getToken();
    if (kDebugMode) {
      print("Token: $token");
    }
    return token;
  }

  void initLocalNotifications(
    BuildContext context,
    RemoteMessage message,
  ) async {
    var androidInitializationSettings = const AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSetting,
      onDidReceiveNotificationResponse: (payload) {
        // Handle interaction when app is active for Android
        // if (payload.payload != null) {
        handleMessage(context, message);
        // }
      },
    );
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification!.android;

      if (kDebugMode) {
        print("notifications title:${notification!.title}");
        print("notifications body:${notification.body}");
        print('count:${android!.count}');
        print('data:${message.data.toString()}');
      }
      if (message.notification != null) {
        if (Platform.isIOS) {
          await forgroundMessage();
        }

        if (Platform.isAndroid) {
          initLocalNotifications(context, message);
          await showNotification(message);
        }
        // await storeNotification(message); // Store notification in GetStorage
      }
    });
  }

  Future<void> setupInteractMessage(BuildContext context) async {
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      await handleMessage(context, message);
      // await storeNotification(message);
    });

    // Handle initial message when app is opened from a terminated state
    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();
    if (initialMessage != null) {
      if (initialMessage.data.isNotEmpty) {
        await handleMessage(context, initialMessage);
      }
      // await storeNotification(
      //     initialMessage); // Store notification when the app is opened
    }
  }

  Future<void> showNotification(RemoteMessage message) async {
    String? imageUrl = message.notification?.android?.imageUrl;
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      message.notification!.android!.channelId.toString(),
      message.notification!.android!.channelId.toString(),
      importance: Importance.max,
      showBadge: true,
      playSound: true,
    );

    AndroidNotificationDetails
    androidNotificationDetails = AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      // channelDescription: channel.description,
      channelDescription:
          'Notifications for updates and important alerts related to your orders, latest offers and promotions and app activity.',
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      ticker: 'ticker',
      sound: channel.sound,
      styleInformation: imageUrl != null
          ? BigPictureStyleInformation(
              FilePathAndroidBitmap(imageUrl), // Load the image
              contentTitle: message.notification!.title,
              summaryText: message.notification!.body,
            )
          : null,
    );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );

    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
        payload: 'my_data',
      );
    });
  }

  Future<void> forgroundMessage() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> handleMessage(
    BuildContext context,
    RemoteMessage message,
  ) async {
    // if (kDebugMode) {
    //   print("Navigating to screen with message: ${message.data}");
    // }
    // print(
    //     "Navigating to appointments screen. Hit here to handle the message. Message data: ${message.data}");

    // if (message.data.containsKey('screen')) {
    //   String screen = message.data['screen'];
    //   switch (screen) {
    //     case 'order':
    //       navigatorKey.currentState?.pushNamed('/orderHistory');
    //       break;
    //     default:
    //       navigatorKey.currentState?.pushNamed('/splash');
    //   }
    // }
  }

  // Future<void> storeNotification(RemoteMessage message) async {
  //   // Get the image URL from the notification payload
  //   String? imageUrl = message.notification?.android?.imageUrl;

  //   // Create a notification model including the image URL
  //   final notification = NotificationModel(
  //     title: message.notification?.title ?? ' ',
  //     body: message.notification?.body ?? ' ',
  //     date: DateTime.now(), // Save current date and time
  //     imageUrl: imageUrl, // Store the image URL
  //   );

  //   // Load existing notifications, ensuring type consistency
  //   final existingNotifications =
  //       (box.read<List<dynamic>>(_notificationsKey) ?? [])
  //           .cast<Map<String, dynamic>>()
  //           .toList();

  //   // Add the new notification to the list
  //   existingNotifications.add(notification.toJson());

  //   // Save the updated list back to GetStorage
  //   await box.write(_notificationsKey, existingNotifications);
  // }

  // List<NotificationModel> getStoredNotifications() {
  //   final storedData = box.read<List<dynamic>>(_notificationsKey) ?? [];
  //   return storedData
  //       .cast<Map<String, dynamic>>()
  //       .map((json) => NotificationModel.fromJson(json))
  //       .toList();
  // }

  // Future<void> clearNotifications() async {
  //   await box.remove(_notificationsKey);
  // }
}
