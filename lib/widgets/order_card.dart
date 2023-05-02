import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hometodoor_user/mainScreens/order_details_screen.dart';

import '../models/items.dart';

class OrderCard extends StatelessWidget {

  final int? itemCount;
  final List<DocumentSnapshot>? data;
  final String? orderID;
  final List<String>? seperateQuantitiesList;

  OrderCard({
    this.itemCount,
    this.data,
    this.orderID,this.seperateQuantitiesList
 });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (c) => OrderDetailsScreen(orderID: orderID,)));
      },
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black12,
              Colors.black12
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        height: itemCount! * 125,
        child: ListView.builder(
          itemCount: itemCount,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index)
          {
            Items model = Items.fromJson(data![index].data()! as Map<String, dynamic>);
            return placedOrderDesignWidget(model, context, seperateQuantitiesList![index]);
          },
        ),

      ),
    );
  }
}

Widget placedOrderDesignWidget(Items model, BuildContext context, seperateQuantitiesList){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 120,
    color: Colors.grey[200],
    child: Row(
      children: [
        Image.network(model.thumbnailUrl!, width: 120,),
        SizedBox(width: 10,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Text(
                      model.title!,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,

                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Text(
                    "₹" ,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16
                    ),
                  ),
                  Text(
                    model.price.toString(),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text(
                    "x ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14
                    ),
                  ),
                  Expanded(
                    child: Text(
                      seperateQuantitiesList,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 25,

                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    ),
  );
}

