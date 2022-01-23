import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PatinetHealthInformation extends StatefulWidget {
  final String id;
  final String name;

  const PatinetHealthInformation({Key key, this.id, this.name})
      : super(key: key);

  @override
  _PatinetHealthInformationState createState() =>
      _PatinetHealthInformationState();
}

class _PatinetHealthInformationState extends State<PatinetHealthInformation> {
  final List<String> dataList = [];
  TextEditingController _MedicineController = new TextEditingController();

  String ss;
  String heart="!!";
  String Blood="!!";
  String Temperature="!!";
  String oxygen="!!";

  List<dynamic> tags;

  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    get();
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.person_outline,
                    color: Theme.of(context).primaryColor,
                    size: 100,
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              Container(
                height: 20,
              ),
              Divider(
                color: Colors.black,
              ),
              Container(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    color: Color(0xd8bb50f5),
                    child: Column(
                      children: [
                        IconButton(
                          icon: Image.asset(
                            "assets/images/heart_rate.png",
                          ),
                          iconSize: MediaQuery.of(context).size.width / 5,
                          onPressed: () {},
                        ),
                        Text(
                          "heart beats",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        if(heart != null)   Text(
                          heart,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xe8e88862),
                    child: Column(
                      children: [
                        IconButton(
                          icon: Image.asset(
                            "assets/images/sphygmomanometer.png",
                          ),
                          iconSize: MediaQuery.of(context).size.width / 5,
                          onPressed: () {},
                        ),
                        Text(
                          "Blood pressure",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        if(Blood != null)    Text(
                          Blood,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Color(0xd57becec),
                    child: Column(
                      children: [
                        IconButton(
                          icon: Image.asset(
                            "assets/images/thermometer.png",
                          ),
                          iconSize: MediaQuery.of(context).size.width / 5,
                          onPressed: () {},
                        ),
                        Text("Temperature",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            )),
                        if(Temperature != null)  Text(Temperature,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            )),
                      ],
                    ),
                  ),
                  Container(
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      children: [
                        IconButton(
                          icon: Image.asset(
                            "assets/images/health_checkup.png",
                          ),
                          iconSize: MediaQuery.of(context).size.width / 5,
                          onPressed: () {},
                        ),
                        Text("measure oxygen",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            )),
                        if(oxygen != null)   Text(oxygen,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 20,
              ),
              Divider(
                color: Colors.black,
              ),
             if(dataList!=null)
               Container(
             height: MediaQuery.of(context).size.height *0.25,
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
                      labelText: "Add Medicines "),
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
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color(0xFF98b593),
                    ),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "update Medicine information ",
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

  Future<void> get() async {

    var request = http.MultipartRequest('POST',
        Uri.parse('https://covide.freehostksa.net/api/get_user_health.php'));
    request.fields.addAll({
      'p_id': widget.id,
    });

    http.StreamedResponse response = await request.send();



    if (response.statusCode == 200) {

      var tagsJson = json.decode(await response.stream.bytesToString());


        tags = tagsJson != null ? List.from(tagsJson) : null;

      for(int i=0;i<tags.length;i++)
        {


          if( tags[i]["code"]==1)

            {
              Temperature= tags[i]["data"]["temprature"];


            }
          if( tags[i]["code"]==2)

          {

            oxygen= tags[i]["data"]["oxygen"];

          }

          if( tags[i]["code"]==3)

          {
            Blood= tags[i]["data"]["blod"];

          }

          if( tags[i]["code"]==4)

          {
            heart= tags[i]["data"]["beats"];
          }
        }

    }


    var request2 = http.MultipartRequest('POST', Uri.parse('https://covide.freehostksa.net/api/get_user_medicine.php'));
    request2.fields.addAll({
      'p_id': widget.id
    });


    http.StreamedResponse response2 = await request2.send();

    if (response2.statusCode == 200) {
      var tagsJson2 = json.decode(await response2.stream.bytesToString());

      List<dynamic>   tags2 = tagsJson2 != null ? List.from(tagsJson2) : null;

      print(tags2.toString());
      for(int i=0;i<tags2.length;i++)
        if(tags2[i]["code"]==1)
        {
          setState(() {
            dataList.add(tags2[i]["data"]["medicine_name"]);

          });
        }
    }
    else {
      print(response2.reasonPhrase);
    }

  }

  Future<void> saveinformation() async {


    String medicine = "";
    for (int i = 0; i < dataList.length; i++) {
      if (i==0)
        medicine = medicine + dataList[i];
      else
        medicine = medicine + "," + dataList[i];
    }

    var request2 = http.MultipartRequest('POST',
        Uri.parse('https://covide.freehostksa.net/api/update_medicine.php'));
    request2.fields.addAll({
      'user_id': widget.id,
      'medicine': medicine,
    });

    http.StreamedResponse response2 = await request2.send();

  }

  validateMedicine() {
    if (dataList.length == 0) {
      return '*Required Field';
    } else {
      return null;
    }
  }
}

