import 'dart:async';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:http/http.dart' as http;


class AddLocation extends StatefulWidget {
final String type;

  const AddLocation({Key key, this.type}) : super(key: key);
  @override
  _AddLocationState createState() => _AddLocationState();
}

class _AddLocationState extends State<AddLocation> {
  Completer<GoogleMapController> _controller = Completer();
    static const LatLng _center = const LatLng(21.343434, 39.545454);
  final Set<Marker> _markers = {};
  MapType _currentMapType = MapType.normal;
  String _detail = "";
  LatLng location;
  TextEditingController _lane1;

  @override
  void initState() {
    super.initState();
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
              CameraPosition(target: _center, zoom: 11.0),
              markers: _markers,
              mapType: _currentMapType,
              onTap: _handleTap,
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
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        color: Color(0xffffffff),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: _height * 0.2,
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
                      SizedBox(
                        height: 10,
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
                body: null
            )
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


  _handleTap(LatLng point) {
    location=point;
    _markers.clear();
    _getLocation(point);
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(title: widget.type, snippet: _detail),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ));
    });
  }

  _getLocation(LatLng point) async {
    final coordinates = new Coordinates(point.latitude, point.longitude);
    var addresses =
    await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");

    setState(() {
      _detail = first.countryName+  " - "+ first.locality+" - "+first.subLocality;
      _lane1.text =  _detail;
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
    var request = http.Request('POST', Uri.parse('http://covide.freehostksa.net/api/add_vaccine_test.php'));
    request.bodyFields = {
      'log': location.longitude.toString(),
      'lag': location.latitude.toString(),
      'address': _detail,
      'type': widget.type
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
}