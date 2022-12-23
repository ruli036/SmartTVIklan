import 'package:flutter/material.dart';
import 'package:user_smart_tv/helpers/helpers.dart';
import 'package:user_smart_tv/views/appBar_view.dart';
import 'package:user_smart_tv/views/videos1_view.dart';

class Template3View extends StatelessWidget {
  DataKantor dataKantor;
  Template3View({Key? key,required this.dataKantor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var width = size.width - 40;
    return Container(
      child: Stack(
        children: [
          RotatedBox(
              quarterTurns: -3,
              child: Image.asset("assets/bg3.jpeg")
          ),
          Container(
            width: size.width,
            child: RotatedBox(
              quarterTurns: -3,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    AppBarView(dataKantor: dataKantor),
                    const Padding(padding: EdgeInsets.all(8)),
                    Expanded(
                        flex: 4,
                        child: Container(
                            decoration:const BoxDecoration(
                                color: Colors.black,
                                boxShadow:[
                                  BoxShadow(
                                      color: Colors.black38,
                                      blurRadius: 2,
                                      spreadRadius: 1.1,
                                      offset: Offset(1,2)
                                  )
                                ]
                            ),
                            width: width,
                            child: const SlideVideo1View()
                        )
                    ),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
