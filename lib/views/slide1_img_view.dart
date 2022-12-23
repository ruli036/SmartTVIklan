import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_smart_tv/controllers/home_controller.dart';
import 'package:user_smart_tv/helpers/helpers.dart';
import 'package:user_smart_tv/helpers/widgets.dart';

class Slide1ImageView extends StatelessWidget {
  const Slide1ImageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeC = Get.find<HomeController>();
    return StreamBuilder<List<ImagesSlide1>>(
      stream: homeC.getDataImagesSlide1(),
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
                const Icon(Icons.image,color: Colors.grey,),
                const Text("Images Empty",style: TextStyle(color: Colors.grey),),
                Expanded(child: Container()),
              ],
            );

        }else{
          final images = snapshot.data!;
          return
            ItemImageSlide1(dataImage: images);
        }
      },
    );
  }
}

class ItemImageSlide1 extends StatelessWidget {
  List<ImagesSlide1> dataImage;
  ItemImageSlide1({Key? key, required this.dataImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    List<Widget> imageSlider;
    imageSlider = dataImage.map((e) => Container(
      width: size.width,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow:[
            BoxShadow(
                color: Colors.grey.shade400,
                blurRadius: 2,
                spreadRadius: 1.1,
                offset: const Offset(0,8)
            )
          ]
      ),
      // color: Colors.white,
      // height: size.height,
      // margin: EdgeInsets.all(10),
      child: CachedNetworkImage(
        imageUrl: e.image,
        errorWidget: (context, url, error) =>
           CircleAvatar(
             child: ClipOval(
               child:  Image.asset("assets/logo.jpg"),
             ),
           ),
        progressIndicatorBuilder: (context, url, downloadProgress) =>
        const ImagesLoading2(),
        fit: e.screen == 'full'
            ? BoxFit.fill
            : BoxFit.contain,
        width: size.width,
      ),
    )).toList();
    return CarouselSlider(
      options: CarouselOptions(
        autoPlayInterval: const Duration(seconds: 8),
        autoPlay: true,
        aspectRatio: 1/1,
        height: size.height,
        viewportFraction: 1,
        enlargeCenterPage: true,
        autoPlayCurve: Curves.easeInCubic,
      ),
      items: imageSlider,
    );
  }
}

