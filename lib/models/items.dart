import 'package:cloud_firestore/cloud_firestore.dart';

class Items{

  String? menuID;
  String? chefUID;
  String? itemID;
  String? title;
  String? info;
  Timestamp? publishedDate;
  String? thumbnailUrl;
  String? status;
  String? description;
  int? price;

  Items({
    this.menuID,
    this.chefUID,
    this.itemID,
    this.title,
    this.info,
    this.description,
    this.publishedDate,
    this.thumbnailUrl,
    this.status,
  });

  Items.fromJson(Map<String,dynamic> json){
    menuID=json["menuID"];
    itemID=json["itemID"];
    chefUID=json['chefUID'];
    title=json['title'];
    info = json['info'];
    description = json['description'];
    price = json['price'];
    publishedDate = json['publishedDate'];
    thumbnailUrl=json['thumbnailurl'];
    status=json['status'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["menuID"]=menuID;
    data["itemID"]=itemID;
    data['chefUID']=chefUID;
    data['title']=title;
    data['info']=info;
    data['description']=description;
    data['price']=price;
    data['publishedDate']=publishedDate;
    data['thumbnailurl']=thumbnailUrl;
    data['status']=status;

    return data;

  }

}