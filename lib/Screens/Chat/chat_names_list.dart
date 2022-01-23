import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'chat.dart';

class ChatList extends StatefulWidget {
  final String id;
  final String type;

  const ChatList({Key key, this.id, this.type}) : super(key: key);

  @override
  _PatientChatListState createState() => _PatientChatListState();
}

class _PatientChatListState extends State<ChatList> {
  @override
  void initState() {
    if (widget.type == "2")
      getpation();
    else if (widget.type == "1") getdoctor();
    // TODO: implement initState
    super.initState();
  }

  List<dynamic> tags;

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
                                widget.type=="2"
                                    ? tags[index]["data"]["patient_name"]
                                    : tags[index]["data"]["doctor_name"],
                                tags[index]["data"]["msg_num"],
                                widget.type == "2"
                                    ? tags[index]["data"]["patient_id"]
                                    : tags[index]["data"]["doctor_id"],
                                widget.id),
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
    var request = http.MultipartRequest(

        'POST', Uri.parse('http://covide.freehostksa.net/api/get_doctor_chat.php'));

    request.fields.addAll({'user_id': this.widget.id??"1"});

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

  Future<void> getdoctor() async {
    var request = http.MultipartRequest(
       // 'POST', Uri.parse('http://172.20.10.3/api/get_patient_chat.php'));
        'POST', Uri.parse('http://covide.freehostksa.net/api/get_patient_chat.php'));

    request.fields.addAll({'user_id': this.widget.id??"2"});

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
  final int count;
  final String otherid;
  final String myid;

  PationRow(this.name, this.count, this.otherid, this.myid);

  @override
  Widget build(BuildContext context) {
    final pationCardContent = new Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Chat(
                  myid: myid,
                  otherid: otherid,
                );
              },
            ),
          );
        },
        child: new Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                child: Text(
                  name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              // count > 0
              // ?
              new Container(
                child: Text(
                   count.toString(),
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              )
              // : new Container()
            ],
          ),
        ),
      ),
    );

    final pationCard = new Container(
      child: pationCardContent,
      height: 110.0,
      decoration: new BoxDecoration(
        color: new Color(0xFFFFFFFF),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(10.0),
      ),
    );

    return new Container(
      margin: EdgeInsets.all(15.0),
      child: new Column(
        children: <Widget>[
          pationCard,
        ],
      ),
    );
  }
}
