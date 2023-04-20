import 'package:flutter/material.dart';
import 'package:hometodoor_user/assistantMethods/address_changer.dart';
import 'package:hometodoor_user/mainScreens/placed_order_screen.dart';
import 'package:provider/provider.dart';

import '../maps/maps.dart';
import '../models/address.dart';

class AddressDesign extends StatefulWidget {

  final Address? model;
  final int? currentIndex;
  final int? value;
  final String? addressID;
  final double? totalAmount;
  final String? chefUID;

  AddressDesign({

    this.model,
    this.currentIndex,
    this.value,
    this.addressID,
    this.totalAmount,
    this.chefUID
  });

  @override
  State<AddressDesign> createState() => _AddressDesignState();
}

class _AddressDesignState extends State<AddressDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()
          {
            Provider.of<AddressChanger>(context, listen: false).displayResult(widget.value);

          },
      child: Card(
        color: Colors.black12.withOpacity(0.4),
        child: Column(
          children: [
            Row(
              children: [
                Radio(
                  groupValue: widget.currentIndex!,
                  value: widget.value!,
                  activeColor: Colors.pink,
                  onChanged: (val){
                    //provider
                    Provider.of<AddressChanger>(context, listen: false).displayResult(val);
                  },
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Table(
                        children: [
                          TableRow(
                            children: [Text(
                              "Name: ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                              Text(widget.model!.name.toString())
                        ]
                          ),
                          TableRow(
                              children: [Text(
                                "Phone Number: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                                Text(widget.model!.phoneNumber.toString())
                              ]
                          ),
                          TableRow(
                              children: [Text(
                                "Flat Number: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                                Text(widget.model!.flatNumber.toString())
                              ]
                          ),
                          TableRow(
                              children: [Text(
                                "City: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                                Text(widget.model!.city.toString())
                              ]
                          ),
                          TableRow(
                              children: [Text(
                                "State: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                                Text(widget.model!.state.toString())
                              ]
                          ),
                          TableRow(
                              children: [Text(
                                "Full Address: ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                                Text(widget.model!.fullAddress.toString())
                              ]
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              child: Text(
                "Check on maps",
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.black54,
              ),
              onPressed: (){
                MapsUtils.openMapWithPosition(widget.model!.lat!,widget.model!.lng!);

              },
            ),

            widget.value == Provider.of<AddressChanger>(context).count
            ? ElevatedButton(
                child: Text(
                  "Proceed"
                ),
              style: ElevatedButton.styleFrom(
                primary: Colors.pink
              ),
              onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c) => PlacedOrderScreen(
                    addressID : widget.addressID,
                    totalAmount : widget.totalAmount,
                    chefUID : widget.chefUID
                  )));
              },
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}
