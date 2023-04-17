import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hometodoor_user/widgets/app_bar.dart';

import '../global/global.dart';
import '../models/items.dart';
import '../models/menus.dart';
import '../widgets/chefs_design.dart';
import '../widgets/items_design.dart';
import '../widgets/my_drawer.dart';
import '../widgets/progress_bar.dart';
import '../widgets/text_widget_header.dart';


class ItemsScreen extends StatefulWidget {

  final Menus? model;
  ItemsScreen({this.model});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: MyAppBar(chefUID: widget.model!.chefUID),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(pinned: true,
                delegate: TextWidgetHeader(title: "Items")),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("chefs")
                  .doc(widget.model!.chefUID)
                  .collection("Menu")
                  .doc(widget.model!.menuID).collection("items")
                  .orderBy("publishedDate", descending: true).
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
                    Items model = Items.fromJson(
                      snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                    );
                    return ItemsDesignWidget(
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
