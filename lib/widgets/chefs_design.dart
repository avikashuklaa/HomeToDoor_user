import 'package:flutter/material.dart';
import 'package:hometodoor_user/mainScreens/menu_screen.dart';

import '../models/chefs.dart';

class ChefsDesignWidget extends StatefulWidget {


  Chefs? model;
  BuildContext? context;

  ChefsDesignWidget({this.model, this.context});

  @override
  State<ChefsDesignWidget> createState() => _ChefsDesignWidgetState();
}

class _ChefsDesignWidgetState extends State<ChefsDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (c) => MenusScreen(model: widget.model)));
      },
      splashColor: Colors.red,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          height: 320,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Divider(
                height: 4,
                thickness: 3,
                color: Colors.blueGrey[50],
              ),
              Image.network(
                  widget.model!.chefAvatarUrl!,
                  height: 260.0,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(height: 8.0,
              ),
              Text(
                widget.model!.chefName!,
                style: TextStyle(color: Colors.black,
                fontSize: 23,
                fontFamily: "Varela"),
              ),
              SizedBox(height: 5.0,
              ),
              // Text(
              //   widget.model!.chefEmail!,
              //   style: TextStyle(color: Colors.blueGrey,
              //       fontSize: 13,
              //       fontFamily: "Varela",
              //     fontWeight: FontWeight.bold
              //   ),
              // ),


            ],
          ),
        ),
      ),
    );
  }
}
