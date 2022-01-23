import 'dart:collection';
import 'dart:convert';

import 'package:covid_health/Screens/Patient/measure_oxygen.dart';
import 'package:covid_health/Screens/Patient/patient_home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class AddDiseaseInformation extends StatefulWidget {
  final String id;
  final String name;


  const AddDiseaseInformation({Key key, this.id, this.name}) : super(key: key);

  @override
  _AddDiseaseInformationState createState() => _AddDiseaseInformationState();
}

class _AddDiseaseInformationState extends State<AddDiseaseInformation> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _MedicineController = new TextEditingController();

  final List<String> dataList = [];
  String ss;
  String illness="Pneumonia";
  String person="patient";


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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset(
                "assets/images/saed.PNG",
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("patient/Responsible",
                      style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w400)),
                  DropdownButton(
                      hint: Text("patient"),
                      onChanged: (val) {
                        setState(() {
                          person = val;    });
                      },
                      value: "patient",
                      items: [
                        DropdownMenuItem( value: 'patient',
                            child: Text("patient",
                                style: TextStyle(color: Colors.black))),
                        DropdownMenuItem( value: 'Responsible',
                            child: Text("Responsible",
                                style: TextStyle(color: Colors.black))),

                      ]),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("your illness:",
                  style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w400)),
                  DropdownButton(
                      hint: Text("Pneumonia"),
                      onChanged: (val) {
                        setState(() {
                          illness = val;    });
                      },
                      value: illness,
                      items: [
                        DropdownMenuItem( value: 'Liver Cirrhosis',
                            child: Text("Liver Cirrhosis",
                                style: TextStyle(color: Colors.black))),
                        DropdownMenuItem( value: 'Epidemic Hepatitis',
                            child: Text("Epidemic Hepatitis",
                                style: TextStyle(color: Colors.black))),
                        DropdownMenuItem( value: 'Renal failure',
                            child: Text("Renal failure",
                                style: TextStyle(color: Colors.black))),
                        DropdownMenuItem( value: 'Pneumonia',
                            child: Text("Pneumonia",
                                style: TextStyle(color: Colors.black))),
                        DropdownMenuItem( value: 'asthma',
                            child: Text("asthma",
                                style: TextStyle(color: Colors.black))),
                        DropdownMenuItem( value: 'epilepsy',
                            child: Text("epilepsy",
                                style: TextStyle(color: Colors.black))),
                        DropdownMenuItem( value: 'Sinusitis',
                            child: Text("Sinusitis",
                                style: TextStyle(color: Colors.black))),
                        DropdownMenuItem( value: 'Tracheitis',
                            child: Text("Tracheitis",
                                style: TextStyle(color: Colors.black))),
                      ]),
                ],
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  validator: (val) => validateMedicine(),
                  controller: _MedicineController,
                  onFieldSubmitted: (_) {
                    if (_MedicineController.text.isNotEmpty)
                      setState(() {
                        dataList.add(ss);
                        _MedicineController.clear();
                      });
                  },
                  onChanged: (value) {
                    setState(() {
                      ss = value;
                    });
                  },
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.favorite,
                        color: Color(0xFF98b593),
                        size: 40,
                      ),
                      labelText: "Medicines you take"),
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: RaisedButton(
                  child: Text(
                    'Add Medicine',
                    style: TextStyle(fontSize: 20),
                  ),
                  color: Color(0xFF98b593),
                  onPressed: () => {
                    if (_MedicineController.text.isNotEmpty)
                      setState(() {
                        dataList.add(ss);
                        _MedicineController.clear();
                      }),
                  },
                ),
              ),

              Container(
                height: MediaQuery.of(context).size.height *0.15,
                width: MediaQuery.of(context).size.width *0.75,
                child: Column(
                  children: [
                    Flexible(
                      fit: FlexFit.loose,
                      child: GridView.builder(
                        physics: ScrollPhysics(),
                        itemCount: dataList.length,
                        itemBuilder: (context, index) => Card(
                          child:Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Container(
                                  margin:
                                  EdgeInsets.only(left: 25, right: 5),
                                  child: Text(
                                    (index + 1).toString() +
                                        " -)  " +
                                        dataList[index],
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.black),
                                  ),
                                ),
                              ),
                              new Container(
                                margin: EdgeInsets.only(right: 15),
                                child: Material(
                                  child: new IconButton(
                                    color: Color(0xFF98b593),
                                    iconSize:
                                    MediaQuery.of(context).size.height *
                                        0.03,
                                    icon: Icon(Icons.delete),
                                    onPressed: () {
                                      setState(() {
                                        dataList.remove(dataList[index]);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 5,
                          crossAxisCount: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 200,
              child:  GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: _initialcameraposition,
                  zoom: 15,
                ),
                onMapCreated: _onMapCreated,
                myLocationEnabled: true,
              ),),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: RaisedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      saveinformation();
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 40.0,
                    width: size.width * 0.6,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color(0xFF98b593),
                    ),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "Add information ",
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


  validateIllness(String value) {
    if (value.length == 0) {
      return '*Required Field';
    } else {
      return null;
    }
  }

  validateMedicine() {
    if (dataList.length == 0) {
      return '*Required Field';
    } else {
      return null;
    }
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


  Future<void> saveinformation() async {


    var request = http.MultipartRequest('POST',
        Uri.parse('https://covide.freehostksa.net/api/user_more_information.php'));
    request.fields.addAll({
      'id': widget.id,
      'illness': illness,
      'person': person,
      'lan' : _initialcameraposition.latitude.toString() ,
      'log' : _initialcameraposition.longitude.toString()
    });

    http.StreamedResponse response = await request.send();


    String medicine = "";
    for (int i = 0; i < dataList.length; i++) {
      if (i==0)
        medicine = medicine + dataList[i];
      else
        medicine = medicine + "," + dataList[i];
    }


    var request2 = http.MultipartRequest('POST',
        Uri.parse('https://covide.freehostksa.net/api/add_medicine.php'));
    request2.fields.addAll({
      'user_id': widget.id,
      'ill': illness,
      'medicine': medicine,
    });

    http.StreamedResponse response2 = await request2.send();

    var allresponse=json.decode(await response2.stream.bytesToString());

    if (response2.statusCode == 200) {

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PatientHomePage(
                id: widget.id,
                name: widget.name,
              )));



    } else {
      print(response.reasonPhrase);
      print(response.request);
    }
  }


}