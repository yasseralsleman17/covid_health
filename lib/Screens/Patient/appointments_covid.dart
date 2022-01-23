import 'dart:convert';

import 'package:covid_health/Screens/Chat/chat_names_list.dart';
import 'package:covid_health/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:covid_health/Screens/Patient/covid_map.dart';
import 'package:covid_health/Screens/Patient/view_appointments.dart';
import '../../main.dart';
import 'package:http/http.dart' as http;

class AppointmentsCovid extends StatefulWidget {
  final String id;

  const AppointmentsCovid({Key key, this.id}) : super(key: key);

  @override
  _AppointmentsCovidState createState() => _AppointmentsCovidState();
}

class _AppointmentsCovidState extends State<AppointmentsCovid> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _lane1;
  TextEditingController _lane2;
  TextEditingController _lane3;
  TextEditingController _lane4;
  bool Appointments = false;

  @override
  void initState() {
    _lane1 = new TextEditingController();
    _lane2 = new TextEditingController();
    _lane3 = new TextEditingController();
    _lane4 = new TextEditingController();
    getAppointments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 5),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Image.asset(
                      "assets/images/ic_logout.jpg",
                    ),
                    iconSize: MediaQuery.of(context).size.width / 8,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return WelcomePage();
                          },
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Image.asset(
                      "assets/images/saed.PNG",
                    ),
                    iconSize: MediaQuery.of(context).size.width / 5,
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                  IconButton(
                      icon: Image.asset(
                        "assets/images/ic_chat.png",
                      ),
                      iconSize: MediaQuery.of(context).size.width / 8,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ChatList(id: widget.id, type: "1");
                            },
                          ),
                        );
                      }),
                ],
              ),
            ),
            Container(
              height: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              color: Color(0x16848484),
              child: Row(
                children: [
                  IconButton(
                    icon: Image.asset(
                      "assets/images/ic_corona.png",
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
                  Text("COVID test",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      )),
                  Container(
                    width: 40,
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.arrow_forward,
                      color: Color(0xFF98b593),
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CovidMap(type: "test", id: widget.id)));
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
                children: [
                  IconButton(
                    icon: Image.asset(
                      "assets/images/syringe_blood.png",
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
                  Text("COVID vaccine",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      )),
                  Container(
                    width: 10,
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.arrow_forward,
                      color: Color(0xFF98b593),
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  CovidMap(type: "vaccine", id: widget.id)));
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
            ),
            Form(
              key: _formKey,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Color(0x16848484),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          IconButton(
                            icon: Image.asset(
                              "assets/images/ic_1.PNG",
                            ),
                            iconSize: MediaQuery.of(context).size.width / 6,
                          ),
                          Text("blood pressure",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                              )),
                          Container(
                            width: 50,
                            height: 30,
                            child: TextFormField(
                              controller: _lane1,
                              validator: (val) => val.isEmpty ? '****' : null,
                              onChanged: (value) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                labelText: "add",
                              ),
                            ),
                          ),
                          Text("mmHg",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                              )),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        width: 3,
                        height: 100,
                        color: Colors.grey,
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Image.asset(
                              "assets/images/ic_2.PNG",
                            ),
                            iconSize: MediaQuery.of(context).size.width / 6,
                          ),
                          Text("Glucose level",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                              )),
                          Container(
                            width: 50,
                            height: 30,
                            child: TextFormField(
                              controller: _lane2,
                              validator: (val) => val.isEmpty ? '****' : null,
                              onChanged: (value) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                labelText: "add",
                              ),
                            ),
                          ),
                          Text("mg/dl",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                              )),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        width: 3,
                        height: 100,
                        color: Colors.grey,
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Image.asset(
                              "assets/images/ic_3.PNG",
                            ),
                            iconSize: MediaQuery.of(context).size.width / 6,
                          ),
                          Text("Waistline",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                              )),
                          Container(
                            width: 50,
                            height: 30,
                            child: TextFormField(
                              controller: _lane3,
                              validator: (val) => val.isEmpty ? '*****' : null,
                              onChanged: (value) {
                                setState(() {});
                              },
                              decoration: InputDecoration(
                                labelText: "add",
                              ),
                            ),
                          ),
                          Text("cm",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                              )),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        width: 3,
                        height: 100,
                        color: Colors.grey,
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Image.asset(
                              "assets/images/ic_4.PNG",
                            ),
                            iconSize: MediaQuery.of(context).size.width / 6,
                            onPressed: () {},
                          ),
                          Text("BMI",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                              )),
                          Container(
                            width: 50,
                            height: 30,
                            child: TextFormField(
                              controller: _lane4,
                              validator: (val) => val.isEmpty ? '****' : null,
                              decoration: InputDecoration(
                                labelText: "add",
                              ),
                            ),
                          ),
                          Text("kg/m2",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                              )),
                        ],
                      ),
                    ]),
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
                  if (_formKey.currentState.validate()) {
                    updateData();
                  }
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
                    color: Color(0xFF98b593),
                  ),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "Update",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Container(
              height: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              color: Color(0x16848484),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("MY Appointments",
                          style: TextStyle(
                            color: Color(0x99422B16),
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          )),
                      Container(
                        height: 10,
                      ),
                      Appointments
                          ? Text(
                              "You have  appointments click to view details",
                              style: TextStyle(
                                color: Color(0xDA6F6E6D),
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                              ),
                            )
                          : Text("Sorry you don't have any appointments",
                              style: TextStyle(
                                color: Color(0xDA6F6E6D),
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                              )),
                    ],
                  ),
                  GestureDetector(
                    child: Icon(
                      Icons.arrow_forward,
                      color: Color(0xFF98b593),
                      size: 30,
                    ),
                    onTap: () {
                      if (Appointments) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ViewAppointments(id: widget.id,appoiintment:tags)));
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<dynamic> tags;

  Future<void> getAppointments() async {
    var request = http.MultipartRequest('POST',
        Uri.parse('https://covide.freehostksa.net/api/get_appointments.php'));
    request.fields.addAll({'id': widget.id});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var tagsJson = json.decode(await response.stream.bytesToString());

       tags = tagsJson != null ? List.from(tagsJson) : null;

      for (int i = 0; i < tags.length; i++)
        if (tags[i]["code"] == 1) {
          setState(() {
            Appointments = true;
          });
        }
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> updateData() async {
    var headers = {'Content-Type': 'application/x-www-form-urlencoded'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://covide.freehostksa.net/api/add_update_health_info.php'));
    request.bodyFields = {
      'id': widget.id,
      'heart_beats': _lane1.text.toString(),
      'blood_pressure': _lane4.text.toString(),
      'temperature': _lane3.text.toString(),
      'measure_oxygen': _lane2.text.toString()
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
