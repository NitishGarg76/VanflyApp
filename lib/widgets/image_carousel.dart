import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  final imageList;
  ImageCarousel({this.imageList});
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Stack(
        children: [
          PageView(
              onPageChanged: (num) {
                setState(() {
                  selectedindex = num;
                });
              },
              children: [
                for (var i = 0; i < widget.imageList.length; i++)
                  Container(
                    child: Image.network("${widget.imageList[i]}",
                      fit: BoxFit.cover,
                      height: 120,
                      width: 120,),
                  ),
              ]),
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < widget.imageList.length; i++)
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 12),
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        color: selectedindex == i
                            ? Colors.pinkAccent
                            : Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12)),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
