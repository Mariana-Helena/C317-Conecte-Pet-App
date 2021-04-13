import 'package:flutter/material.dart';
import 'menu.dart';

class Pets extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MeuAppScaffold(
        body: PetsPage());
  }
}

class PetsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return PetsPageState();
  }
}

class PetsPageState extends State<PetsPage>{
  final pets = ['1','2','3','4'];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body:
      SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(

                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text('Pets cadastrados',

                    textDirection: TextDirection.ltr,
                    style: TextStyle(color: Color.fromRGBO(28, 88, 124, 1),
                        fontSize: 28, fontWeight: FontWeight.bold)
                ),]

              ),
              GridView.count(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                primary: false,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: <Widget>[
                      for(var item in pets )
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle
                              ),
                              ),

                        ),
                    ],
                  ),


              Container(
                height: 60,
                width: 250,
                decoration: BoxDecoration(

                    border: Border.all(color: Colors.white),
                    color: Color.fromRGBO(28, 88, 124, 1)),
                child: FlatButton(
                  onPressed: () {
                    /*Navigator.push(
                        context, MaterialPageRoute(builder: (_) => PetsCadastro()));
                  */
                  },
                  child: Text(
                    'Cadastrar novo pet',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),

            ],
          ),
        ),
        ),

    );
  }
}


