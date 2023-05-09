import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:shared_preferences/shared_preferences.dart';

import '../global/global.dart';
import '../mainScreens/home_screen.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/error_dialog.dart';
import '../widgets/loading_dialog.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController nameController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  XFile? imageXFile;
  final ImagePicker _picker=ImagePicker();


  String chefImageURL="";

  Future<void> _getImage() async{
    imageXFile = await _picker.pickImage(source: ImageSource.gallery);
    setState((){
      imageXFile;
    });
  }


  Future<void> formValidation() async{
    if (imageXFile==null){
      showDialog(
        context: context,
        builder: (c){
          return ErrorDialog(
              message: "Select an image to proceed!",
          );
        }
      );
    }
    else{
      if(confirmPasswordController.text == passwordController.text){

        if(confirmPasswordController.text.isNotEmpty && emailController.text.isNotEmpty && nameController.text.isNotEmpty ){
          showDialog(
              context: context,
              builder: (c){
                return LoadingDialog(
                    message: "Signing up",
                );
              }
          );

          String fileName = DateTime.now().millisecondsSinceEpoch.toString();
          fStorage.Reference reference = fStorage.FirebaseStorage.instance.ref().child("users").child(fileName);
          fStorage.UploadTask uploadTask = reference.putFile(File(imageXFile!.path));
          fStorage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
          await taskSnapshot.ref.getDownloadURL().then((url) {
            chefImageURL=url;
            //save information to firestore
            authenticateChefAndSignup();
          });

        }

        else{
          showDialog(
              context: context,
              builder: (c){
                return ErrorDialog(
                  message: "Enter the required details!",
                );
              }
          );
        }

      }
      else{
        showDialog(
            context: context,
            builder: (c){
              return ErrorDialog(
                message: "Passwords do not match!",
              );
            }
        );
      }
    }
  }



  Future saveDataToFirestore(User currentUser) async{
    FirebaseFirestore.instance.collection("users").doc(currentUser.uid).set({
      "userUid": currentUser.uid,
      "userEmail": currentUser.email,
      "userName": nameController.text.trim(),
      "userPhotoUrl": chefImageURL,
      "status": "approved",
      "userCart": ['garbageValue'],

    });


    //save data locally

    sharedPreferences= await SharedPreferences.getInstance();
    await sharedPreferences!.setString("uid", currentUser.uid);
    await sharedPreferences!.setString("email", currentUser.email.toString());
    await sharedPreferences!.setString("name", nameController.text.trim());
    await sharedPreferences!.setString("photoUrl", chefImageURL);
    await sharedPreferences!.setStringList("userCart", ['garbageValue']);
  }
  void authenticateChefAndSignup() async {
    User? currentUser;


    await firebaseAuth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()
    ).then((auth) {
      currentUser = auth.user;
    }).catchError((error){
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (c){
            return ErrorDialog(
              message: error.message.toString(),
            );
          }
      );

    });

    if (currentUser != null) {
      saveDataToFirestore(currentUser!).then((value) {
        Navigator.pop(context);

        Route newRoute = MaterialPageRoute(builder: (c) => HomeScreen());
        Navigator.pushReplacement(context, newRoute);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children:[
              SizedBox(height: 15,),
              InkWell(
                onTap: (){
                  _getImage();
                },
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width * 0.20,
                  backgroundColor: Colors.white,
                  backgroundImage: imageXFile==null ? null : FileImage(File(imageXFile!.path)),
                  child: imageXFile==null ? Icon(
                    Icons.add_photo_alternate,
                    size: MediaQuery.of(context).size.width * 0.20,
                    color: Colors.grey,
                  ) : null ,
                )
              ),
              const SizedBox(height: 10,),
              Form(
                  key: _formkey,
                child: Column(
                  children: [
                    CustomTextField(
                      data: Icons.person,
                      controller: nameController,
                      hintText: "Name",
                      isObsecre: false,

                    ),
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
                    CustomTextField(
                      data: Icons.lock,
                      controller: confirmPasswordController,
                      hintText: "Confirm Password",
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
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffffcad4),
                ),
                  
              ),
              const SizedBox(height: 10,),
            ]
          )
      )
    );
  }



}
