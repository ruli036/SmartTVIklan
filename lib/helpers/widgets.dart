import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImagesLoading extends StatelessWidget {
  const ImagesLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey.shade300,
      child: CircleAvatar(
        child: ClipOval(
          child: Container(
            height: 60,
            width: 20,
            // margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            decoration: const BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(50))
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: AspectRatio(
                aspectRatio: 16/9,
                child: Container(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class ImagesLoading2 extends StatelessWidget {
  const ImagesLoading2({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey.shade300,
      child: Container(
        width: size.width,
        // margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        decoration: const BoxDecoration(
          color: Colors.grey,
          // borderRadius: BorderRadius.all(Radius.circular(50))
        ),
        child: AspectRatio(
          aspectRatio: 16/9,
          child: Container(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}