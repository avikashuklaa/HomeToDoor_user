import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hometodoor_user/mainScreens/address_screen.dart';
import 'package:hometodoor_user/widgets/app_bar.dart';
import 'package:hometodoor_user/widgets/cart_item_design.dart';
import 'package:provider/provider.dart';

import '../assistantMethods/assistant_methods.dart';
import '../assistantMethods/cart_item_counter.dart';
import '../assistantMethods/total_amount.dart';
import '../models/items.dart';
import '../splashScreen/splash_screen.dart';
import '../widgets/progress_bar.dart';
import '../widgets/text_widget_header.dart';

class CartScreen extends StatefulWidget {

  final String? chefUID;

  CartScreen({this.chefUID});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int>? seperateItemQuantityList;

  num totalAmount = 0;

  @override
  void initState() {
   super.initState();

   totalAmount=0;
   Provider.of<TotalAmount>(context, listen: false).displayTotalAmount(0);
   seperateItemQuantityList = seperateItemQuantities();
  }

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
              Icons.clear_all
          ),
          onPressed: (){
              clearCartNow(context);
          },
        ),
        //title: Text(
        //    "HomeToDoor"
       // ),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          Stack(
            children: [
              IconButton(
                  onPressed: (){
                    print("Clicked");
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
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(width: 5,),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              heroTag: "btn1",
              label: Text(
                "Clear cart",
                style: TextStyle(fontSize: 15),
              ),
              backgroundColor: Colors.blueGrey,
              icon: Icon(
                Icons.delete
              ),
              onPressed: (){
                  clearCartNow(context);
                  Navigator.push(context, MaterialPageRoute(builder: (c) => MySplashScreen()));
                  Fluttertoast.showToast(msg: "The cart has been cleared.");
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: FloatingActionButton.extended(
              heroTag: "btn2",
              label: Text(
                "Checkout",
                style: TextStyle(fontSize: 15),
              ),
              backgroundColor: Colors.blueGrey,
              icon: Icon(
                  Icons.navigate_next
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (c) =>
                        AddressScreen(
                          totalAmount: totalAmount.toDouble(),
                          chefUID: widget.chefUID,
                        )));

              },
            ),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              pinned: true,
              delegate: TextWidgetHeader(title: "Cart")
          ),

          SliverToBoxAdapter(
            child: Consumer2<TotalAmount, CartItemCounter>(builder: (context, amountProvider, cartProvider, c){
              return Padding(
                padding: EdgeInsets.all(8),
                child: Center(
                  child: cartProvider.count == 0
                      ? Container()
                  : Text("Total Amount: ${amountProvider.tAmount.toString()}",
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500
                  ),),
                ),
              );
            })
          ),

          StreamBuilder(
              stream: FirebaseFirestore.instance.
              collection("items").where("itemID", whereIn: seperateItemIDs())
                  .orderBy("publishedDate", descending: true)
            .snapshots(),
            builder: (context, snapshot){
                return !snapshot.hasData
                    ? SliverToBoxAdapter(child: Center(child: circularProgress(),),)
                    : snapshot.data!.docs.length == 0
                    ? Container()
                    : SliverList(
                  delegate: SliverChildBuilderDelegate((context, index){
                    Items model = Items.fromJson(snapshot.data!.docs[index].data()! as Map<String, dynamic>,
                    );

                    if(index==0){
                      totalAmount = 0;
                      totalAmount = totalAmount + (model.price! * seperateItemQuantityList![index]);
                    }
                    else
                      {
                        totalAmount = totalAmount + (model.price! * seperateItemQuantityList![index]);
                      }

                    if(snapshot.data!.docs.length - 1 == index){

                      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {

                        Provider.of<TotalAmount>(context, listen: false).displayTotalAmount(totalAmount.toDouble());

                      });
                    }

                    return CartItemDesign(
                      model: model,
                      context: context,
                      quanNumber: seperateItemQuantityList![index],
                    );
                  },
                    childCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
                  ),

                                 );
            },
          )
        ],
      ),
    );
  }
}
