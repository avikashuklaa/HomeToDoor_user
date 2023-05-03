import 'package:flutter/material.dart';
import 'package:hometodoor_user/mainScreens/items_screen.dart';

import '../models/chefs.dart';
import '../models/menus.dart';

class MenusDesignWidget extends StatefulWidget {


  Menus? model;
  BuildContext? context;

  MenusDesignWidget({this.model, this.context});

  @override
  State<MenusDesignWidget> createState() => _MenusDesignWidgetState();
}

class _MenusDesignWidgetState extends State<MenusDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c) => ItemsScreen(model: widget.model)));
      },
      splashColor: Colors.red,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          height: 252,
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
                widget.model!.menuTitle!,
                style: TextStyle(color: Colors.black,
                    fontSize: 20,
                    fontFamily: "Varela"),
              ),
              // Text(
              //   widget.model!.menuInfo!,
              //   style: TextStyle(color: Colors.black,
              //       fontSize: 15,
              //       fontFamily: "Varela"),
              // ),


            ],
          ),
        ),
      ),
    );
  }
}
