import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Call extends StatelessWidget {
  @override
  Widget build(BuildContext context) => new Scaffold(
        appBar: new AppBar(
          title: new Text("View"),
        ),
        body: new Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "make emergency call",
                style: TextStyle(fontSize: 25),
              ),
              IconButton(
                icon: Image.asset(
                  "assets/images/call.PNG",
                ),
                iconSize: MediaQuery.of(context).size.width / 5,
                onPressed: () {
                  launch("tel://997");
                },
              ),
            ],
          ),
        ),
      );
}
