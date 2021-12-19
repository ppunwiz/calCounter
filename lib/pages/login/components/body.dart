import 'package:cal_counter/components/already_have_acc.dart';
import 'package:cal_counter/components/rounded_buton.dart';
import 'package:cal_counter/components/rounded_input_field.dart';
import 'package:cal_counter/components/rounded_password_field.dart';
import 'package:cal_counter/model/isLogin/is_login.dart';
import 'package:cal_counter/model/user/user.dart';
import 'package:cal_counter/pages/home/home_page.dart';
import 'package:cal_counter/pages/register/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'background.dart';
import '../../../globals.dart' as globals;

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  BodyState createState() => BodyState();
}

class BodyState extends State<Body> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            // SvgPicture.asset(
            //   "assets/icons/logo.svg",
            //   height: size.height * 0.35,
            // ),
            Image.asset( "assets/icons/logo.jpg", height: size.height*0.2,),
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
              onChanged: (value) {
                if(mounted) {
                  emailController.text = value;
                }
              },
            ),
            RoundedPasswordField(
              onChanged: (value) {
                if(mounted) {
                  passwordController.text = value;
                }
              },
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                login();
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SignUpPage();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  bool validatePassword(String input, String password){
    if(input == password) return true;
    return false;
  }

  Widget popUp(){
    return AlertDialog(
        title: const Text("Invalid email or password!"),
        content: const Text("your email or password is invalid"),
        actions: [
          FlatButton(textColor: const Color(0xFF6200EE),
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("ok"),),
        ]
    );
  }

  login() {
    Box<User> userBox = Hive.box('users');
    User user = userBox.get(emailController.text);
    if(user!=null){
      if( validatePassword(passwordController.text, user.password) == false) {
        if(mounted) {
          setState(() {
            var confirm = popUp();
            showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) => confirm);
          });
        }
      }
    }else {
      if(mounted) {
        setState(() {
          var confirm = popUp();
          showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) => confirm);
        });
      }
    }

    Box<isLogin> isLoginBox = Hive.box('isLogin');
    isLogin login = isLogin();
    if(isLoginBox.get(globals.deviceId) != null) {
      login = isLoginBox.get(user.id);
      login.deviceId = globals.deviceId;
      login.login = true;
      login.userId = user.id;
      isLoginBox.delete(globals.deviceId);
      isLoginBox.put(globals.deviceId, login);
    }else{
      login.deviceId = globals.deviceId;
      login.login = true;
      login.userId = user.id;
      isLoginBox.put(globals.deviceId, login);
    }

    globals.userId = user.id;
    globals.email = emailController.text;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const HomePage();
        },
      ),
    );

  }
}
