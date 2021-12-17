import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home/home_page.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({Key key}) : super(key: key);

  @override
  State createState() => CalculatePageState();
}

class CalculatePageState extends State<CalculatePage> {
  //not exceed 2000 kCal
  //remain kCal
  List<double> selected = [];
  double kCal = 0;
  double newKCal;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if( ModalRoute.of(context).settings.arguments != null){
      selected = ModalRoute.of(context).settings.arguments;
      for (var element in selected) { kCal = kCal+element; }
    }
    String kCalText = "none";
    Widget showKCal;
    if(kCal > 0) {
      kCalText = kCal.toString();
      newKCal = 2000 - kCal;
      if(newKCal < 0){
        showKCal = exceed();
      }else{
        showKCal = notExceed();
      }
    }

      return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                BackButton( onPressed: () { Navigator.push(
                    context, MaterialPageRoute(builder: (context) => const HomePage()
                ));
                }
                ),
                const Spacer(),
                const Text("Select Food"),
                const Spacer(),
              ]
          ),
          backgroundColor: Colors.indigo[900],
          elevation: 0.0,

        ),
        //********************end app bar*****************************//
        body: Container(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Output : $kCalText",
                style: const TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple),
              ),
              const SizedBox(height: 30,),
              showKCal,

            ],
          ),
        ),
      );
    }

    Widget exceed(){
      return Text("You already consumed exceed kCal (exceeded = "+newKCal.abs().toString()+")", style: const TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.w300));
    }

    Widget notExceed(){
    return Text("Your consumed kCal is not exceeded yet (remaining = "+newKCal.toString()+")", style: const TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.w300,));
    }

}
