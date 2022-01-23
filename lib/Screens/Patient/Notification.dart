import 'package:covid_health/Screens/Chat/chat.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:covid_health/welcome_page.dart';
import 'package:covid_health/profile.dart';
import 'package:covid_health/Screens/Patient/location.dart';
class Notifications extends StatefulWidget {

  final String id;


  const Notifications({
    Key key,
    this.id,
  }) : super(key: key);


  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
   String name=" ";


   List<dynamic> tags;


   @override
   void initState() {
     get();
     // TODO: implement initState
     super.initState();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: SingleChildScrollView(
          child:Column(children: [
            Image.asset(
              "assets/images/ic_prof.PNG",
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
            ),
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
            ),
            Divider(
              color: Colors.black,
            ),
            Container(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              color: Color(0x16848484),
              child: Row(
                children: [
                  IconButton(
                    icon:Icon(
                      Icons.person_outline,
                      color: Color(0xFF98b593),

                    ),
                    iconSize: MediaQuery.of(context).size.width / 7,
                    onPressed: () {},
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    width: 3,
                    height: 50,
                    color: Colors.grey,
                  ),
                  Container(
                    width: 40,
                  ),
                  Text("Personal Information",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      )),
                  Container(
                    width: 10,
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.arrow_forward,
                      color: Color(0xFF98b593),
                      size: 25,
                    ),
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => Profile(id:widget.id)));

                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              color: Color(0x16848484),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon:Icon(
                      Icons.person,
                      color: Color(0xFF98b593),

                    ),
                    iconSize: MediaQuery.of(context).size.width / 7,
                    onPressed: () {},
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    width: 3,
                    height: 50,
                    color: Colors.grey,
                  ),
                  Container(
                    width: 40,
                  ),
                  Text("Location",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w900,
                      )),
                  Container(
                    width: 10,
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.arrow_forward,
                      color: Color(0xFF98b593),
                      size: 25,
                    ),
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => PLocation(id:widget.id)));

                    },
                  ),
                ],
              ),
            ),

            Container(
              height: 15,
            ),

            Container(
              height: 5,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Chat(otherid: "1",myid: widget.id,)));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Color(0xFF98b593),
                  ),
                  padding: const EdgeInsets.all(0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround
                    ,                    children: <Widget>[

                    Text(
                      "Connect with us",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Color(0xffffffff),
                      size: 40,
                    )
                  ],
                  ),

                ),
              ),
            ),

            Container(
              height: 5,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => WelcomePage()));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Color(0xffc41b1b),

                  ),
                  padding: const EdgeInsets.all(0),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround
                    ,
                    children: <Widget>[

                      Text(
                        "log out",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Color(0xffffffff),
                        size: 40,
                      )
                    ],
                  ),




                ),
              ),
            ),
            Container(
              height: 5,
            ),

          ],) ,
        ),
      ),
    );
  }



   Future<void> get() async {
     var request = http.MultipartRequest('POST',
         Uri.parse('https://covide.freehostksa.net/api/get_users_info.php'));
     request.fields.addAll({
       'p_id': widget.id,
     });

     http.StreamedResponse response = await request.send();


     if (response.statusCode == 200) {
       var tagsJson = json.decode(await response.stream.bytesToString());


       tags = tagsJson != null ? List.from(tagsJson) : null;

       for (int i = 0; i < tags.length; i++) {

         if( tags[i]["data"]["id"]==widget.id){
           name = tags[i]["data"]["name"];

         }
         setState(() {

         });
       }
     }
   }

}


