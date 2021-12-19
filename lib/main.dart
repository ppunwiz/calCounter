import 'dart:async';
import 'package:cal_counter/model/calories/calories.dart';
import 'package:cal_counter/model/food/food.dart';
import 'package:cal_counter/model/record/record.dart';
import 'package:cal_counter/model/user/user.dart';
import 'package:cal_counter/pages/home/home_page.dart';
import 'package:cal_counter/pages/welcome/welcome_page.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'constant.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'model/isLogin/is_login.dart';
import './globals.dart' as globals;

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();

  return directory.path;
}

void main() async{

  Hive.registerAdapter(FoodAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(CaloriesAdapter());
  Hive.registerAdapter(RecordAdapter());
  Hive.registerAdapter(isLoginAdapter());

  WidgetsFlutterBinding.ensureInitialized();
  Hive.init(await _localPath);

  await Hive.openBox<Food>('foods');
  await Hive.openBox<User>('users');
  await Hive.openBox<Calories>('calories');
  await Hive.openBox<Record>('records');
  await Hive.openBox<isLogin>('isLogin');

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
    var platform = Theme.of(context).platform;

    try {
      if (kIsWeb) {
        var deviceData = await deviceInfoPlugin.webBrowserInfo;
        deviceIdentifier = deviceData.vendor + deviceData.userAgent + deviceData.hardwareConcurrency.toString();
      } else {
        if (platform == TargetPlatform.android) {
          var deviceData = await deviceInfoPlugin.androidInfo;
          deviceIdentifier = deviceData.androidId;
        } else if (platform == TargetPlatform.iOS) {
          var deviceData = await deviceInfoPlugin.iosInfo;
          deviceIdentifier = deviceData.identifierForVendor;
        }
      }
    } on PlatformException {
      var deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
      print(deviceData);
      throw deviceData;
    }

    if (mounted) {
      setState(() {
        _deviceIdentifier = deviceIdentifier;
      });
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("device_id: "+_deviceIdentifier.toString());
    globals.deviceId = _deviceIdentifier;
    return MaterialApp(
      //TODO: 1.login 2.sign up 3.home: link button 4.food list 5.calculate cal 6.calculate history/record 7.alert exceed cal (opt: add food)
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: checkLogin(),
    );
  }

  Widget checkLogin() {
    Box<isLogin> isLoginBox = Hive.box('isLogin');
    if(isLoginBox.get(_deviceIdentifier) != null){
      isLogin login = isLoginBox.get(_deviceIdentifier);
      if(login.login == true) return HomePage();
    }
    return WelcomePage();
  }

}
