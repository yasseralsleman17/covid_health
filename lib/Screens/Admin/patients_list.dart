import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:covid_health/Screens/Admin/update_patient_information.dart';
import 'package:http/http.dart' as http;

class PatientsList extends StatefulWidget {
  const PatientsList({Key key}) : super(key: key);

  @override
  _PatientsListState createState() => _PatientsListState();
}

class _PatientsListState extends State<PatientsList> {
  List<dynamic> tags;


  @override
  void initState() {

    getpation();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        new Expanded(
          child: tags != null
              ? new Container(
            color: Colors.blue.withOpacity(0.3),
            child: new CustomScrollView(
              scrollDirection: Axis.vertical,
              slivers: <Widget>[
                new SliverPadding(
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  sliver: new SliverFixedExtentList(
                    itemExtent: 150.0,
                    delegate: new SliverChildBuilderDelegate(
                          (context, index) => new PationRow(
                        tags[index]["data"]["patient_name"],
                        tags[index]["data"]["patient_id"],
                      ),
                      childCount: tags.length,
                    ),
                  ),
                ),
              ],
            ),
          )
              : new Container(),
        ),
      ],
    );
  }

  Future<void> getpation() async {
    var request = http.MultipartRequest('POST',
        Uri.parse('http://covide.freehostksa.net/api/get_doctor_chat.php'));

    request.fields.addAll({'user_id': "1"});

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var tagsJson = json.decode(await response.stream.bytesToString());

      setState(() {
        tags = tagsJson != null ? List.from(tagsJson) : null;
      });
    } else {
      print(response.reasonPhrase);
    }
  }
}

class PationRow extends StatelessWidget {
  final String name;


  final String id;

  PationRow(this.name,this.id);

  @override
  Widget build(BuildContext context) {
    final pationCardContent = new Container(
        child:Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              name,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => UpdatePatientInformation(id: id)));
                  },
                  child:Container(

                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: Color(0xFF98b593),
                    ),
                    child: Text(
                      "update Patient information",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15,color: Colors.black),
                    ),
                  ),
                ),

              ],
            ),
          ]
          ,)
    );

    final pationCard = new Container(
      child: pationCardContent,
      height: 120.0,
      decoration: new BoxDecoration(
        color: new Color(0xFFFFFFFF),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(10.0),
      ),
    );

    return Material(
      type: MaterialType.transparency,
      child: new Container(
        margin: EdgeInsets.all(15.0),
        child: new Column(
          children: <Widget>[
            pationCard,
          ],
        ),
      ),
    );
  }
}

