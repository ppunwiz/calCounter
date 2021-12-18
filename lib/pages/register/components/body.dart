import 'package:cal_counter/components/already_have_acc.dart';
import 'package:cal_counter/components/rounded_buton.dart';
import 'package:cal_counter/components/rounded_input_field.dart';
import 'package:cal_counter/components/rounded_password_field.dart';
import 'package:cal_counter/model/user/user.dart';
import 'package:cal_counter/pages/login/login_page.dart';
import 'package:cal_counter/pages/register/components/social.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'background.dart';
import 'divider.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);
  @override
  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {

  DateTime _date = DateTime.now();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                if(mounted) setState(() {
                  emailController.text = value;
                });
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                if(mounted) setState(() {
                  passwordController.text = value;
                });
              },
            ),
            RoundedInputField(
              hintText: "Your Name",
              onChanged: (value) {
                if(mounted) setState(() {
                  nameController.text = value;
                });
              },
            ),
            RoundedInputField(
              hintText: "Your Gender",
              onChanged: (value) {
                if(mounted) setState(() {
                  genderController.text = value;
                });
              },
            ),
            buildDateFeildBirthdate(),
            RoundedButton(
              text: "SIGNUP",
              press: () {
                signUp();
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              },
            ),
            const OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocialIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocialIcon(
                  iconSrc: "assets/icons/google-plus.svg",
                  press: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  bool equalsIgnoreCase(String string1, String string2) {
    return string1?.toLowerCase() == string2?.toLowerCase();
  }

  signUp() {
    var uuid = Uuid();
    String id = uuid.v1();
    double maxCal = 2000;
    DateTime today = DateTime.now();
    final diff = today.difference(_date).inDays;
    if(equalsIgnoreCase("females", genderController.text)){
      if(diff > 18165) maxCal = 1600;
      else if(diff <= 18250) maxCal = 1800;
      else if(diff <= 10950) maxCal = 2000;
      else if(diff <= 6570) maxCal = 1800;
      else if(diff <= 4745) maxCal = 1600;
      else if(diff <= 2920) maxCal = 1400;
      else if(diff <= 1095) maxCal = 1000;
    }else{
      if(diff > 18165) maxCal = 2000;
      else if(diff <= 18250) maxCal = 2200;
      else if(diff <= 10950) maxCal = 2400;
      else if(diff <= 6570) maxCal = 2200;
      else if(diff <= 4745) maxCal = 1800;
      else if(diff <= 2920) maxCal = 1400;
      else if(diff <= 1095) maxCal = 1000;
    }
    User user = User(id: id, email: emailController.text, password: passwordController.text, name:  nameController.text,
    gender: genderController.text, birthdate: _date, maxKCal: maxCal);

    Box<User> userBox = Hive.box('users');
    userBox.put("user", user);
    print("saved user");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return LoginPage();
        },
      ),
    );
  }

  Container buildDateFeildBirthdate(){
    return Container(
        width: MediaQuery.of(context).size.width/1.25,
        color: Colors.grey[200],
        child: DateTimePicker(
          type: DateTimePickerType.date,
          dateMask: 'yyyy-MM-dd',
          initialValue: DateTime.now().toString(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
          icon: Icon(Icons.event),
          dateLabelText: 'Date',
          //timeLabelText: "Time",
          selectableDayPredicate: (date) {
            // Disable weekend days to select from the calendar
            if (date.weekday == 5 || date.weekday == 6) {
              return false;
            }

            return true;
          },
          onChanged: (val) => print(val),
          validator: (val) {
            print(val);
            return null;
          },
          onSaved: (val){
            if(val==null){
              _date = DateTime.now();
            }else{
              _date = DateTime.parse(val);
            }
          },
        ));
  }
}