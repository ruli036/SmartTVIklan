import 'package:chewie/chewie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:user_smart_tv/controllers/home_controller.dart';
import 'package:user_smart_tv/controllers/video_controller.dart';
import 'package:user_smart_tv/helpers/helpers.dart';
import 'package:video_player/video_player.dart';

class SlideVideo1View extends StatelessWidget {
  const SlideVideo1View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeC = Get.find<HomeController>();
    final videoC = Get.find<VideoControllers>();
    return StreamBuilder<List<Videos1>>(
      stream: homeC.getDataVideos1(),
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

                      homeC.urls.clear();
                      homeC.volumes.clear();
                      homeC.screens.clear();
                      videoC.Disposes().whenComplete(() {
                      if(homeC.urls.isEmpty){
                        video.forEach((element) {
                          homeC.urls.addAll({element.id : element.video});
                          homeC.volumes.addAll({element.video : element.volume});
                          homeC.screens.addAll({element.video : element.screen});
                        });
                        homeC.url =  homeC.urls[video[index].id];
                        homeC.volume =  homeC.volumes[video[index].video];
                        homeC.screen =  homeC.screens[video[index].video];
                      }
                    if(homeC.template == '1'){
                      if(homeC.url == "" && homeC.url2 != ""){
                        videoC.initializePlayerVideo2(homeC.url2);
                      }else if(homeC.url2 == "" && homeC.url != ""){
                        videoC.initializePlayerVideo1(homeC.url);
                      }else if(homeC.url2 != "" && homeC.url != ""){
                        videoC.initializePlayerVideo1(homeC.url).whenComplete(() {
                          videoC.initializePlayerVideo2(homeC.url2);
                        });
                      }
                    }else{
                      if(videoC.controllerVideos2 != null && videoC.chewieController2 != null){
                        videoC.controllerVideos2!.pause();
                        videoC.chewieController2!.pause();
                      }
                      videoC.initializePlayerVideo1(homeC.url);
                    }
                      });

                      return VideosPlayView1(url: video[index].video);
                    }
            );
        }
      },
    );
  }
}


class VideosPlayView1 extends StatelessWidget {
  final String url;
  const VideosPlayView1({Key? key ,required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final videoC = Get.find<VideoControllers>();
     return Obx(()=>
          Container(
            color: Colors.black,
            child: videoC.chewieController1 != null
                ? Stack(
              children: [
                Text("${videoC.playVideo1.value}",style:const TextStyle(color: Colors.transparent)),
                videoC.homeC.template == '3' && videoC.homeC.screen == 'full'
                ? Transform.scale(
                  scale: 1.6,
                  child: Chewie(controller:videoC.chewieController1!,),
                )
                    : videoC.homeC.screen == 'full'
                    ? Transform.scale(
                        scaleX: 1,
                        scaleY: 1.25,
                        child: Chewie(controller:videoC.chewieController1!,),
                      )
                    : Chewie(controller:videoC.chewieController1!,)

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
                    Text("${videoC.playVideo1.value}",style: const TextStyle(color: Colors.transparent))
              ],
            ),
          )
        
      );
  }
}
