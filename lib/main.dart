import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/constants.dart';
import 'package:tiktokclone/controllers/auth_controller.dart';
import 'package:tiktokclone/views/screens/auth/login_screen.dart';
import 'package:tiktokclone/views/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: "My-App",
    options: const FirebaseOptions(
      apiKey: "AIzaSyDV4oRtw_ikbAL_xkIHj16XhzyXZ2arqmI",
      appId: "1:787643768572:web:9caebd93937245918b0179",
      messagingSenderId: "787643768572",
      projectId: "tiktok-tutorial-2e0d8",
    ),
  ).then((value) {
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TikTok Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: LoginScreen(),
    );
  }
}
