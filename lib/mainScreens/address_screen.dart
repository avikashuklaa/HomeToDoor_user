import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hometodoor_user/mainScreens/save_address_screen.dart';
import 'package:hometodoor_user/widgets/simple_app_bar.dart';
import 'package:provider/provider.dart';

import '../assistantMethods/address_changer.dart';
import '../global/global.dart';
import '../models/address.dart';
import '../widgets/address_design.dart';
import '../widgets/progress_bar.dart';

class AddressScreen extends StatefulWidget {

  final double? totalAmount;
  final String? chefUID;

  AddressScreen({this.totalAmount, this.chefUID});


  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(title: "HomeToDoor",),
      floatingActionButton: FloatingActionButton.extended(
          label: Text(
            "Add new address",
          ),
        backgroundColor: Color(0xff087e8b),
        icon: Icon(
          Icons.add_location,
          color: Colors.white,
        ),
        onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (c)=>SaveAddressScreen()));
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Text("Select Address : ",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),),
            ),
          ),

          Consumer<AddressChanger>(builder: (context, address, c){
            return Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream:  FirebaseFirestore.instance.collection("users").doc(sharedPreferences!.getString("uid"))
                    .collection("userAddress").snapshots(),
                builder: (context, snapshot){
                  return !snapshot.hasData
                      ? Center(child: circularProgress(),)
                      : snapshot.data!.docs.length == 0
                      ? Container()
                      : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index){
                      return AddressDesign(
                        currentIndex: address.count,
                        value: index,
                        addressID: snapshot.data!.docs[index].id,
                        totalAmount: widget.totalAmount,
                        chefUID: widget.chefUID,
                        model: Address.fromJson(
                          snapshot.data!.docs[index].data()! as Map<String, dynamic>
                        ),
                      );
                    },
                  );
                },
              ),
            );
          })
        ],
      ),
    );
  }
}
