import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        //home: WelcomeScreen(),
        initialRoute: 'welcome_screen',
        routes: {
          'welcome_screen': (context) => WelcomeScreen(),
          'login_screen': (context) => LoginScreen(),
          'chat_screen': (context) => ChatScreen(),
          'registration_screen': (context) => RegistrationScreen(),
        });
  }
}
