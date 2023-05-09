import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../global/global.dart';
import '../mainScreens/home_screen.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';
import 'auth_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController passwordController=TextEditingController();
  TextEditingController emailController=TextEditingController();

  formValidation(){
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      //login
      loginNow();
    }
    else{
      showDialog(
        context: context,
        builder: (c){
          return ErrorDialog(message: "Please enter email/password",);
        }
      );
    }
  }

  loginNow() async{
    showDialog(
        context: context,
        builder: (c){
          return LoadingDialog(
            message: "Authenticating",
          );
        }
    );

    User? currentUser;
    await firebaseAuth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
    ).then((auth) {
      currentUser = auth.user!;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(message: error.message.toString());
          }
      );
    });

    if(currentUser != null){
      readDataAndSetDataLocally(currentUser!);
    }
  }

  Future readDataAndSetDataLocally(User currentUser) async{

    await FirebaseFirestore.instance.collection("users").doc(currentUser.uid).get().then((snapshot) async{

      if(snapshot.exists){
        await sharedPreferences!.setString("uid", currentUser.uid);
        await sharedPreferences!.setString("email", snapshot.data()!["userEmail"]);
        await sharedPreferences!.setString("name", snapshot.data()!["userName"]);
        await sharedPreferences!.setString("photoUrl", snapshot.data()!["userPhotoUrl"]);

        List<String> userCartList = snapshot.data()!["userCart"].cast<String>();
        await sharedPreferences!.setStringList("userCart", userCartList);

        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (c)=>HomeScreen()));
      }
      else{
        firebaseAuth.signOut();
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (c)=>AuthScreen()));

        showDialog(
            context: context,
            builder: (c){
              return ErrorDialog(
                  message: "Account doesn't exist. Try signing in!"
              );
            }
        );


      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Image.asset("images/welcome.png",
                height: 270,),
            ),
          ),
          Form(
              key: _formkey,
            child: Column(
              children: [
              CustomTextField(
              data: Icons.email_rounded,
              controller: emailController,
              hintText: "E-mail",
              isObsecre: false,

            ),
            CustomTextField(
              data: Icons.lock,
              controller: passwordController,
              hintText: "Password",
              isObsecre: true,
            ),

              ],
            ),
          ),
          SizedBox(height: 15,),
          ElevatedButton(
            onPressed: (){
              formValidation();
            },
            child: Text(
              "Login",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Color(0xffffcad4),
            ),

          ),
          SizedBox(height: 10,)
        ],
      ),
    );
  }
}
