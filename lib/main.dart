import 'package:deepak_kumar_task/pages/Profile%20Page/profile_view.dart';
import 'package:deepak_kumar_task/pages/SignIn%20Page/sign_in_view.dart';
import 'package:deepak_kumar_task/pages/SignUp%20Page/sign_up_view.dart';
import 'package:deepak_kumar_task/pages/Welcome%20Page/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeView(),
        '/signIn': (context) => const SignInView(),
        '/signUp': (context) => const SignUpView(),
        '/profile': (context) => const ProfileView(),
      },
    );
  }
}
