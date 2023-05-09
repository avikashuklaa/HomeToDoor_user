import 'package:flutter/material.dart';
import 'package:hometodoor_user/authentication/signup.dart';

import 'login.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xffff99c8),
                    Color(0xff023e8a),
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
            ),
            automaticallyImplyLeading: false,
            title: Text('Home to Door',
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Lobster",
              fontSize: 33.0,
            ),),
            centerTitle: true,
            bottom: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.lock, color: Colors.white60,
                    ),
                    text: "Login",
                  ),
                  Tab(
                    icon: Icon(
                      Icons.person, color: Colors.white60,
                    ),
                    text: "Signup",
                  ),
                ],
              indicatorColor: Colors.white54,
              indicatorWeight: 5,
            ),
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                    Color(0xffff99c8),
                    Color(0xff023e8a),
                  ]
              ),
            ),
            child: const TabBarView(
              children: [
                LoginScreen(),
                SignupScreen(),
              ],
            ),
          ),

        )
    );
  }
}
