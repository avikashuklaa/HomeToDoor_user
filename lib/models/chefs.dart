class Chefs{

  String? chefName;
  String? chefUid;
  String? chefAvatarUrl;
  String? chefEmail;

  Chefs({
    this.chefUid,
    this.chefName,
    this.chefAvatarUrl,
    this.chefEmail,

});

  Chefs.fromJson(Map<String, dynamic> json){
    chefUid = json["chefUid"];
    chefName = json["chefName"];
    chefAvatarUrl= json["chefAvatarUrl"];
    chefEmail = json["chefEmail"];

  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["chefUid"] = this.chefUid;
    data["chefName"] = this.chefName;
    data["chefAvatarUrl"] = this.chefAvatarUrl;
    data["chefEmail"] = this.chefEmail;

    return data;
  }

}