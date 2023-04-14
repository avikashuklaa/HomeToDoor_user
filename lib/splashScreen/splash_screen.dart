import 'dart:async';

import 'package:flutter/material.dart';

import '../authentication/auth_screen.dart';
import '../global/global.dart';
import '../mainScreens/home_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  startTimer()
  {


    Timer(const Duration(seconds: 8), () async {
      //if chef is already logged in
      if(firebaseAuth.currentUser != null){
         Navigator.push(context, MaterialPageRoute(builder: (c)=> const HomeScreen()));
      }
      //if seller is not already logged in
      else{
         Navigator.push(context, MaterialPageRoute(builder: (c)=> const AuthScreen()));
      }
    });

  }

  @override
  void initState() {

    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    return Material(

      child: Container(
        color: Color(0xFFcfdfdc),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/HometoDoor.png'),
              const SizedBox(height: 10,),
              const Padding(
                padding:EdgeInsets.all(18.0),
                child: Text('Homemade Food Anywhere',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: "Signatra",
                  letterSpacing: 3,
                ),),
              )
            ],
          ),
        ),
      ),
    );
  }
}
