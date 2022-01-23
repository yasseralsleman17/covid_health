import 'package:covid_health/Screens/Patient/Notification.dart';
import 'package:covid_health/Screens/Patient/Call.dart';
import 'package:covid_health/Screens/Patient/temperature.dart';
import 'package:covid_health/Screens/Patient/measure_oxygen.dart';
import 'package:covid_health/widgets/custom_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:covid_health/main.dart';
import 'Medication.dart';
import 'appointments_covid.dart';
import 'blood_pressure.dart';
import 'heart_rate.dart';
import 'home.dart';

class PatientHomePage extends StatefulWidget {

  final String id;
  final String name;
  const PatientHomePage( {Key key, this.id,this.name}) : super(key: key);

  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      extendBody: true,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: <Widget>[
          Medication(id:widget.id),
          Notifications(id:widget.id),
          Call(),
          Home(id:widget.id,name:widget.name),
          HeartRate(id:widget.id),
          BloodPressure(id:widget.id),
          Temperature(id:widget.id),
          MeasureOxygen(id:widget.id),
          AppointmentsCovid(id:widget.id),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
