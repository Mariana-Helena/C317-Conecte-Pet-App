import 'package:flutter/material.dart';
import 'menu.dart';

class Consultas extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MeuAppScaffold(
        body: HomePage());
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
                child: Text('consultas',
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
