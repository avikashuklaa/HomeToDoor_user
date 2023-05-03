import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hometodoor_user/widgets/app_bar.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

import '../assistantMethods/assistant_methods.dart';
import '../models/items.dart';

class ItemDetailsScreen extends StatefulWidget {
 final Items? model;
 ItemDetailsScreen({this.model});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {

  TextEditingController counterTextEditingController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(chefUID: widget.model!.chefUID),
      body: Column(

        children: [
          Image.network(widget.model!.thumbnailUrl.toString()),

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: NumberInputPrefabbed.roundedButtons(
                controller: counterTextEditingController,
              incDecBgColor: Color(0xff2ec4b6),
              min: 1,
              max: 9,
              initialValue: 1,              buttonArrangement: ButtonArrangement.incRightDecLeft
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.title.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontFamily: "VarelaRound"),
            ),         ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.model!.info.toString(), style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20, fontFamily: "VarelaRound"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
             "₹ " + widget.model!.price.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontFamily: "VarelaRound"),
            ),
          ),
          SizedBox(height: 20,),
          Center(
            child: InkWell(
              onTap: () {
                  int itemCounter = int.parse(counterTextEditingController.text);

                  List<String> seperateItemIDsList = seperateItemIDs();

                  //check if item already exists in cart
                  seperateItemIDsList.contains(widget.model!.itemID) ?
                      Fluttertoast.showToast(msg: "Item is already in the cart") : addItemToCart(widget.model!.itemID, context, itemCounter);
              },
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff087e8b),
                      Color(0xff087e8b),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                ),
                width: MediaQuery.of(context).size.width - 90,
                height: 50,
                child: Center(
                  child: Text(
                    "Add to cart",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
