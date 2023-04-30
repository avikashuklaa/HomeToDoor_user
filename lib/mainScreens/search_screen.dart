import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  initSearchRestaurant(String textEntered) async{
    FirebaseFirestore.instance.collection("chefs")
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
        title: TextField(
          onChanged: (textEntered){
              initSearchRestaurant(textEntered);
          },
          decoration: InputDecoration(
            hintText: "Search here",
            hintStyle: TextStyle(
              color: Colors.white54,
              fontWeight: FontWeight.bold
            ),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              color: Colors.white,
              onPressed: (){

              },
            )
          ),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16
          ),
        ),
      ),
    );
  }
}
