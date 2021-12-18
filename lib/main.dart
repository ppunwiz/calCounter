import 'dart:html';

import 'package:cal_counter/model/calories/calories.dart';
import 'package:cal_counter/model/food/food.dart';
import 'package:cal_counter/model/record/record.dart';
import 'package:cal_counter/model/user/user.dart';
import 'package:cal_counter/pages/welcome/welcome_page.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'constant.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'model/isLogin/is_login.dart';

void main() async{

  final directory = await getApplicationDocumentsDirectory();

  Hive.registerAdapter(FoodAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CaloriesAdapter());
  Hive.registerAdapter(RecordAdapter());
  Hive.registerAdapter(isLoginAdapter());

  Hive.init(directory.path);

  await Hive.openBox<Food>('foods');
  await Hive.openBox<User>('users');
  await Hive.openBox<Calories>('calories');
  await Hive.openBox<Record>('records');
  await Hive.openBox<isLogin>('isLogin');

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  Map<String, dynamic> _deviceData = <String, dynamic>{};
  var _deviceIdentifier;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    var deviceIdentifier = 'unknown';
    var deviceData;
    var platform = Theme.of(context).platform;

    try {
      if (kIsWeb) {
        deviceData = await deviceInfoPlugin.webBrowserInfo;
        deviceIdentifier = deviceData.vendor + deviceData.userAgent + deviceData.hardwareConcurrency.toString();
      } else {
        if (platform == TargetPlatform.android) {
          deviceData = await deviceInfoPlugin.androidInfo;
          deviceIdentifier = deviceData.vendor + deviceData.userAgent + deviceData.hardwareConcurrency.toString();
        } else if (platform == TargetPlatform.iOS) {
          deviceData = await deviceInfoPlugin.iosInfo;
          deviceIdentifier = deviceData.vendor + deviceData.userAgent + deviceData.hardwareConcurrency.toString();
        }
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;
    setState(() {
      _deviceData = deviceData;
      _deviceIdentifier = deviceIdentifier;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //TODO: 1.login 2.sign up 3.home: link button 4.food list 5.calculate cal 6.calculate history/record 7.alert exceed cal (opt: add food)
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const WelcomePage(),
    );
  }

}
