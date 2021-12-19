import 'package:cal_counter/model/food/food.dart';
import 'package:cal_counter/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class AddFoodPage extends StatefulWidget {
  const AddFoodPage({Key key}) : super(key: key);
  @override
  _AddFoodPageState createState() => _AddFoodPageState();
}

class _AddFoodPageState extends State<AddFoodPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  double calories;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              BackButton( onPressed: () { Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()
              ));
              }
              ),
              Spacer(),
              Text("Add Food"),
              Spacer(),
            ]
        ),
        backgroundColor: Colors.indigo[900],
        elevation: 0.0,

      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Container(
                    color: Colors.grey[200],
                    child: Column(children: <Widget>[
                      SizedBox(height: 10,),
                      buildTextFieldname(),
                      SizedBox(height: 8,),
                      buildTextFieldCal(),
                      SizedBox(height: 8,),
                      buildButtonSubmit()
                    ])
                    ,),

                ));}
      ),

      //*****************end body****************************//
    );
  }

  submit() {
    var uuid = Uuid();
    String id = uuid.v1();
    Food food = Food(id: id, name: nameController.text, kCal: double.parse(caloriesController.text));
    Box<Food> foodBox = Hive.box('foods');
    foodBox.put(food.name, food);
    print('saved food');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage(),
    ));
  }

  Widget buildButtonSubmit() {
    return InkWell(
        child: Container(
            constraints: BoxConstraints.expand(height: 60, width: 220),
            child: Text("submit",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: Colors.white)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.indigo[800], border: Border.all(width: 0.5,color: Colors.indigo[800],)),
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.all(10)),
        onTap: () async {
          submit();
        });
  }

  Container buildTextFieldname() {
    return Container(
      constraints: BoxConstraints.expand(height: 50),
      padding: EdgeInsets.only(left:10),
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 0.5, color: Colors.grey)),
      child:  TextField(
        decoration: InputDecoration.collapsed(hintText: "name"),
        style: TextStyle(fontSize: 30),
        onChanged: (val){
          print('onchanged val name: '+val);
          if(mounted) setState(() {
            nameController.text = val;
          });
          print('name='+nameController.text);
        },
      ),
    );
  }

  Container buildTextFieldCal() {
    return Container(
      constraints: BoxConstraints.expand(height: 50),
      padding: EdgeInsets.only(left:10),
      margin: EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 0.5, color: Colors.grey)),
      child:  TextField(
        decoration: InputDecoration.collapsed(hintText: "kCal"),
        style: TextStyle(fontSize: 30),
        onChanged: (val){
          print('onchanged val name: '+val);
          if(mounted) setState(() {
            caloriesController.text = val;
          });
          print('kCal='+caloriesController.text);
        },
      ),
    );
  }

}