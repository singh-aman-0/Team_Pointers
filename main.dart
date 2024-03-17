import 'package:attendance/register.dart';
import 'package:attendance/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'login.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // await Future.delayed(const Duration(milliseconds: 3000), () {});
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyAy7T1ltAV3-cyPbFJ955g-0abWMVyuuok",
        appId: "1:897378178652:android:c9482c92ff28cda70a7899",
        messagingSenderId: "897378178652",
     projectId: "myapp-40b06"),
  );
  // FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      routes:{
        // 'onboardingpage':(context) => Onboardingpage(),
        'login':(context) => Mylogin(),
        'register':(context) => Myregister(),
        // 'waiting':(context) => RegistrationDone(),
        // 'Driver':(context) => MyDriver(),
      },
      debugShowCheckedModeBanner: false,
      home: Wrapper(),
    );
  }
}