import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hometodoor_user/global/global.dart';

seperateItemIDs(){
  List<String> seperateItemIDsList = [], defaultItemList = [];
  int i=0;

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for(i; i<defaultItemList.length; i++)
    {
      String item = defaultItemList[i].toString();
      var pos = item.lastIndexOf(":");

      String getItemId = (pos !=-1)? item.substring(0, pos) : item;

      print("This is item ID now = " + getItemId);
      seperateItemIDsList.add(getItemId);
    }

  print("This is items list now = ");
  print(seperateItemIDsList);

  return seperateItemIDsList;


}

addItemToCart(String? foodItemId, BuildContext context, int itemCounter){

  List<String>? tempList = sharedPreferences!.getStringList("userCart");
  tempList!.add(foodItemId! + " :$itemCounter");

  FirebaseFirestore.instance.collection("users").doc(firebaseAuth.currentUser!.uid).update({
    "userCart":tempList,
  }).then((value){

    Fluttertoast.showToast(msg: "Item added successfully!");
    sharedPreferences!.setStringList("userCart", tempList);
  });



}