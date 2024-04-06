import 'package:flutter/material.dart';

import 'package:radiology/widgets/crousel.dart';
import 'package:radiology/widgets/knowmore_card.dart';
import 'package:radiology/widgets/stacked_card.dart';

// import 'package:hospital_managment/widgets/stacked_card.dart';

class Home_Screen extends StatefulWidget {
  @override
  State<Home_Screen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Radiology',
          style: TextStyle(fontSize: 24),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            print('Menu icon pressed');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined),
            onPressed: () {
              
              print('Account circle icon pressed');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              height: 250,
              child: CarouselExample(),
            ),
            SizedBox(height: 10),
            Container(
              height: 300,
              child: StackedCard(),
            ),
            Container(
              height: 140,
              child: knowMore_card(),
            ),
            SizedBox(height: 10),
            // Add any additional widgets here
          ],
        ),
      ),
    );
  }
}
