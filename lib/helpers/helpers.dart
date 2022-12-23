import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AppVariabel{
  static const String isLogin = "isLogin";
  static const String email = "email";
  static const String token = "token";
  static const String name = "name";
  static const String indexLogin = "idLogin";

  static const String AppTitle = "AppChat";
  static const String AppTitleMessage = "";
  static const String ImageGroup = "";
}

enum LoginStatus{
  notSignIn,
  signIn,
}
extension StringCasingExtension on String {
  String toCapitalized() => length > 0 ?'${this[0].toUpperCase()}${substring(1).toLowerCase()}':'';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ').split(' ').map((str) => str.toCapitalized()).join(' ');
}
class AppAlert {
  static getAlertConnectionLost( String? title, String message, onPressed) {
    return  Get.defaultDialog(
      title: title??"INFO",
      textConfirm: 'Close',
      buttonColor: Colors.red,
      confirmTextColor: Colors.white,
      onConfirm: onPressed,
      content: Text(message),
    );
  }
  static getAlert( String? title, String message, onPressed) {
    return  Get.defaultDialog(
      title: title??"INFO",
      actions: [
        Shortcuts(
          shortcuts: <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.select):const ActivateIntent()
          },
          child: OutlinedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              backgroundColor: MaterialStateProperty.all(Colors.red)
            ),
              onPressed: onPressed,
              child: const Text("Yes")
          ),
        ),
        Shortcuts(
          shortcuts: <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.select):const ActivateIntent()
          },
          child: OutlinedButton(
              onPressed: ()=>Get.back(),
              child: const Text("No")
          ),
        )
      ],
      content: Shortcuts(
          shortcuts: <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.select):const ActivateIntent()
          },
          child: Text(message)
      ),
    );
  }
  static getAlertUpdateApp( String? title, String message, onPressed) {
    return  Get.defaultDialog(
      title: title??"INFO",
      barrierDismissible: false,
      actions: [
        Shortcuts(
          shortcuts: <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.select):const ActivateIntent()
          },
          child: OutlinedButton(
              onPressed: onPressed,
              child: const Text("Update")
          ),
        ),
        Shortcuts(
          shortcuts: <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.select):const ActivateIntent()
          },
          child: OutlinedButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.red)
              ),
              onPressed: ()=> SystemNavigator.pop(),
              child: const Text("Close")
          ),
        )
      ],
      content: Shortcuts(
          shortcuts: <LogicalKeySet, Intent>{
            LogicalKeySet(LogicalKeyboardKey.select):const ActivateIntent()
          },
          child: WillPopScope(
              onWillPop: () async => false,
              child: Text(message)
          )
      ),
    );
  }
  static getAlertHapus(String? title, String message, onPressed) {
    return  Get.defaultDialog(
      title: title??"INFO",
      textConfirm: 'Yes',
      textCancel: 'Close',
      buttonColor: Colors.red,
      confirmTextColor: Colors.white,
      onConfirm: onPressed,
      content: Text(message),
    );
  }
  static loading() {
    return  Get.defaultDialog(
      barrierDismissible: false,
      title: "",
      backgroundColor: Colors.transparent,
      content: WillPopScope(
        onWillPop: () async => false,
        child: const CircularProgressIndicator(),
      ),
    );
  }

}

class Helpes{
  static saveLogin(bool isLogin, String email,String name,idLogin,token){
    GetStorage().write(AppVariabel.isLogin, isLogin);
    GetStorage().write(AppVariabel.name, name);
    GetStorage().write(AppVariabel.email, email);
    GetStorage().write(AppVariabel.token, token);
    GetStorage().write(AppVariabel.indexLogin, idLogin);
  }
}

class UsersObject {
  String id;
  final String token;
  final String email;
  final String name;
  final String image;
  final bool isLogin;
  final DateTime date;
  final DateTime lastLogin;

  UsersObject({required this.id,required this.isLogin,required this.date,required this.lastLogin,required this.token,required this.name,required this.email,required this.image});

