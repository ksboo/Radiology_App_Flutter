import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselExample extends StatelessWidget {
  final List<String> images = [
    // SHOULD BE RELATIVE PATHS -- > OR ELSE WONT WORK
    'assets/phy_1.jpeg',
    //'assets/phy_2.jpeg',
    'assets/phy_3.jpeg',
    'assets/phy_4.jpeg',
    // 'assets/phy_5.jpeg',
    'assets/phy_6.jpeg',
    'assets/phy_7.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 300.0, // Set the height of the carousel
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        viewportFraction: 0.8,
      ),
      items: images.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),

                // CHANGE THIS TO IMAGE.NETWORK --> IF YOU WANT TO USE IMGS FROM NET
                child: Image.asset(
                  item,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
