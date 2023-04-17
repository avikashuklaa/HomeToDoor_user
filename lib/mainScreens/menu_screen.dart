import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../assistantMethods/assistant_methods.dart';
import '../global/global.dart';
import '../models/chefs.dart';
import '../models/menus.dart';
import '../splashScreen/splash_screen.dart';
import '../widgets/chefs_design.dart';
import '../widgets/menus_design.dart';
import '../widgets/my_drawer.dart';
import '../widgets/progress_bar.dart';
import '../widgets/text_widget_header.dart';


class MenusScreen extends StatefulWidget {

  final Chefs? model;
  MenusScreen({this.model});

  @override
  State<MenusScreen> createState() => _MenusScreenState();
}

class _MenusScreenState extends State<MenusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
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
              clearCartNow(context);
              Navigator.push(context, MaterialPageRoute(builder: (c) => MySplashScreen()));
              //Fluttertoast.showToast(msg: "The cart has been cleared.");
            },
          ),
          title: Text(
            "HomeToDoor"
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,


        ),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(pinned: true,
                delegate: TextWidgetHeader(title: widget.model!.chefName.toString() + " Menu")),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("chefs").doc(widget.model!.chefUid)
                  .collection("Menu").orderBy("publishedDate", descending: true).
              snapshots(),
              builder: (context, snapshot)
              {
                return !snapshot.hasData
                    ? SliverToBoxAdapter(
                  child: Center(
                    child: circularProgress(),
                  ),
                )
                    : SliverStaggeredGrid.countBuilder(
                  crossAxisCount: 1,
                  staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                  itemBuilder: (context, index)
                  {
                    Menus model = Menus.fromJson(
                      snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                    );
                    return MenusDesignWidget(
                      model: model,
                      context: context,
                    );
                  },
                  itemCount: snapshot.data!.docs.length,
                );
              },
            )
          ],
        )
    );
  }
}
