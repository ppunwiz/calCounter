
import 'package:cal_counter/pages/calculate.dart';
import 'package:cal_counter/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectFoodPage extends StatefulWidget {
  const SelectFoodPage({Key key}) : super(key: key);
  @override
  SelectFoodPageState createState() => SelectFoodPageState();
}

class SelectFoodPageState extends State<SelectFoodPage> {
  @override
  void initState() {
    super.initState();
  }

  List<double> selected = [];
  Map<double, String> foods =  {180: "Soft-boiled rice",
    160:	"Rice porridge",
    15:	"Coffee",
    42:	"Milk",
    84:	"Chocolate milk",
    330:	"Soymilk + Patongo",
    95:	"Bread",
    205:	"Croissant",
    447:	"Grilled Pork + Sticky Rice",
    49:	"Sausage",
    181: "Steamed stuff bun",
    450: "Sandwitch",
    196:	"Fried egg",
    75:	"Egg",
    215:	"Omelet",
    227:	"Pancakes",
    192:	"Noodle",
    334:	"Cocoa",
    393:	"Fried fish",
    311:	"French fried",
    38:	"Cola",
    120:	"Salad",
    488:	"Padthai",
    270:	"Steak",
    231:	"Rice + Stir-fried pork basil",
    240:	"Green chicken curry",
    80:	"Rice",
    260:	"Sukiyaki",
    331:	"Egg + Pork in sweet brown sauce",
    226:	"Grilled chicken",
    125:	"Papaya salad",
    350:	"Bubble tea",
    130:	"Spicy minced pork salad",
    380:	"Pizza",
    161:	"Sticky rice",
    121:	"Clear soup",
    244:	"Spaghetti",
    295:	"Nuggets",
    34:	"Sushi",
    268:	"Fried chicken",
    40:	"Bacon",
    741.7:	"Spaghetti carbonara",
    730:	"Stir-fried rice noodles with soy sauce",
    66:	"River prawn spicy soup",
    690:	"Fried noodle with pork",
    585:	"Rice steamed with chicken",
    122:	"Spicy glass noodle salad",
    207:	"Ice cream",
    305:	"Cake",
    370:	"Cookies",
    375:	"Pop corn",
    249:	"Donut",
    289:	"Pie",
    306:	"Cupcake",
    381:	"Pretzel",
    81:	"Apple",
    111:	"Apple juice",
    105:	"Banana",
    57:	"Cantaloupe",
    114:	"Grape",
    65:	"Orange",
    112:	"Orange juice",
    61:	"Raspberries",
    45:	"Strawberries",
    50:	"Watermelon",
    296:	"Hamburger"
  };

  @override
  Widget build(BuildContext context) {

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

      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(

                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Column(
                        children: [
                          const SizedBox(width: 10,),
                          foodList(),
                          const SizedBox(width: 8,),
                        ])
                ));}
      ),

    );
  }

  Container foodList(){
    return Container(
      color: Colors.grey[200],
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: foods.length,
        itemBuilder: (context, index) {
          String food = foods.values.elementAt(index);
          String kCal = foods.keys.elementAt(index).toString();
          return Card(
              child: ListTile(
                title: Text(kCal+" kCal"+" "+food),
                onTap: () { //
                  selected.add(double.parse(kCal));
                  if(mounted) {
                    setState(() {
                    var confirm = popUp();
                    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) => confirm);
                  });
                  }
                  print("selected: "+selected.length.toString());
                },
              )

          );
        },

      ),
    );
  }

  Widget popUp(){
    return AlertDialog(
        title: const Text("Selected!"),
        content: const Text("Do you need to submit?"),
        actions: [
          FlatButton(textColor: const Color(0xFF6200EE),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("No"),),
          FlatButton(textColor: const Color(0xFF6200EE),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const CalculatePage();
                  },
                  settings: RouteSettings( arguments: selected),
                ),
              );
            },
            child: const Text("Submit"),),
        ]
    );
  }

}