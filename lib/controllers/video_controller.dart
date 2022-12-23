import 'package:chewie/chewie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:user_smart_tv/controllers/home_controller.dart';
import 'package:user_smart_tv/helpers/helpers.dart';
import 'package:video_player/video_player.dart';

class VideoControllers extends GetxController{
  final getStorage = GetStorage();
  final googleSignIn = GoogleSignIn();
  RxInt currentIndex = 0.obs;
  RxInt playVideo1= 0.obs;
  RxInt playVideo2 = 0.obs;
  int no1 = 0;
  int no2 = 0;
  final homeC = Get.find<HomeController>();
  VideoPlayerController? controllerVideos1;
  ChewieController? chewieController1;
  VideoPlayerController? controllerVideos2;
  ChewieController? chewieController2;
  void checkVideo1(){
    int limit = homeC.urls.length - 1;
    if(controllerVideos1 != null){
    if(controllerVideos1!.value.position == controllerVideos1!.value.duration){
      print('video END');
      controllerVideos1!.dispose();
      controllerVideos1 = null;
      chewieController1 = null;
      playVideo1.value++;
      if(no1 >= limit){
        no1 = 0;
        print("HABIS");
        print(no1);
      }else{
        no1++;
        print("NEXT");
        print(no1);
      }
      nextVideo1();
    }
    }
  }
  void checkVideo2(){
    int limit = homeC.urls2.length - 1;
    if(controllerVideos2 != null){
      if(controllerVideos2!.value.position == controllerVideos2!.value.duration){
        print('video END');
        controllerVideos2!.dispose();
        controllerVideos2 = null;
        chewieController2 = null;
        playVideo2.value++;
        if(no2 >= limit){
          no2 = 0;
          print("HABIS");
          print(no2);
        }else{
          no2++;
          print("NEXT");
          print(no2);
        }
        nextVideo2();
      }
    }
  }
  Future nextVideo1()async{
    var dataUrl = homeC.urls.entries.toList();
    var dataVolume = homeC.volumes.entries.toList();
    var datascreen = homeC.screens.entries.toList();
    homeC.url = dataUrl[no1].value;
    homeC.volume = dataVolume[no1].value;
    homeC.screen = datascreen[no1].value;
    print("VIDEO SELANJUTNYA");
    print(dataUrl);
    print(dataVolume);
    print(no1);
    print(homeC.volume);
    print(homeC.url);
    playVideo1.value++;
    initializePlayerVideo1(homeC.url);
  }
  Future nextVideo2()async{
    var dataUrl = homeC.urls2.entries.toList();
    var dataVolume = homeC.volumes2.entries.toList();
    var datascreen = homeC.screens2.entries.toList();
    homeC.url2 = dataUrl[no2].value;
    homeC.volume2 = dataVolume[no2].value;
    homeC.screen2 = datascreen[no2].value;
    print("VIDEO SELANJUTNYA");
    print(dataUrl);
    print(dataVolume);
    print(no2);
    print(homeC.volume2);
    print(homeC.url2);
    playVideo2.value++;
    initializePlayerVideo2(homeC.url2);
  }
  Future listenVideo1()async{
    controllerVideos1!.addListener(checkVideo1);
  }

  Future listenVideo2()async{
    controllerVideos2!.addListener(checkVideo2);
  }
  Future LogOut()async{
    AppAlert.loading();
    await googleSignIn.disconnect().whenComplete(() {
      if(controllerVideos1 != null){
        controllerVideos1!.dispose();
        chewieController1!.dispose();
      }
      if( controllerVideos2 != null){
        controllerVideos2!.dispose();
        chewieController2!.dispose();
      }
      FirebaseAuth.instance.signOut();
      getStorage.erase();
      Get.back();
      Get.offAllNamed("/login");
    });
  }
  Future Disposes()async{
    if(controllerVideos1 != null && chewieController1 != null){
      controllerVideos1!.dispose();
      chewieController1 = null;
      playVideo1.value++;
      print("BERHASIL");
    }else{
      print("GAGAL");
    }
  }
  Future Disposes2()async{
    if(controllerVideos2 != null && chewieController2 != null){
      controllerVideos2!.dispose();
      chewieController2 = null;
      playVideo2.value++;
      print("BERHASIL");
    }else{
      print("GAGAL");
    }
  }
  Future initializePlayerVideo1(String url) async {
    final fileInfo = await checkCacheFor(url);
    if (fileInfo == null){
      cachedForUrl(url).whenComplete(()async {
        controllerVideos1 = VideoPlayerController.network(url,videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
        controllerVideos1!.initialize().then((value)async {
            chewieController1 = await ChewieController(videoPlayerController: controllerVideos1!,autoPlay: true,allowFullScreen: false);
          if(homeC.volume == false){
            chewieController1!.setVolume(0.0);
          }
          playVideo1.value++;
          listenVideo1();
        });
      });
      print("INTERNET SLIDE 1");
    }else {
      final file = fileInfo.file;
      controllerVideos1 = VideoPlayerController.file(file,videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
      controllerVideos1!.initialize().then((value)async {
            chewieController1 = await ChewieController(videoPlayerController: controllerVideos1!,autoPlay: true,allowFullScreen: false,);
         if(homeC.volume == false){
          chewieController1!.setVolume(0.0);
        }
        playVideo1.value++;
        print("LOCAL SLIDE 1");
        listenVideo1();
      });
    }

  }
  Future initializePlayerVideo2(String url) async {
    final fileInfo = await checkCacheFor2(url);
    if (fileInfo == null){
      cachedForUrl2(url).whenComplete(()async {
        controllerVideos2 = VideoPlayerController.network(url,videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
        controllerVideos2!.initialize().then((value)async {
            chewieController2 = await ChewieController(videoPlayerController: controllerVideos2!,autoPlay: true,allowFullScreen: false);
          if(homeC.volume2 == false){
            chewieController2!.setVolume(0.0);
          }
          playVideo2.value++;
          listenVideo2();
        });

      });
        print("INTERNET SLIDE 2");
    }else {
      final file = fileInfo.file;
      controllerVideos2 = VideoPlayerController.file(file,videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
      controllerVideos2!.initialize().then((value)async {
          chewieController2 = await ChewieController(videoPlayerController: controllerVideos2!,autoPlay: true,allowFullScreen: false);
        if(homeC.volume2 == false){
          chewieController2!.setVolume(0.0);
        }
        playVideo2.value++;
        print("LOCAL SLIDE 2");
        listenVideo2();
      });
    }

  }

  Future<FileInfo?> checkCacheFor(String url) async {
    final FileInfo? value = await DefaultCacheManager().getFileFromCache(url);
    return value;
  }
  Future<FileInfo?> checkCacheFor2(String url) async {
    final FileInfo? value = await DefaultCacheManager().getFileFromCache(url);
    return value;
  }

  Future cachedForUrl(String url) async {
    await DefaultCacheManager().getSingleFile(url).then((value) {
      print('downloaded successfully done for $url');
    });
  }
  Future cachedForUrl2(String url) async {
    await DefaultCacheManager().getSingleFile(url).then((value) {
      print('downloaded successfully done for $url');
    });
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  @override
  void dispose() {
    if (controllerVideos1 != null) {
      controllerVideos1!.dispose();
      chewieController1!.dispose();
    }
    if (controllerVideos2 != null) {
      controllerVideos2!.dispose();
      chewieController2!.dispose();

    }
    super.dispose();
  }
}