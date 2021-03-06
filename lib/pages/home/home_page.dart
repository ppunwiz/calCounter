import 'package:cal_counter/pages/add_food_page.dart';
import 'package:cal_counter/pages/calories.dart';
import 'package:cal_counter/pages/food_page.dart';
import 'package:cal_counter/pages/record_view_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/category_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> setKCal() async {
    SharedPreferences preferences = await _prefs;
    setState(() {
      preferences.setDouble("kCal", 2000);
    });
  }
  @override
  Widget build(BuildContext context) {
    setKCal();
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .45,
            decoration: const BoxDecoration(
              color: Color(0xFFF5CEB8),
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      width: 52,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF2BEA1),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  SizedBox(height: 50,),
                  Text(
                    "Hello",
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 150,),
                  //const SearchBar(),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CategoryCard(
                          title: "Select Food",
                          img: "assets/icons/food.jpg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const SelectFoodPage();
                                },
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          title: "Calories limit",
                          img: "assets/icons/calories.jpg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const CaloriesPage();
                                },
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          title: "Add Food",
                          img: "assets/icons/add_food.png",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return AddFoodPage();
                                },
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          title: "Record",
                          img: "assets/icons/calendar.png",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const RecordViewPage();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}