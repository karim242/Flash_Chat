import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

import '../round_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_Screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  @override

  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: Duration(seconds: 4), vsync: this, upperBound: 1);
    // // animation =
    //   CurvedAnimation(parent: animationController, curve: Curves.decelerate);
    animation = IntTween(begin: 40, end:60)
        .animate(animationController);

    animationController.forward();

    animationController.addListener(
      () {
        setState(() {});
        print(animation.value);
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:Colors.tealAccent,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 60.0,
                  ),
                ),
                TyperAnimatedTextKit(text: ['Flash Chat'],
                  speed: const Duration(milliseconds: 100),
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              colour: Colors.lightBlue,
              onTap: () {
                //Go to login screen.
                Navigator.pushNamed(context, LoginScreen.id);
              },
              height: animation.value.toDouble() ,
            ),
            RoundedButton(
              title: 'Register',
              colour: Colors.blueAccent,
              onTap: () {
                //Go to login screen.
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
              height: animation.value.toDouble(),
            ),
          ],
        ),
      ),
    );
  }
}
