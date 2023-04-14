import 'package:cloud_firestore/cloud_firestore.dart';

class Menus{

  String? menuID;
  String? chefUID;
  String? menuTitle;
  String? menuInfo;
  Timestamp? publishedDate;
  String? thumbnailUrl;
  String? status;

  Menus({
    this.menuID,
    this.chefUID,
    this.menuTitle,
    this.menuInfo,
    this.publishedDate,
    this.thumbnailUrl,
    this.status,
});

  Menus.fromJson(Map<String,dynamic> json){
    menuID=json["menuID"];
    chefUID=json['chefUID'];
    menuTitle=json['menuTitle'];
    menuInfo = json['menuInfo'];
    publishedDate = json['publishedDate'];
    thumbnailUrl=json['thumbnailurl'];
    status=json['status'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["menuID"]=menuID;
    data['chefUID']=chefUID;
    data['menuTitle']=menuTitle;
    data['menuInfo']=menuInfo;
    data['publishedDate']=publishedDate;
    data['thumbnailurl']=thumbnailUrl;
    data['status']=status;

    return data;

  }

}