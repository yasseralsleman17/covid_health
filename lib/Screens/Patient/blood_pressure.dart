import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:covid_health/widgets/flutter_flow_drop_down.dart';

import '../../main.dart';

class BloodPressure extends StatefulWidget {
  final String id;
  const BloodPressure({Key key,this.id}) : super(key: key);

  @override
  _BloodPressureState createState() => _BloodPressureState();
}

class _BloodPressureState extends State<BloodPressure> {


  String blood_pressure,Previous_measure;
  String dropDownValue;


  final _formKey = GlobalKey<FormState>();

  final List<String> dataList = [
    "Date",
    "Time",
    "blood pressure",
  ];

  List<String> options=[];



  @override
  void initState() {
    setState(() {


      for(int i=70;i<150;i++)
      {
        options.add(i.toString());
      }
    });
    getBloodPressure();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(

                            child: Icon(
                              Icons.arrow_back,
                              color: Color(0xFF98b593),
                              size: 40,
                            ),onTap: (){

                            setState(() {
                              pageController.jumpToPage(4);
                            });


                          },
                          ),
                          Container(
                            child: Image.asset(
                              "assets/images/sphygmomanometer.png",
                              width: 150,
                            ),
                          ),
                          GestureDetector(

                            child: Icon(
                              Icons.arrow_forward,
                              color: Color(0xFF98b593),
                              size: 40,
                            ),onTap: (){
                            setState(() {
                              pageController.jumpToPage(6);
                            });
                          },
                          ),

                        ],
                      ),
                      Text(
                        "Normal blood pressure is between 90 and 120",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(height: 20,),

                      Column(
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                EdgeInsetsDirectional.fromSTEB(25, 0, 10, 0),
                                child: FlutterFlowDropDown(
                                  initialOption: dropDownValue ??= "75",
                                  options: options,
                                  onChanged: (val) {
                                    setState(() {
                                      dropDownValue = val;
                                      blood_pressure=val;
                                    });
                                  },
                                  width: 100,
                                  height: 40,
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  fillColor: Colors.white,
                                  elevation: 2,
                                  borderColor: Colors.transparent,
                                  borderWidth: 0,
                                  borderRadius: 0,
                                  margin: EdgeInsetsDirectional.fromSTEB(8, 4, 8, 4),
                                ),
                              ),
                              Text(
                                "mmhq",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              if (blood_pressure != null && blood_pressure.length > 0)
                                Container(
                                  margin: EdgeInsets.only(left: 40),
                                  child: Text(
                                    int.parse(blood_pressure) < 120 &&
                                        int.parse(blood_pressure) > 90
                                        ? blood_pressure + "  Normal "
                                        : blood_pressure + " Unnormal ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: int.parse(blood_pressure) < 120 &&
                                            int.parse(blood_pressure) > 90
                                            ? Colors.green
                                            : Colors.red),
                                  ),
                                )
                              else
                                Container(),
                            ],
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: RaisedButton(
                              onPressed: () async {
                                if (blood_pressure!=null) {
                                  updateBloodPressure();
                                }

                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(0),
                              child: Container(
                                alignment: Alignment.center,
                                height: 50.0,
                                width: MediaQuery.of(context).size.width * 0.3,
                                decoration: new BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Color(0xFF98b593),
                                ),
                                padding: const EdgeInsets.all(0),
                                child: Text(
                                  "Update",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 5,
                      ),
                      Divider(
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),

                Container(
                  height: MediaQuery.of(context).size.height *0.27,
                  child: Flexible(
                    fit: FlexFit.loose,
                    child: GridView.builder(
                      physics: ScrollPhysics(),
                      itemCount: dataList.length,
                      itemBuilder: (context, index) => ItemTile(index, dataList[index]),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 4,
                        crossAxisCount: 3,
                      ),
                    ),
                  ),
                ),
                Container(

                  margin: EdgeInsets.only(bottom: 100),
                  child:
                  Column(children: [


                    Container(
                      child: Image.asset(
                        "assets/images/pulse_icon.png",
                        width: 200,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                " current measure",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 20),
                              child: Text(

                                blood_pressure!=null? blood_pressure:"",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          width: 3,
                          height: 100,
                          color: Colors.grey,
                        ),
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                " Previous measure",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 20),
                              child: Text(
                                Previous_measure!=null? Previous_measure:"",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ],
                        ),


                      ],
                    ),


                  ],),),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateBloodPressure() async {

    DateTime selectedDate = DateTime.now();
    String date=selectedDate.day.toString()+"/"+selectedDate.month.toString()+"/"+selectedDate.year.toString();
    String time=selectedDate.hour.toString()+":"+selectedDate.minute.toString();

    setState(() {
      dataList.add(date);
      dataList.add(time);
      dataList.add(blood_pressure);
    });

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://covide.freehostksa.net/api/add_compare_blod.php'));
    request.fields.addAll({
      'p_id': widget.id,
      'pressure': blood_pressure,
      'pressure_date': date,
      'pressure_time': time
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {

      var tagsJson = json.decode(await response.stream.bytesToString());


      List<dynamic>   tags = tagsJson != null ? List.from(tagsJson) : null;
      if(tags[0]["code"]==1)

        setState(() {
          Previous_measure=tags[0]["data"]["pressure"];
        });


    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> getBloodPressure() async {

    var request = http.MultipartRequest('POST', Uri.parse('https://covide.freehostksa.net/api/get_all_blod_pressure.php'));
    request.fields.addAll({
      'p_id': widget.id
    });


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var tagsJson = json.decode(await response.stream.bytesToString());

      List<dynamic>   tags = tagsJson != null ? List.from(tagsJson) : null;


      for(int i=0;i<tags.length;i++)
        if(tags[i]["code"]==1)
        {
          setState(() {
            dataList.add(tags[i]["data"]["pressure_date"]);
            dataList.add(tags[i]["data"]["pressure_time"]);
            dataList.add(tags[i]["data"]["pressure"]);
          });


        }


    }
    else {
      print(response.reasonPhrase);
    }



  }




}

class ItemTile extends StatelessWidget {
  final int itemNo;
  final String data;

  const ItemTile(
      this.itemNo,
      this.data,
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: new BoxDecoration(
          border: Border.all(color: Color(0xff000000)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              data,
            ),
          ],
        ),
      ),
    );
  }
}

