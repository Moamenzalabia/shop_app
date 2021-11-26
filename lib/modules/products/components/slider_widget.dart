import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  String image;

  SliderWidget({
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        Image(
          image: NetworkImage(image),
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ],
      options: CarouselOptions(
        height: 200,
        viewportFraction: 1.0,
        enlargeCenterPage: false,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(seconds: 1),
        autoPlayCurve: Curves.fastOutSlowIn,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
