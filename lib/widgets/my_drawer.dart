import 'package:flutter/material.dart';
import 'package:hometodoor_user/global/global.dart';
import 'package:hometodoor_user/mainScreens/address_screen.dart';
import 'package:hometodoor_user/mainScreens/history_screen.dart';
import 'package:hometodoor_user/mainScreens/home_screen.dart';
import 'package:hometodoor_user/mainScreens/my_orders_screen.dart';
import 'package:hometodoor_user/mainScreens/search_screen.dart';

import '../authentication/auth_screen.dart';

class MyDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          //header drawer
          Container(
            padding: EdgeInsets.only(top: 25, bottom: 10),
            child: Column(
              children: [

                Material(
                  borderRadius: BorderRadius.all(Radius.circular(80)),
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.all(1.0),
                    child: Container(
                      height: 160,
                      width: 160,
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                          sharedPreferences!.getString("photoUrl")!
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  sharedPreferences!.getString("name")!,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontFamily:"Signatra",
                  ),
                )
              ],
            ),
          ),
          //body drawer
          SizedBox(height: 12.0,),
          Container(
            padding: EdgeInsets.only(top: 1.0),
            child: Column(
              children: [
                Divider(
                  height: 10.0,
                  color: Colors.blueGrey[50],
                  thickness: 2.0,
                ),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Home",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c) => HomeScreen()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.reorder,
                    color: Colors.black,
                  ),
                  title: Text(
                    "My Orders",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (c) => MyOrdersScreen()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.history,
                    color: Colors.black,
                  ),
                  title: Text(
                    "History",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c) => HistoryScreen()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Search",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c) => SearchScreen()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.location_city,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Add new address",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (c) => AddressScreen()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onTap: (){
                      firebaseAuth.signOut().then((value){
                      Navigator.push(context, MaterialPageRoute(builder: (c)=>AuthScreen()));
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
