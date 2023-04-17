import 'package:flutter/material.dart';
import 'package:hometodoor_user/widgets/simple_app_bar.dart';

class SaveAddressScreen extends StatelessWidget {
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final flatNUmber = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final completeAddress = TextEditingController();
  final _locationController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SimpleAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Save Address",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.person_pin_circle,
                color: Colors.black,
                size: 35,
              ),
              title: Container(
                width: 250,
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  controller:_locationController,
                  decoration: InputDecoration(
                    hintText: "Enter the address",
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
