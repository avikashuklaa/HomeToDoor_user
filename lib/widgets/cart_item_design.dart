import 'package:flutter/material.dart';

import '../models/items.dart';

class CartItemDesign extends StatefulWidget {
  final Items? model;
  BuildContext? context;
  final int? quanNumber;

  CartItemDesign({
    this.model,
    this.context,
    this.quanNumber
  });

  @override
  State<CartItemDesign> createState() => _CartItemDesignState();
}

class _CartItemDesignState extends State<CartItemDesign> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.cyan,
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: Container(
          height: 120,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Image.network(widget.model!.thumbnailUrl!, width: 180, height: 160,),
              SizedBox(width: 10.0,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.model!.title!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  Row(
                    children: [
                      Text(
                        "x ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.0,
                           // fontFamily: "Signatra",
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        widget.quanNumber.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 21.0,
                            fontWeight: FontWeight.bold
                            // fontFamily: "Signatra"
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 2,),
                  Row(
                    children: [
                      Text(
                    "Price: ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                    ),
                  ),
                      Text(
                        "₹ ",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        widget.model!.price.toString(),
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 18.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ]
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
