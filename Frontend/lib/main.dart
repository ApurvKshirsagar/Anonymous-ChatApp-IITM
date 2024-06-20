import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flinnit/firebase_options.dart';
import 'package:flinnit/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    ),
  );
}
