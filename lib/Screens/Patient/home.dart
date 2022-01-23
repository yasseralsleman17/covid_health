import 'package:covid_health/Screens/Chat/chat_names_list.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../Chat/chat.dart';

class Home extends StatefulWidget {
  final String id;
  final String name;
  const Home( {Key key,this.id,this. name}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
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
                style: TextStyle(fontSize: 30),
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
                      onPressed: () {
                        setState(() {
                          pageController.jumpToPage(4);
                          // screen = "heart beats";
                        });
                      },
                    ),
                    Text("heart beats",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        )),
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
                      onPressed: () {
                        setState(() {
                          pageController.jumpToPage(5);
                          // screen = "heart beats";
                        });
                      },
                    ),
                    Text("Blood pressure",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        )),
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
                      onPressed: () {
                        setState(() {
                          pageController.jumpToPage(6);
                          // screen = "heart beats";
                        });
                      },
                    ),
                    Text("Temperature",
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
                      onPressed: () {

                        setState(() {
                          pageController.jumpToPage(7);
                          // screen = "heart beats";
                        });


                      },
                    ),
                    Text("measure oxygen",
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
          Container(
            height: 20,
          ),
          GestureDetector(
            onTap: (){

              setState(() {
                pageController.jumpToPage(8);
                // screen = "heart beats";
              });
            },
            child: Card(
              color: Colors.white,
              child: Container(
                decoration: new BoxDecoration(
                  border: Border.all(
                      color: Color(0xff636363)
                  ),
                ),
                width: 300,
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/syringe_blood.png",
                    ),
                    Text(
                      " Corona vaccine",
                      style: TextStyle(fontSize: 17),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 20,
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChatList(id: widget.id,type: "1");
                  },
                ),
              );


            },
            child: Card(
              color: Colors.white,
              child: Container(
                decoration: new BoxDecoration(
                  border: Border.all(
                      color: Color(0xff636363)
                  ),
                ),
                width: 300,
                child: Row(
                  children: [
                    Icon(
                      Icons.chat,
                      color: Theme.of(context).primaryColor,
                      size: 50,
                    ),
                    Text(
                      "Chat with Doctor ",
                      style: TextStyle(fontSize: 17),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    // if (screen == "heart beats")
  }

}
