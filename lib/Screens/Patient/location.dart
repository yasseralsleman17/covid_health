import 'package:flutter/material.dart';
import 'dart:collection';
import 'dart:convert';

import 'package:covid_health/Screens/Patient/measure_oxygen.dart';
import 'package:covid_health/Screens/Patient/patient_home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
class PLocation extends StatefulWidget {
  final String id;
  const PLocation({Key key, this.id}) : super(key: key);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<PLocation> {


  bool showmap = false;
  Location location = Location();
  GoogleMapController _controller;
  var mark = HashSet<Marker>();

  LocationData _currentPosition;
  LatLng _initialcameraposition=new LatLng(21.343434, 39.545454);

  @override
  void initState() {
    getLoc();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  Column(
        children: [
          Container(height: MediaQuery.of(context).size.height *0.80,
            child:
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: _initialcameraposition,
                zoom: 15,
              ),
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,

            ),

            ),


            Container(
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: RaisedButton(
                onPressed: () async {
                    update();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                textColor: Colors.white,
                padding: const EdgeInsets.all(0),
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: MediaQuery.of(context).size.width * 0.6,
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Color(0xFF98b593),
                  ),
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "Update location ",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

        ],
      ),
    );
  }


  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;


  }
  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.DENIED) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.GRANTED) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    _initialcameraposition =
        LatLng(_currentPosition.latitude, _currentPosition.longitude);
    location.onLocationChanged().listen((LocationData currentLocation) {
      if (!mounted) return;

      setState(()  {
        _currentPosition = currentLocation;
        _initialcameraposition =
            LatLng(_currentPosition.latitude, _currentPosition.longitude);

        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(_initialcameraposition.latitude, _initialcameraposition.longitude), zoom: 15),
          ),
        );
      });

    });
  }


  Future<void> update() async {



    var request = http.MultipartRequest('POST',
        Uri.parse('https://covide.freehostksa.net/api/user_more_information.php'));
    request.fields.addAll({
      'id': widget.id,
      'lan' : _initialcameraposition.latitude.toString() ,
      'log' : _initialcameraposition.longitude.toString()
    });

    http.StreamedResponse response = await request.send();



  }



}
