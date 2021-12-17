import 'package:flutter/material.dart';

import 'home/home_page.dart';

class CaloriesPage extends StatelessWidget {
  const CaloriesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size;
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
              const Text("Calories Limit"),
              const Spacer(),
            ]
        ),
        backgroundColor: Colors.indigo[900],
        elevation: 0.0,

      ),
      //********************end app bar*****************************//,
      body:  LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(

                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/table.jpg", height: size.height*0.5,width: size.width*4,),
                        ])
                ));}
      ),
    );
  }
}
