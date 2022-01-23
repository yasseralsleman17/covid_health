import 'package:covid_health/Screens/Chat/chat.dart';
import 'package:covid_health/Screens/Chat/chat_names_list.dart';
import 'package:covid_health/welcome_page.dart';
import 'package:covid_health/profile.dart';
import 'package:covid_health/Screens/Doctor/patients_list.dart';
import 'package:flutter/material.dart';

class DoctorHomePage extends StatefulWidget {

  final String id;
 final String name;

  const DoctorHomePage({
    Key key,
     this.id,
    this.name,
  }) : super(key: key);

  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {
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
              widget.name,
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
                  Text("Patients with PWD",
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
                          context, MaterialPageRoute(builder: (context) => PatientsList(id:widget.id)));




                    },
                  ),
                ],
              ),
            ),

            Container(
              height: 15,
            ),
           /* Container(
              width: MediaQuery.of(context).size.width * 0.8,
              color: Color(0x16848484),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  IconButton(
                    icon:  Icon(
              Icons.local_hospital,
                color: Color(0xFF98b593),
                size: 25,
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
                  Text("Hospital",
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
                    onTap: () {    },
                  ),
                ],
              ),
            ),*/
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
}


