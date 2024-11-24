import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:testp/utils/themes.dart';
import 'package:testp/views/auth/login_view.dart';
import 'package:testp/views/auth/signup_view.dart';
import 'package:testp/views/event/event_create_view.dart';
import 'package:testp/views/event/event_details_view.dart';
import 'package:testp/views/event/event_list_view.dart';
import 'controllers/auth_controller.dart';
import 'controllers/event_controller.dart';
import 'controllers/theme_controller.dart';
import 'firebase_options.dart'; // Automatically generated if using FlutterFire CLI
import 'package:permission_handler/permission_handler.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> initialize() async {
  tz.initializeTimeZones();
  // Initialize notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher'); // Your app icon

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize local notifications
  await initialize();

  // Request permission for notifications
  await requestPermission();

  // Initialize controllers
  Get.put(AuthController());
  Get.put(EventController());
  Get.put(ThemeController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Obx(() {
      return GetMaterialApp(
        title: 'Event Manager',
        debugShowCheckedModeBanner: false,
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        themeMode: themeController.themeMode.value,
        initialRoute: '/',
        getPages: [
          GetPage(name: '/', page: () => LoginView()),
          GetPage(name: '/signup', page: () => SignupView()),
          GetPage(name: '/events', page: () => EventListView()),
          GetPage(name: '/create-event', page: () => EventCreateView()),
          GetPage(name: '/event-details', page: () => EventDetailsView()),
        ],
      );
    });
  }
}

Future<void> requestPermission() async {
  PermissionStatus status = await Permission.notification.request();
  if (status.isGranted) {
    print("Notification permission granted");
  } else {
    print("Notification permission denied");
  }
}
