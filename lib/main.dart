import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hometodoor_user/assistantMethods/cart_item_counter.dart';
import 'package:hometodoor_user/assistantMethods/total_amount.dart';
import 'package:hometodoor_user/splashScreen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'global/global.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences=await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
          ChangeNotifierProvider(
              create: (c)=>CartItemCounter()
          ),
        ChangeNotifierProvider(
            create: (c)=>TotalAmount()
        ),
      ],
      child: MaterialApp(
        title: 'Users App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: const MySplashScreen(),
      ),
    );
  }
}


