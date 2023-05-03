import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hometodoor_user/widgets/chefs_design.dart';

import '../models/chefs.dart';

class SearchScreen extends StatefulWidget {

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  Future<QuerySnapshot>? restaurantsDocumentsList;
  String sellerNameText="";

  initSearchRestaurant(String textEntered) {
    restaurantsDocumentsList = FirebaseFirestore.instance.collection("chefs")
        .where("chefName", isGreaterThanOrEqualTo: textEntered).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff2ec4b6),
                Color(0xff023e8a),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: TextField(
          onChanged: (textEntered){
              setState(() {
                sellerNameText = textEntered;
              });
              initSearchRestaurant(textEntered);
          },
          decoration: InputDecoration(
            hintText: "Search here",
            hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
            ),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              color: Colors.white,
              onPressed: (){
                initSearchRestaurant(sellerNameText);
              },
            )
          ),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16
          ),
        ),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: restaurantsDocumentsList,
        builder: (context, snapshot){
          return snapshot.hasData
              ? ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index){
              Chefs model = Chefs.fromJson(snapshot.data!.docs[index].data()! as Map<String, dynamic>);

              return ChefsDesignWidget(model: model, context: context);
            },
          )
              : Center(
            child: Text(
              "No records found!",
              style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 19
              ),
            ),
          );
        },
      ),
    );
  }
}
