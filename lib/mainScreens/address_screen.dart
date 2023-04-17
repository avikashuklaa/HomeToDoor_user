import 'package:flutter/material.dart';
import 'package:hometodoor_user/mainScreens/save_address_screen.dart';
import 'package:hometodoor_user/widgets/simple_app_bar.dart';

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
      appBar: SimpleAppBar(),
      floatingActionButton: FloatingActionButton.extended(
          label: Text(
            "Add new address",
          ),
        backgroundColor: Colors.blueGrey,
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
              child: Text("Select Address",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20.0
              ),),
            ),
          )
        ],
      ),
    );
  }
}
