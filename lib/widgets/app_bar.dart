import 'package:flutter/material.dart';
import 'package:hometodoor_user/assistantMethods/cart_item_counter.dart';
import 'package:hometodoor_user/mainScreens/cart_screen.dart';
import 'package:provider/provider.dart';

class MyAppBar extends StatefulWidget with PreferredSizeWidget {
  final PreferredSizeWidget? bottom;
  final String? chefUID;
  MyAppBar({this.bottom, this.chefUID});

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override

  Size get preferredSize => bottom==null ? Size(56, AppBar().preferredSize.height) : Size(56, 80 + AppBar().preferredSize.height);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffff99c8),
              Color(0xff023e8a),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
      ),
      leading: IconButton(
        icon: Icon(
            Icons.arrow_back
        ),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      title: Text(
          "HomeToDoor"
      ),
      centerTitle: true,
      automaticallyImplyLeading: true,
      actions: [
        Stack(
          children: [
            IconButton(
                onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c) => CartScreen(chefUID: widget.chefUID)));
                },
                icon: Icon(Icons.shopping_cart)),
            Positioned(
              child: Stack(
                children: [
                  Icon(
                    Icons.brightness_1,
                    size: 20.0,
                    color: Colors.black,
                  ),
                  Positioned(
                    top: 3,
                    right: 4,
                    child: Center(
                      child: Consumer<CartItemCounter>(
                        builder: (context, counter, c){
                          return Text(counter.count.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),),
          ],
        )
      ],
    );
  }
}
