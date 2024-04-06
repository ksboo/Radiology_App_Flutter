import 'package:flutter/material.dart';
import 'package:radiology/screens/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hospital Managment',
        theme: ThemeData(
          colorSchemeSeed: Color.fromRGBO(159, 226, 191, 1.0),
          useMaterial3: true,
          textTheme: TextTheme(
            bodyText1:
                TextStyle(color: Colors.black), // Set your text color here
            bodyText2:
                TextStyle(color: Colors.black), // You can customize more styles
            // Add other text styles as needed
          ),
        ),
        //home: Home_screen(),
        home: Home_Screen(),
    );
  }
}
