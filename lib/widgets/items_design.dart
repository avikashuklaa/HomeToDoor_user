import 'package:flutter/material.dart';
import 'package:hometodoor_user/mainScreens/item_detail_screen.dart';

import '../models/chefs.dart';
import '../models/items.dart';

class ItemsDesignWidget extends StatefulWidget {


  Items? model;
  BuildContext? context;

  ItemsDesignWidget({this.model, this.context});

  @override
  State<ItemsDesignWidget> createState() => _ItemsDesignWidgetState();
}

class _ItemsDesignWidgetState extends State<ItemsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c) => ItemDetailsScreen(model: widget.model)));
      },
      splashColor: Colors.red,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          height: 295,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.blueGrey[50],
              ),
              Image.network(
                widget.model!.thumbnailUrl!,
                height: 210.0,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 8.0,
              ),
              Text(
                widget.model!.title!,
                style: TextStyle(color: Colors.blueGrey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Varela"),
              ),
              SizedBox(height: 5.0,
              ),
              Text(
                widget.model!.info!,
                style: TextStyle(color: Colors.blueGrey,
                    fontSize: 15,
                    fontFamily: "Varela"),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
