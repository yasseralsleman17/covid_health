import 'package:covid_health/Screens/Admin/admin_home_page.dart';
import 'package:covid_health/Screens/Doctor/doctor_home_page.dart';
import 'package:covid_health/Screens/Patient/patient_home_page.dart';
import 'package:covid_health/Screens/register/register.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  bool show_password = true;

  String email;

  String password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              Image.asset(
                "assets/images/saed.PNG",
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  validator: (val) => val.isEmpty ? '*Required Field' : null,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.mail,
                        color: Color(0xFF98b593),
                        size: 40,
                      ),
                      labelText: "Email",
                      hintText: "@email.com",
                      alignLabelWithHint: true),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  validator: (val) => val.isEmpty ? '*Required Field' : null,
                  obscureText: show_password,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: Color(0xFF98b593),
                      size: 40,
                    ),
                    labelText: "Password",
                    suffixIcon: Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            show_password = !show_password;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.05),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      log_in();
                    }
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: size.width * 0.6,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color(0xFF98b593),
                    ),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "LOGIN",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
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

  Future<void> log_in() async {

      var request = http.MultipartRequest(
          'POST', Uri.parse('http://covide.freehostksa.net/api/signin.php'));
      request.fields.addAll({'email': email, 'password': password});

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var allresponse = json.decode(await response.stream.bytesToString());
        var code = allresponse['code'].toString();
        var message = allresponse['message'];
        if (code == "-1") {
          Fluttertoast.showToast(
              msg: message,
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 16.0);
          return;
        }

else {
        Fluttertoast.showToast(
            msg: "Logged in successfully",
            toastLength: Toast.LENGTH_SHORT,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
        if (allresponse['data']['user_type'] == "3")

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AdminHomePage()));


       else if (allresponse['data']['user_type'] == "1")
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PatientHomePage(
                        id: allresponse['data']['id'].toString(),
                    name: allresponse['data']['name'].toString(),
                      )));

       else if (allresponse['data']['user_type'] == "2")
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DoctorHomePage(
                        id: allresponse['data']['id'].toString(),
                        name:allresponse['data']['name'].toString(),
                      )));
      }}
    }
  }

