import 'package:api_first/screen/auth/forget_password.dart';
import 'package:api_first/screen/auth/login_screen.dart';
import 'package:api_first/screen/images_screen.dart';
import 'package:api_first/screen/lunch.dart';
import 'package:api_first/screen/auth/register_screen.dart';
import 'package:api_first/screen/upload_image_screen.dart';
import 'package:api_first/screen/user_screen.dart';
import 'package:api_first/storge/pref_controller.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPrefController().initPrefController();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/lunch_screen',
      debugShowCheckedModeBanner: false,
      routes: {
        '/lunch_screen': (context) => const LunchScreen(),
        '/user_screen': (context) => const UserScreen(),
        '/login_screen': (context) => const LoginScreen(),
        '/register_screen': (context) => const RegisterScreen(),
        '/forget_password_Screen': (context) => const ForgetPasswordScreen(),
        '/images_screen': (context) => const ImagesScreen(),
        '/upload_images_screen': (context) => const UploadImageScreen(),
      },
    );
  }
}
