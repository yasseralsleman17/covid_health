import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'welcome_page.dart';

class Profile extends StatefulWidget {
  final String id;
  const Profile({Key key, this.id}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  List<dynamic> tags;
  String full_name="";
  String gender="";
  String age="";
  String phone="";
  String email="";
  String password="";

  @override
  void initState() {
    get();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (tags == null )
          ? Container( color: Colors.blue.withOpacity(0.1),)
          : Container( color: Colors.blue.withOpacity(0.1),
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  enabled: false,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "FULL NAME",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText:
                      full_name,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  enabled: false,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Gender",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText:  gender,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  enabled: false,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Age",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: age,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  enabled: false,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Phone",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: phone,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  enabled: false,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Email",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: email,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),
 Padding(
                padding: const EdgeInsets.only(bottom: 35.0),
                child: TextField(
                  enabled: false,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: 3),
                      labelText: "Password",
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: password,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                ),
              ),


              SizedBox(
                height: 35,
              ),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomePage()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color(0xFF98b593),
                    ),
                    padding: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Center(
                      child: Text(
                        "Sign out",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
          full_name = tags[i]["data"]["name"];
           gender=tags[i]["data"]["gender"];
           age=tags[i]["data"]["age"];
           phone=tags[i]["data"]["phone"];
           email=tags[i]["data"]["email"];
           password=tags[i]["data"]["password"];
        }
        setState(() {

        });
      }
    }
  }
}

