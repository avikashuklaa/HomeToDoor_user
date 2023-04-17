import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hometodoor_user/assistantMethods/cart_item_counter.dart';
import 'package:hometodoor_user/global/global.dart';
import 'package:hometodoor_user/splashScreen/splash_screen.dart';
import 'package:provider/provider.dart';

seperateItemIDs(){
  List<String> seperateItemIDsList = [], defaultItemList = [];
  int i=0;

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for(i; i<defaultItemList.length; i++)
    {
      String item = defaultItemList[i].toString();
      var pos = item.lastIndexOf(":");

      String getItemId = (pos != -1)? item.substring(0, pos) : item;

      print("This is item ID now = " + getItemId);
      seperateItemIDsList.add(getItemId);
    }

  print("This is items list now = ");
  print(seperateItemIDsList);

  return seperateItemIDsList;


}

addItemToCart(String? foodItemId, BuildContext context, int itemCounter){

  List<String>? tempList = sharedPreferences!.getStringList("userCart");
  tempList!.add(foodItemId! + ":$itemCounter");

  FirebaseFirestore.instance.collection("users").doc(firebaseAuth.currentUser!.uid).update({
    "userCart":tempList,
  }).then((value){

    Fluttertoast.showToast(msg: "Item added successfully!");
    sharedPreferences!.setStringList("userCart", tempList);

    //update the badge
    Provider.of<CartItemCounter>(context, listen: false).displayCartListItemNumber();
  });





}

seperateItemQuantities(){
  List<int> seperateItemQuantityList = [];
  List<String> defaultItemList = [];
  int i=1;

  defaultItemList = sharedPreferences!.getStringList("userCart")!;

  for(i; i<defaultItemList.length; i++)
  {
    // 5665789:7
    String item = defaultItemList[i].toString();
    
    // 7
    List<String> listItemCharacters = item.split(":").toList();
    var quanNumber = int.parse(listItemCharacters[1].toString());
    

    print("This is quantity number = " + quanNumber.toString());
    seperateItemQuantityList.add(quanNumber);
  }

  print("This is items list now = ");
  print(seperateItemQuantityList);

  return seperateItemQuantityList;


}

clearCartNow(context){

  sharedPreferences!.setStringList("userCart", ['garbageValue']);
  List<String>? emptyList = sharedPreferences!.getStringList("userCart");
  FirebaseFirestore.instance.collection("users").doc(firebaseAuth.currentUser!.uid).
  update({"userCart" : emptyList}).then((value)
      {
        sharedPreferences!.setStringList("userCart", emptyList!);
        Provider.of<CartItemCounter>(context, listen: false).displayCartListItemNumber();
        

      });
}