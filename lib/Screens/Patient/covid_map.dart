import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:http/http.dart' as http;


class CovidMap extends StatefulWidget {
  final String type;
  final String id;
  const CovidMap({Key key,this.type, this.id}) : super(key: key);

  @override
  _CovidMapState createState() => _CovidMapState();
}

class _CovidMapState extends State<CovidMap> {
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(21.343434, 39.545454);
  final Set<Marker> _markers = {};
  MapType _currentMapType = MapType.normal;
  String _detail = "";
  LatLng location;
  TextEditingController _lane1;

  DateTime selectedDate;
  DateTime sDate;
  TimeOfDay selectedTime;
  String locationId;

  @override
  void initState() {
    super.initState();
    getlocationData();
    _lane1 = new TextEditingController();
  }




  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            GoogleMap(
              mapToolbarEnabled: false,

              zoomControlsEnabled: false,
              onMapCreated: _onMapCreated,
              initialCameraPosition:
              CameraPosition(target: _center, zoom: 5),
              markers: _markers,
              mapType: _currentMapType,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.topRight,
                child: Column(
                  children: <Widget>[
                    _customButton(
                        FontAwesomeIcons.map, _onMapTypeButtonPressed),
                    SizedBox(
                      height: 15,
                    ),
                    _customButton(FontAwesomeIcons.mapPin, _getUserLocation),
                  ],
                ),
              ),
            ),
            SlidingUpPanel(
                minHeight: _height * 0.05,
                maxHeight: _height * 0.4,
                panel: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 4,
                        width: _width * 0.2,
                        color: Color(0xFF98b593),
                      ),

                      Container(
                        color: Color(0xffffffff),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: _height * 0.1,
                              width: _width,
                              color: Color(0xffffffff),
                              child: TextField(
                                maxLines: 4,
                                controller: _lane1,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                      borderSide:
                                      BorderSide(width: 1, color: Color(0xFF98b593)),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(4)),
                                      borderSide:
                                      BorderSide(width: 1, color: Color(0xFF98b593)),
                                    ),
                                    errorStyle: TextStyle(
                                        color: Color(0xFF98b593).withOpacity(0.5)),
                                    labelStyle: TextStyle(
                                        color: Color(0xFF98b593).withOpacity(0.5)),
                                    labelText: "Address "),
                                cursorColor: Color(0xFF98b593),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          RaisedButton(
                            onPressed: () => _selectDate(context),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0),
                            child: Container(
                              alignment: Alignment.center,
                              height: 50.0,
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: new BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Color(0xFF98b593),
                              ),
                              padding: const EdgeInsets.all(0),
                              child: Text(
                                "Select date  ",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Text(
                            selectedDate != null
                                ? "${selectedDate.toLocal()}".split(' ')[0]
                                : "",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            selectedTime != null
                                ? "${selectedTime.hour}:${selectedTime.minute}"
                                : "",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),


                      Container(
                        child: InkWell(
                          onTap: _saveAddress,
                          child: Container(
                            alignment: Alignment.center,
                            width: _width * 0.3,
                            height: 40,
                            padding: EdgeInsets.only(
                                left: 10, right: 10, top: 6, bottom: 6),
                            decoration: BoxDecoration(
                                color: Color(0xFF98b593),
                                borderRadius: BorderRadius.circular(12)),
                            child: Text(
                              "Save",
                              style: TextStyle(
                                  color: Color(0xffffffff),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                body: null)
          ],
        ),
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);

  }


  _customButton(IconData icon, Function function) {
    return FloatingActionButton(
      heroTag: icon.codePoint,
      onPressed: function,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor:   Color(0xffffffff),

      child: Icon(
        icon,
        size: 16,
        color: Color(0xFF98b593),
      ),
    );
  }

  _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }


  _getUserLocation() async {
    Position p = await Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(p.latitude, p.longitude), zoom: 16),
      ),
    );


  }



  _saveAddress() async {


    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse('http://covide.freehostksa.net/api/add_appointment.php'));
    request.bodyFields = {
      'loc_id': locationId,
      'id': widget.id,
      'date': selectedDate.year.toString()+"/"+selectedDate.month.toString()+"/"+selectedDate.day.toString(),
      'time': selectedTime.hour.toString()+":"+selectedTime.minute.toString(),
      'type':widget.type
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    }
    else {
      print(response.reasonPhrase);
    }

  }

  void addmarker(tag) {
print(tag["lag"].toString());
    setState(() {
      _markers.add(Marker(
        onTap:() {
          setState(() {
            _lane1.text=tag["address"];
            locationId=tag["id"];
          });

        },
        markerId: MarkerId(tag["id"]),
        position: LatLng(double.parse(tag["lag"].toString()),double.parse(tag["log"].toString())),
        infoWindow: InfoWindow(title: widget.type, snippet: tag["address"]),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ));
    });


  }




  _selectDate(BuildContext context) {
    sDate = DateTime.now();
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
        return buildMaterialDatePicker(context);
    }
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: sDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2023),
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: _decideWhichDayToEnable,
      helpText: 'Select  date',
      cancelText: 'Cancel',
      confirmText: 'Ok',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      fieldLabelText: 'Select date',
      fieldHintText: 'Month/Date/Year',
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );

    final TimeOfDay picked2 = await showTimePicker(initialTime: TimeOfDay.fromDateTime(DateTime.now()), context: context,

      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,

        );
      },);


    if (picked2 != null )
      setState(() {
        selectedTime = picked2;
      });



    if (picked != null )
      setState(() {
        selectedDate = picked;
      });
  }


  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isBefore(DateTime(2023) )&&
        day.isAfter(DateTime.now().subtract(Duration(days: 1))))) {
      return true;
    }
    return false;
  }

  Future<void> getlocationData() async {

    var headers = {
      'Content-Type': 'application/x-www-form-urlencoded'
    };
    var request = http.Request('POST', Uri.parse('http://covide.freehostksa.net/api/get_all_location.php'));
    request.bodyFields = {
      'type': widget.type
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {


      var tagsJson = json.decode(await response.stream.bytesToString());


      List<dynamic>   tags = tagsJson != null ? List.from(tagsJson) : null;


      for(int i=0;i<tags.length;i++)
        addmarker( tags[i]["data"]);



    }
    else {
    print(response.reasonPhrase);
    }
  }




}