import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hometodoor_user/assistantMethods/assistant_methods.dart';
import 'package:hometodoor_user/global/global.dart';
import 'package:hometodoor_user/mainScreens/home_screen.dart';

class PlacedOrderScreen extends StatefulWidget {

  String? addressID;
  double? totalAmount;
  String? chefUID;

  PlacedOrderScreen({
    this.addressID,
    this.totalAmount, this.chefUID
  });

  @override
  State<PlacedOrderScreen> createState() => _PlacedOrderScreenState();
}

class _PlacedOrderScreenState extends State<PlacedOrderScreen> {

  String orderId = DateTime.now().millisecondsSinceEpoch.toString();

  addOrderDetails(){

    writeOrderDetailsForUser({
     "addressID" : widget.addressID,
     "totalAmount" : widget.totalAmount,
     "orderBy" : sharedPreferences!.getString("uid"),
     "productIDs" : sharedPreferences!.getStringList("userCart"),
     "paymentDetails" : "Cash on delivery",
     "orderTime" : orderId,
     "isSuccess" : true,
     "chefUID" : widget.chefUID,
     "riderUID": "",
     "status" : "normal",
     "orderId" : orderId
    });

    writeOrderDetailsForChef({
  "addressID" : widget.addressID,
  "totalAmount" : widget.totalAmount,
  "orderBy" : sharedPreferences!.getString("uid"),
  "productIDs" : sharedPreferences!.getStringList("userCart"),
  "paymentDetails" : "Cash on delivery",
  "orderTime" : orderId,
  "isSuccess" : true,
  "chefUID" : widget.chefUID,
  "riderUID": "",
  "status" : "normal",
  "orderId" : orderId
 }).whenComplete((){
   clearCartNow(context);
   setState(() {
     orderId="";
     Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));
     Fluttertoast.showToast(msg: "Order has been placed.");
   });
  });

  }

  Future writeOrderDetailsForUser(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection("users")
        .doc(sharedPreferences!.getString("uid")).collection("orders")
        .doc(orderId)
        .set(data);
  }

  Future writeOrderDetailsForChef(Map<String, dynamic> data) async {
  await FirebaseFirestore.instance.collection("orders")
      .doc(orderId)
      .set(data);
}
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffffffff),
              Color(0xffcbf3f0),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/delivery.jpg", width: 320,),
            SizedBox(height: 20,),


            ElevatedButton(
              child: Text(
                  "Place Order"
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff087e8b)
              ),
              onPressed: (){
                addOrderDetails();
              },
            )
          ],
        ),
      ),
    );
  }
}
