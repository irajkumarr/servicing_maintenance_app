import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/app.dart';
import 'package:frontend/firebase_options.dart';


@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Use the NotificationService to store the notification
  // final notificationService = NotificationService();

  // await notificationService.storeNotification(message);
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Lock the app in portrait mode
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
  runApp(const App());
}
