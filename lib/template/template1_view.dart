import 'package:flutter/material.dart';
import 'package:user_smart_tv/helpers/helpers.dart';
import 'package:user_smart_tv/views/appBar_view.dart';
import 'package:user_smart_tv/views/slide1_img_view.dart';
import 'package:user_smart_tv/views/slide2_img_view.dart';
import 'package:user_smart_tv/views/videos2_view.dart';
import 'package:user_smart_tv/views/videos1_view.dart';

class Template1View extends StatelessWidget {
  DataKantor dataKantor;
  Template1View({Key? key,required this.dataKantor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var width = size.width - 40;
    print( size.height);
    print( size.width);
    return Container(
      child:Stack(
        children: [
          RotatedBox(
                quarterTurns: -3,
              child: Image.asset("assets/bg2.jpeg")
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
                                color: Colors.white,
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
                    const Padding(padding: EdgeInsets.all(8)),
                    Expanded(
                      flex: 6,
                      child: Container(
                        width: width,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                                child: Container(
                                    decoration:const BoxDecoration(
                                        color: Colors.white,
                                        boxShadow:[
                                          BoxShadow(
                                              color: Colors.black38,
                                              blurRadius: 2,
                                              spreadRadius: 1.1,
                                              offset: Offset(1,2)
                                          )
                                        ]
                                    ),
                                    child: SlideVideo2View()
                                ),
                            ),
                            const Padding(padding: EdgeInsets.all(8)),
                            Expanded(
                                flex: 2,
                                child: Container(
                                    child: Column(
                                      children: [
                                        Expanded(
                                            child: Container(
                                                decoration:const BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow:[
                                                      BoxShadow(
                                                          color: Colors.black38,
                                                          blurRadius: 2,
                                                          spreadRadius: 1.1,
                                                          offset: Offset(1,2)
                                                      )
                                                    ]
                                                ),
                                                child: const Slide1ImageView()
                                            )
                                        ),
                                        const Padding(padding: EdgeInsets.all(8)),
                                        Expanded(
                                            child: Container(
                                                decoration:const BoxDecoration(
                                                    color: Colors.white,
                                                    boxShadow:[
                                                      BoxShadow(
                                                          color: Colors.black38,
                                                          blurRadius: 2,
                                                          spreadRadius: 1.1,
                                                          offset: Offset(1,2)
                                                      )
                                                    ]
                                                ),
                                                child: const Slide2ImageView()
                                            )
                                        ),

                                        ],
                                    )
                                )
                            ),
                            // Slide2ImageView()
                          ],
                        ),
                      ),
                    ),
                   ],
                ),
              ),
            ),
          )
        ],
      ) ,
    );

  }
}