  Map<String, dynamic> toJson() =>{
    'id' : id,
    'islogin' : isLogin,
    'token' : token,
    'email' : email,
    'name' : name,
    'image' : image,
    'date' : date,
    'lastlogin' : lastLogin
  };
  factory UsersObject.fromJson(Map<String, dynamic> json)=> UsersObject(
      id: json["id"]??'',
      isLogin: json["isLogin"]??false,
      date: (json["date"] as Timestamp).toDate(),
      lastLogin: (json["lastlogin"] as Timestamp).toDate(),
      token: json["token"]??"-",
      email: json["email"]??"-",
      name: json["name"]??"-",
      image: json["image"]??"-"
  );
}
class ImagesSlide1 {
  String id;
  String nameImg;
  String image;
  String judul;
  String screen;
  String email;
  String numberSlide;
  DateTime date;
  DateTime lastupdate;

  ImagesSlide1({required this.id,required this.screen,required this.nameImg,required this.judul,required this.date,required this.email,required this.numberSlide,required this.lastupdate,required this.image});

  Map<String, dynamic> toJson() =>{
    'id' : id,
    'name' : nameImg,
    'judul' : judul,
    'screen' : screen,
    'image' : image,
    'email' : email,
    'no_slide' : numberSlide,
    'date' : date,
    'last_update' : lastupdate
  };
  factory ImagesSlide1.fromJson(Map<String, dynamic> json)=> ImagesSlide1(
      id: json["id"]??'',
      nameImg: json["name"]??"-",
      judul: json["judul"]??"-",
      screen: json["screen"]??"default",
      image: json["image"]??"-",
      email: json["email"]??"-",
      numberSlide: json["no_slide"]??"-",
      date: (json["date"] as Timestamp).toDate(),
      lastupdate: (json["last_update"] as Timestamp).toDate(),
  );
}
class ImagesSlide2 {
  String id;
  String nameImg;
  String image;
  String judul;
  String screen;
  String email;
  String numberSlide;
  DateTime date;
  DateTime lastupdate;

  ImagesSlide2({required this.id,required this.nameImg,required this.screen,required this.judul,required this.date,required this.email,required this.numberSlide,required this.lastupdate,required this.image});

  Map<String, dynamic> toJson() =>{
    'id' : id,
    'name' : nameImg,
    'judul' : judul,
    'screen' : screen,
    'image' : image,
    'email' : email,
    'no_slide' : numberSlide,
    'date' : date,
    'last_update' : lastupdate
  };
  factory ImagesSlide2.fromJson(Map<String, dynamic> json)=> ImagesSlide2(
      id: json["id"]??'',
      nameImg: json["name"]??"-",
      judul: json["judul"]??"-",
      screen: json["screen"]??"default",
      image: json["image"]??"-",
      email: json["email"]??"-",
      numberSlide: json["no_slide"]??"-",
      date: (json["date"] as Timestamp).toDate(),
      lastupdate: (json["last_update"] as Timestamp).toDate(),
  );
}

class Videos1 {
  String id;
  String nameImg;
  String video;
  String judul;
  String screen;
  bool volume;
  String email;
  String numberSlide;
  DateTime date;
  DateTime lastupdate;

  Videos1({required this.id,required this.screen,required this.nameImg,required this.volume,required this.judul,required this.date,required this.email,required this.numberSlide,required this.lastupdate,required this.video});

  Map<String, dynamic> toJson() =>{
    'id' : id,
    'name' : nameImg,
    'judul' : judul,
    'screen' : screen,
    'volume' : volume,
    'video' : video,
    'email' : email,
    'no_slide' : numberSlide,
    'date' : date,
    'last_update' : lastupdate
  };
  factory Videos1.fromJson(Map<String, dynamic> json)=> Videos1(
      id: json["id"]??'',
      nameImg: json["name"]??"-",
      judul: json["judul"]??"-",
      screen: json["screen"]??"default",
      volume: json["volume"]??false,
      video: json["video"]??"-",
      email: json["email"]??"-",
      numberSlide: json["no_slide"]??"-",
      date: (json["date"] as Timestamp).toDate(),
      lastupdate: (json["last_update"] as Timestamp).toDate(),
  );
}
class Videos2 {
  String id;
  String nameImg;
  String video;
  String judul;
  String screen;
  bool volume;
  String email;
  String numberSlide;
  DateTime date;
  DateTime lastupdate;

