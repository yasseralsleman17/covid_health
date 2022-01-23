import 'package:covid_health/Screens/register/register.dart';
import 'package:flutter/material.dart';

import 'Screens/login/login.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              Text(
                "SAED",
                style: TextStyle(
                    color: Color(0xFF98b593),
                    fontWeight: FontWeight.bold,
                    fontSize: 35),
              ),
              SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
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
                      "Create an account",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: Color(0xFF98b593),
                    ),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: Center(
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                          color: Color(0xFF98b593),
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
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
}
