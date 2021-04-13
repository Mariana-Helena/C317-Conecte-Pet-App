import 'package:flutter/material.dart';
import 'menu.dart';

class Pets extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MeuAppScaffold(
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget> [],
          ),
        ));
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>{
  int counter = 0;
  @override
  Widget build(BuildContext context){
    return Container(
        child: Center (
            child: GestureDetector(
                child: Text('$counter',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(color: Colors.green, fontSize: 50)
                ),
                onTap: (){
                  setState(() {
                    counter++;
                  });

                }
            )
        )

    );
  }
}
