import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobitoon/View/MainPage.dart';
import 'package:mobitoon/View/MainScreen.dart';

class ISplashScreen extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() => ISplashScreenState();
}

class ISplashScreenState extends State<ISplashScreen>
{
  double w; double h;

  @override
  void initState()
  {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    Timer(
        Duration(seconds: 4),
            () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => MainPage()
              ));
            }
    );

  }

  @override
  Widget build(BuildContext context)
  {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    w = MediaQuery.of(context).size.width / 50;
    h = MediaQuery.of(context).size.height / 50;

    return Scaffold(
      body: Container(
        width: w*50,
        height: h*50,
        color: Colors.black,
        child: Center(
          child: Text("MobiToon", style: TextStyle(fontSize: h*4, color: Colors.red[900], fontWeight: FontWeight.bold, fontFamily: 'grph')),
        ),
      ),
    );
  }

}