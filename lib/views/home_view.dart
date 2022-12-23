import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_smart_tv/controllers/home_controller.dart';
import 'package:user_smart_tv/controllers/video_controller.dart';
import 'package:user_smart_tv/helpers/helpers.dart';
import 'package:user_smart_tv/template/template2_view.dart';
import 'package:user_smart_tv/template/template1_view.dart';
import 'package:user_smart_tv/template/template3_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeC = Get.put(HomeController());
    return Scaffold(
       body:StreamBuilder<List<DataKantor>>(
        stream: homeC.getDataKantor(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            return
              Column(
                children: [
                  Expanded(child: Container()),
                  const Icon(Icons.error),
                  const Text("ERROR"),
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
                  const Icon(Icons.add),
                  const Text("Empty"),
                  Expanded(child: Container()),
                ],
              );

          }else{
            final data = snapshot.data!;
            return
              ItemDataHome(dataKantor: data);
          }
        },
      )

    );
  }
}

class ItemDataHome extends StatelessWidget {
  List<DataKantor> dataKantor;
  ItemDataHome({Key? key,required this.dataKantor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get.put(VideoControllers());
    Get.lazyPut(() => VideoControllers());
    final homeC = Get.find<HomeController>();
    return SafeArea(
      child: ListView(
       scrollDirection: Axis.horizontal,
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(dataKantor.length, (index) {
          homeC.template = dataKantor[index].template;
          return  dataKantor[index].template == '1'?
          Template1View(dataKantor: dataKantor[index])
              : dataKantor[index].template == '2'?
          Template2View(dataKantor: dataKantor[index])
              :
          Template3View(dataKantor: dataKantor[index]);
        })

      ),
    );
  }
}



