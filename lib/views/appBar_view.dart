import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:user_smart_tv/controllers/home_controller.dart';
import 'package:user_smart_tv/controllers/video_controller.dart';
import 'package:user_smart_tv/helpers/helpers.dart';
import 'package:user_smart_tv/helpers/widgets.dart';

class AppBarView extends StatelessWidget {
  DataKantor dataKantor;
  AppBarView({Key? key,required this.dataKantor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final homeC = Get.find<HomeController>();
    final videoC = Get.find<VideoControllers>();
    var top = size.height/15;
    var width = size.width - 40;
    return  Container(
      decoration:const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white,
          boxShadow:[
            BoxShadow(
                color: Colors.black54,
                blurRadius: 2,
                spreadRadius: 1.1,
                offset: Offset(1,2)
            )
          ]
      ),
      height: top,
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Shortcuts(
            shortcuts: <LogicalKeySet, Intent>{
              LogicalKeySet(LogicalKeyboardKey.select):const ActivateIntent()
            },
            child: SizedBox(
              width: 50,
              child: TextButton(
                onPressed: (){
                  // AppAlert.getAlert("Log Out", "Are You Sure", ()=>videoC.LogOut());
                  videoC.LogOut();
                 },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
                ),
                child: CachedNetworkImage(
                  imageUrl: dataKantor.image,
                  errorWidget: (context, url, error) =>
                      Image.asset("assets/logo.jpg"),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                  const Center(
                        child: ImagesLoading(),
                      ),
                  // fit: BoxFit.fill,
                  // width: size.width,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dataKantor.namaKantor.toUpperCase(),
                    style:const TextStyle(fontWeight: FontWeight.bold, fontSize:11,color: Colors.black,fontFamily: 'Roboto1'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(dataKantor.namaKantor2.toUpperCase(),
                    style:const TextStyle(fontWeight: FontWeight.bold, fontSize:11,color: Colors.black,fontFamily: 'Roboto1'),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ),
          Obx(()=>
              Padding(
                padding: const EdgeInsets.only(right: 2),
                child: Text(" ${homeC.time}",style: const TextStyle(fontWeight: FontWeight.bold, fontSize:10,color: Colors.black,fontFamily: 'Roboto1'),),
              )
          )

        ],
      ),
    );
  }
}
