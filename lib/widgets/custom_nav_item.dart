import 'package:flutter/material.dart';
import '../main.dart';

class CustomNavItem extends StatelessWidget {
  final IconData icon;
  final int id;
  final Function setPage;

  const CustomNavItem({this.setPage, this.icon, this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        currentIndex = id;
        setPage();
      },
      child: Container(
        width: MediaQuery.of(context).size.width *0.25,
        height: MediaQuery.of(context).size.height *0.1,

       color: Color(0x6a98b593),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: currentIndex == id
                  ? Colors.white.withOpacity(0.9)
                  : Colors.transparent,
              child: Icon(
                icon,
                size: 40,
                color: currentIndex == id
                    ? Colors.black
                    : Color(0xFF98b593),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
