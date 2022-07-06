import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  initializeApp() async {
    await Firebase.initializeApp().whenComplete(() {
      print("complete");
     // setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    initializeApp();
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (ctx) => WelcomeScreen(),
        LoginScreen.id: (ctx) => LoginScreen(),
        RegistrationScreen.id: (ctx) => RegistrationScreen(),
        ChatScreen.id: (ctx) => ChatScreen(),
      },
    );
  }
}
