import 'dart:async';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:user_smart_tv/helpers/helpers.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:timezone/standalone.dart' as tz;
import 'package:video_player/video_player.dart';
class HomeController extends GetxController{
  var email;
  RxString time = ''.obs;
  RxInt current = 0.obs;
  final getStorage = GetStorage();
  final googleSignIn = GoogleSignIn();
  final detroit = tz.getLocation('Asia/Jakarta');
  // Map<dynamic,dynamic> urls =  {};
  RxInt currentIndex = 0.obs;
  RxInt playVideo = 0.obs;
  String url="";
  String url2="";
  String screen="";
  String screen2="";
  bool volume= false;
  bool volume2= false;
  VideoPlayerController? controllerVideos;
  String template = '';
  final Map<dynamic,dynamic> urls = {};
  final Map<dynamic,dynamic> urls2 = {};
  final Map<dynamic,dynamic> volumes = {};
  final Map<dynamic,dynamic> screens = {};
  final Map<dynamic,dynamic> screens2 = {};
  final Map<dynamic,dynamic> volumes2 = {};
  Stream<List<DataKantor>> getDataKantor()=>
      FirebaseFirestore.instance.collection('office').where("email", isEqualTo: email).snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => DataKantor.fromJson(doc.data())).toList());

  Stream<List<ImagesSlide1>> getDataImagesSlide1()=>
      FirebaseFirestore.instance.collection('data-images').where("email", isEqualTo: email).where("no_slide", isEqualTo: 'slide 1').orderBy('judul',descending: false).snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => ImagesSlide1.fromJson(doc.data())).toList());

  Stream<List<ImagesSlide2>> getDataImagesSlide2()=>
     FirebaseFirestore.instance.collection('data-images').where("email", isEqualTo: email).where("no_slide", isEqualTo: 'slide 2').orderBy('judul',descending: false).snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => ImagesSlide2.fromJson(doc.data())).toList());

  Stream<List<Videos1>> getDataVideos1(){
    if(template == '1'){
      print("TEMPALTAE 1");
     final data = FirebaseFirestore.instance.collection('data-videos').where("email", isEqualTo: email).where("no_slide", isEqualTo: 'slide 1').orderBy('judul',descending: false).snapshots().map((snapshot) =>
         snapshot.docs.map((doc) => Videos1.fromJson(doc.data())).toList());
     return data;
    }else{
      final data = FirebaseFirestore.instance.collection('data-videos').where("email", isEqualTo: email).orderBy("no_slide", descending: false).orderBy('judul',descending: false).snapshots().map((snapshot) =>
          snapshot.docs.map((doc) => Videos1.fromJson(doc.data())).toList());
      return data;
    }
  }

  Stream<List<Videos2>> getDataVideos2()=> FirebaseFirestore.instance.collection('data-videos').where("email", isEqualTo: email).where("no_slide", isEqualTo: 'slide 2').orderBy('judul',descending: false).snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Videos2.fromJson(doc.data())).toList());

  Stream<List<Videos1>> getDataVideosAll()=> FirebaseFirestore.instance.collection('data-videos').where("email", isEqualTo: email).snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Videos1.fromJson(doc.data())).toList());



  void _getTime() async{
    final DateTime now = tz.TZDateTime.from(DateTime.now(), detroit);
    // final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    time.value = formattedDateTime;
  }


  String _formatDateTime(DateTime dateTime) {
    return DateFormat('hh:mm:ss').format(dateTime);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    email = getStorage.read(AppVariabel.email);
    time.value = _formatDateTime(DateTime.now());
    Timer.periodic(Duration(seconds: 1), (Timer t) => _getTime());
    super.onInit();

  }



}