import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Medication extends StatefulWidget {
  final String id;
  const Medication({Key key,this.id}) : super(key: key);

  @override
  _MedicationState createState() => _MedicationState();
}

class _MedicationState extends State<Medication> {
  final List<String> dataList = [];

  @override
  void initState() {
    get();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return   Container(
     // height: MediaQuery.of(context).size.height *0.15,
     // width: MediaQuery.of(context).size.width *0.75,

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
                color: Color(0x289C9C9C),
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
    );

  }



  Future<void> get() async {

    var request = http.MultipartRequest('POST', Uri.parse('https://covide.freehostksa.net/api/get_user_medicine.php'));
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
            dataList.add(tags[i]["data"]["medicine_name"]);
            print( tags[i]["data"]["medicine_name"]);

          });
        }
    }
    else {
      print(response.reasonPhrase);
    }



  }



}
