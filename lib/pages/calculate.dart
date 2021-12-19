import 'package:cal_counter/model/food/food.dart';
import 'package:cal_counter/model/record/record.dart';
import 'package:cal_counter/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../globals.dart' as globals;
import 'home/home_page.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({Key key}) : super(key: key);

  @override
  State createState() => CalculatePageState();
}

class CalculatePageState extends State<CalculatePage> {
  //not exceed 2000 kCal
  //remain kCal
  List<Food> selected = [];
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
      for (var element in selected) { kCal = kCal+element.kCal; }
    }
    String kCalText = "none";
    Box<User> userBox = Hive.box('users');
    User user = userBox.get(globals.email);
    double maxCal = user.maxKCal;
    Box<Record> recordBox = Hive.box('records');
    DateTime date = DateTime.now();
    String _date = date.year.toString()+"-"+date.month.toString()+"-"+date.day.toString();
    double oldKCal = 0;
    if(recordBox.length > 0){
      recordBox.keys.forEach((element) {if(element.toString().contains(_date)){
        oldKCal+=recordBox.get(element.toString()).kCals;
      }
      });
    }
    Widget showKCal;
    if(kCal > 0) {
      kCalText = kCal.toString();
      newKCal = maxCal - (kCal+oldKCal);
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
              const SizedBox(height: 30,),
              buildButtonSave(),

            ],
          ),
        ),
      );
    }

  save() {
    var uuid = Uuid();
    String id = uuid.v1();
    Record record = Record(id: id, userId: globals.userId, foods: selected, kCals: kCal,timestamp: DateTime.now());
    Box<Record> recordBox = Hive.box('records');
    recordBox.put(record.userId+"_"+record.timestamp.toString(), record);
    print('saved record');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage(),
    ));
  }

  Widget buildButtonSave() {
    return InkWell(
        child: Container(
            constraints: BoxConstraints.expand(height: 60, width: 220),
            child: Text("save",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.white)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.indigo[800], border: Border.all(width: 0.5,color: Colors.indigo[800],)),
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10)),
        onTap: () async {
          save();
        });
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
