import 'package:flutter/material.dart';

class ViewAppointments extends StatefulWidget {
  final String id;
 final List appoiintment;
  const ViewAppointments({Key key,this.id, this. appoiintment}) : super(key: key);

  @override
  _ViewAppointmentsState createState() => _ViewAppointmentsState();
}

class _ViewAppointmentsState extends State<ViewAppointments> {
  @override
  Widget build(BuildContext context) {
print (widget.appoiintment.toString());
    return  Scaffold(
      backgroundColor: Colors.blue.withOpacity(0.1),
      body: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                height: MediaQuery.of(context).size.height * 0.90,
                child: ListView.builder(
                  physics: ScrollPhysics(),
                  itemCount: widget.appoiintment.length,
                  itemBuilder: (context, index) => new AppointmentsRow(
                    index: index,
                    date: widget.appoiintment[index]["data"]["date"].toString(),
                    time: widget.appoiintment[index]["data"]["time"].toString(),
                    type: widget.appoiintment[index]["data"]["type"]=="1"? "COVID test": "COVID vaccine",
                  ),

                ),
              ),
            ],
          )),
    );
  }
}
class AppointmentsRow extends StatelessWidget {
  final index;
  String date, time, type;

  AppointmentsRow({this.index, this.date, this.time, this.type});

  @override
  Widget build(BuildContext context) {
    final AppointmentsCardContent = new Container(
      child: new Container(
        child: Column(
          children: [
            Text(
          type,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  date ,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  time,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),


              ],
            ),
          ],
        ),
      ),
    );

    final AppointmentsCard = new Container(
      child: AppointmentsCardContent,
      height: 110.0,
      decoration: new BoxDecoration(
        color: new Color(0xFFFFFFFF),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(10.0),
      ),
    );

    return new Container(
      margin: EdgeInsets.all(15.0),
      child: new Column(
        children: <Widget>[
          AppointmentsCard,
        ],
      ),
    );
  }
}
