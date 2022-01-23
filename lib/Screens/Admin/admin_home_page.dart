import 'package:covid_health/Screens/Chat/chat_names_list.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'add_location.dart';
import 'package:covid_health/Screens/Admin/patients_list.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({Key key}) : super(key: key);

  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AdminHome());
  }
}


class AdminHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.person_outline,
              color: Theme.of(context).primaryColor,
              size: 100,
            ),
            Text(
              "ADMINISTRATOR",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        Container(
          height: 20,
        ),
        Divider(
          color: Colors.black,
        ),
        Container(
          height: 40,
        ),
      Center(

        child: GestureDetector(
          onTap: () {
                        Navigator.push(
                context, MaterialPageRoute(builder: (context) =>
                AddLocation(type: "vaccine")));
          },
          child: Card(
            color: Colors.white,
            child: Container(
              decoration: new BoxDecoration(
                border: Border.all(
                    color: Color(0xff636363)
                ),
              ),
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.directions,
                    color: Theme.of(context).primaryColor,
                    size: 50,
                  ),
                  Text(
                    "vaccine location" ,
                    style: TextStyle(fontSize: 17),
                  ),
                  Container(width: 30,),
                  Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF98b593),
                    size: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
        Container(
          height: 10,
        ),
        Center(

        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) =>
                AddLocation(type: "test",)));
          },
          child: Card(
            color: Colors.white,
            child: Container(
              decoration: new BoxDecoration(
                border: Border.all(
                    color: Color(0xff636363)
                ),
              ),
              width: 300,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.directions,
                    color: Theme
                        .of(context)
                        .primaryColor,
                    size: 50,

                  ),
                  Text(
                    "test location" ,
                    style: TextStyle(fontSize: 17),
                  ),
                  Container(width: 30,),
                  Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF98b593),
                    size: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
        Container(
          height: 10,
        ),
        Center(

          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>
                  ChatList(type: "1",id: "1",)));
            },
            child: Card(
              color: Colors.white,
              child: Container(
                decoration: new BoxDecoration(
                  border: Border.all(
                      color: Color(0xff636363)
                  ),
                ),
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.chat,
                      color: Theme
                          .of(context)
                          .primaryColor,
                      size: 50,

                    ),
                    Text(
                      "Chat with doctor" ,
                      style: TextStyle(fontSize: 17),
                    ),
                    Container(width: 30,),
                    Icon(
                      Icons.arrow_forward,
                      color: Color(0xFF98b593),
                      size: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 10,
        ),
        Center(

          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>
                  ChatList(type: "2",id: "1",)));
            },
            child: Card(
              color: Colors.white,
              child: Container(
                decoration: new BoxDecoration(
                  border: Border.all(
                      color: Color(0xff636363)
                  ),
                ),
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.chat,
                      color: Theme
                          .of(context)
                          .primaryColor,
                      size: 50,

                    ),
                    Text(
                      " Chat with Patient " ,
                      style: TextStyle(fontSize: 17),
                    ),
                    Container(width: 30,),
                    Icon(
                      Icons.arrow_forward,
                      color: Color(0xFF98b593),
                      size: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Center(

          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) =>
              PatientsList()));
            },
            child: Card(
              color: Colors.white,
              child: Container(
                decoration: new BoxDecoration(
                  border: Border.all(
                      color: Color(0xff636363)
                  ),
                ),
                width: 300,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.person_pin_outlined,
                      color: Theme
                          .of(context)
                          .primaryColor,
                      size: 50,

                    ),
                    Text(
                      "Patient information" ,
                      style: TextStyle(fontSize: 17),
                    ),
                    Container(width: 30,),
                    Icon(
                      Icons.arrow_forward,
                      color: Color(0xFF98b593),
                      size: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],);
  }


}

