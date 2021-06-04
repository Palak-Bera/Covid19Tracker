import 'dart:async';
import '../utils/constants.dart';
import 'package:covid19/screens/tracker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

import 'package:hexcolor/hexcolor.dart';

class AnimatedSplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<AnimatedSplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 5);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Tracker()),
    );
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 4));
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  var parser = EmojiParser();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // container for toggle switch

            // Main area
            Expanded(
              child: Container(
                padding: EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: HexColor("#120321"),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(50),
                    bottomLeft: Radius.circular(50),
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: animation.value * 250,
                          height: animation.value * 250,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage('images/logo.png'),
                                fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Covid-19",
                          style: TextStyle(
                              fontSize: animation.value * 45,
                              fontFamily: "Chango",
                              // fontWeight: FontWeight.bold,
                              color: HexColor("#ffffff")),
                        ),
                        Text(
                          "Tracker",
                          style: TextStyle(
                              fontSize: animation.value * 45,
                              fontFamily: "Chango",
                              fontWeight: FontWeight.bold,
                              color: HexColor("#7ed957")),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: size.height * 0.1)
          ],
        ),
      ),
    );


  }
}
