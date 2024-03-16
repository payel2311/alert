import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:newproject/provider/auth_provider.dart';
import 'screeens/FirstPage.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'api/firebase_api.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

final navigatorKey= GlobalKey<NavigatorState>();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
  );
  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],

      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'Flutter Navigation Example',
        home: FirstPage(),
    ),
    );
  }
}

