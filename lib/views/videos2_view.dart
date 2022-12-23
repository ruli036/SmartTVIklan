import 'package:chewie/chewie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:user_smart_tv/controllers/home_controller.dart';
import 'package:user_smart_tv/controllers/video_controller.dart';
import 'package:user_smart_tv/helpers/helpers.dart';
import 'package:video_player/video_player.dart';

class SlideVideo2View extends StatelessWidget {
  const SlideVideo2View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeC = Get.find<HomeController>();
    final videoC = Get.find<VideoControllers>();
    return StreamBuilder<List<Videos2>>(
      stream: homeC.getDataVideos2(),
      builder: (context, snapshot){
        if(snapshot.hasError){
          print(snapshot.error);
          return
            Column(
              children: [
                Expanded(child: Container()),
                const Icon(Icons.error,color: Colors.grey),
                const Text("ERROR",style: TextStyle(color: Colors.grey)),
                Expanded(child: Container()),
              ],
            );
        }else if(snapshot.connectionState == ConnectionState.waiting){
          return
            const Center(
              child: CircularProgressIndicator(),
            );
        }else if(snapshot.data!.isEmpty){
          return
            Column(
              children: [
                Expanded(child: Container()),
                const FaIcon(FontAwesomeIcons.video,color: Colors.grey,),
                const Text("Video Empty",style: TextStyle(color: Colors.grey),),
                Expanded(child: Container()),
              ],
            );
        }else{
          final video = snapshot.data!;
          return
            PageView.builder(
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: video.length,
                itemBuilder: (context,index){
                  print("--------------------UPDATE-------------------");
                  homeC.urls2.clear();
                  homeC.volumes2.clear();
                  homeC.screens2.clear();
                  videoC.Disposes2().whenComplete(() {
                    if (homeC.urls2.isEmpty) {
                      video.forEach((element) {
                        homeC.urls2.addAll({element.id: element.video});
                        homeC.volumes2.addAll({element.video: element.volume});
                        homeC.screens2.addAll({element.video: element.screen});
                      });
                      homeC.url2 = homeC.urls2[video[index].id];
                      homeC.volume2 = homeC.volumes2[video[index].video];
                      homeC.screen2 = homeC.screens2[video[index].video];
                    }
                    if (homeC.template == '1') {
                      if (homeC.url == "" && homeC.url2 != "") {
                        videoC.initializePlayerVideo2(homeC.url2);
                      } else if (homeC.url2 == "" && homeC.url != "") {
                        videoC.initializePlayerVideo1(homeC.url);
                      } else if (homeC.url2 != "" && homeC.url != "") {
                        videoC.initializePlayerVideo1(homeC.url)
                            .whenComplete(() {
                          videoC.initializePlayerVideo2(homeC.url2);
                        });
                      }
                    } else {
                      if (videoC.controllerVideos2 != null && videoC.chewieController2 != null) {
                        videoC.controllerVideos2!.pause();
                        videoC.chewieController2!.pause();
                      }
                      videoC.initializePlayerVideo1(homeC.url);
                    }
                  });
                  return VideosPlayView2(url: video[index].video);
                }
            );
        }
      },
    );
  }
}


class VideosPlayView2 extends StatelessWidget {
  final String url;
  const VideosPlayView2({Key? key ,required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final videoC = Get.find<VideoControllers>();
    return Obx(()=>
        Container(
          color: Colors.black,
          child: videoC.chewieController2 != null
              ? Stack(
            children: [
              Text("${videoC.playVideo2.value}",style:const TextStyle(color: Colors.transparent)),
              videoC.homeC.screen2 == 'full'
                  ? Transform.scale(
                    scaleX: 1,
                    scaleY: 1,
                    child: Chewie(controller:videoC.chewieController2! ))
                  : Chewie(controller:videoC.chewieController2! )
            ],
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                child: ClipOval(
                  child:  Image.asset("assets/logo.jpg"),
                ),
              ),
              const Text('Loading... ',style: TextStyle(color: Colors.grey)),
              Text("${videoC.playVideo2.value}",style: const TextStyle(color: Colors.transparent))
            ],
          ),
        )
    );
  }
}
