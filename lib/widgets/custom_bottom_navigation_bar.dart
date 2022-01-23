import 'package:flutter/material.dart';
import 'custom_nav_item.dart';
import '../main.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  setPage() {
    setState(() {
      pageController.jumpToPage(currentIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 1,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CustomNavItem(setPage: setPage, icon: Icons.medical_services, id: 0),
                  CustomNavItem(setPage: setPage, icon: Icons.notifications, id: 1),
                  CustomNavItem(setPage: setPage, icon: Icons.call, id: 2),
                  CustomNavItem(setPage: setPage, icon: Icons.home, id: 3),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