  Videos2({required this.id,required this.screen,required this.nameImg,required this.volume,required this.judul,required this.date,required this.email,required this.numberSlide,required this.lastupdate,required this.video});

  Map<String, dynamic> toJson() =>{
    'id' : id,
    'name' : nameImg,
    'judul' : judul,
    'screen' : screen,
    'volume' : volume,
    'video' : video,
    'email' : email,
    'no_slide' : numberSlide,
    'date' : date,
    'last_update' : lastupdate
  };
  factory Videos2.fromJson(Map<String, dynamic> json)=> Videos2(
      id: json["id"]??'',
      nameImg: json["name"]??"-",
      judul: json["judul"]??"-",
      screen: json["screen"]??"default",
      volume: json["volume"]??false,
      video: json["video"]??"-",
      email: json["email"]??"-",
      numberSlide: json["no_slide"]??"-",
      date: (json["date"] as Timestamp).toDate(),
      lastupdate: (json["last_update"] as Timestamp).toDate(),
  );
}
class VideosAll {
  String id;
  String nameImg;
  String video;
  String judul;
  String screen;
  bool volume;
  String email;
  String numberSlide;
  DateTime date;
  DateTime lastupdate;

  VideosAll({required this.id,required this.screen,required this.nameImg,required this.volume,required this.judul,required this.date,required this.email,required this.numberSlide,required this.lastupdate,required this.video});

  Map<String, dynamic> toJson() =>{
    'id' : id,
    'name' : nameImg,
    'judul' : judul,
    'screen' : screen,
    'volume' : volume,
    'video' : video,
    'email' : email,
    'no_slide' : numberSlide,
    'date' : date,
    'last_update' : lastupdate
  };
  factory VideosAll.fromJson(Map<String, dynamic> json)=> VideosAll(
      id: json["id"]??'',
      nameImg: json["name"]??"-",
      judul: json["judul"]??"-",
      screen: json["screen"]??"default",
      volume: json["volume"]??false,
      video: json["video"]??"-",
      email: json["email"]??"-",
      numberSlide: json["no_slide"]??"-",
      date: (json["date"] as Timestamp).toDate(),
      lastupdate: (json["last_update"] as Timestamp).toDate(),
  );
}

class DataKantor {
  String id;
  String namaKantor;
  String namaKantor2;
  String email;
  String alamat;
  String nameImage;
  String image;
  String template;
  String textBerjalan;
  DateTime date;
  DateTime lastupdate;

  DataKantor({required this.id,required this.email,required this.template,required this.namaKantor2,required this.namaKantor,required this.nameImage,required this.alamat,required this.textBerjalan,required this.date,required this.lastupdate,required this.image});

  Map<String, dynamic> toJson() =>{
    'id' : id,
    'email' : email,
    'name_office' : namaKantor,
    'name_office2' : namaKantor2,
    'addreess' : alamat,
    'name_image' : nameImage,
    'image' : image,
    'template' : template,
    'run_text' : textBerjalan,
    'date' : date,
    'last_update' : lastupdate
  };
  factory DataKantor.fromJson(Map<String, dynamic> json)=> DataKantor(
    id: json["id"]??'',
    email: json["email"]??"-",
    namaKantor: json["name_office"]??"-",
    namaKantor2: json["name_office2"]??"-",
    alamat: json["addreess"]??"-",
    nameImage: json["name_image"]??"-",
    image: json["image"]??"-",
    template: json["template"]??"1",
    textBerjalan: json["run_text"]??"-",
    date: (json["date"] as Timestamp).toDate(),
    lastupdate: (json["last_update"] as Timestamp).toDate(),
  );
}

