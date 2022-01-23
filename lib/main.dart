import 'package:covid_health/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Screens/login/login.dart';


PageController pageController = PageController(initialPage: 0);
int currentIndex = 0;


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SAED ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF98b593),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelcomePage(),
    );
  }
}
