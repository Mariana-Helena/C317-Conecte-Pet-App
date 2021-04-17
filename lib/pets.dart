import 'package:flutter/material.dart';
import 'menu.dart';
import 'vacinas.dart'; //para testar

class Pets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MeuAppScaffold(body: PetsPage());
  }
}

class PetsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PetsPageState();
  }
}

class PetsPageState extends State<PetsPage> {
  final pets = ['1', '2', '3', '4'];
  bool openDialog = false;
  String selectedPet;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: openDialog ? Colors.grey : Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Row(children: [
                SizedBox(
                  width: 10,
                ),
                Text('Pets cadastrados',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        color: Color.fromRGBO(28, 88, 124, 1),
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
              ]),
              openDialog
                  ? Center(
                      child: AlertDialog(
                        title: Text('Nome $selectedPet',
                            style: TextStyle(
                                color: Color.fromRGBO(28, 88, 124, 1),
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text('Espécie:', style: TextStyle(fontSize: 18)),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Raça:', style: TextStyle(fontSize: 18)),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Sexo:', style: TextStyle(fontSize: 18)),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Idade:', style: TextStyle(fontSize: 18)),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Peso:', style: TextStyle(fontSize: 18)),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Observações:',
                                  style: TextStyle(fontSize: 18)),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Fechar',
                                style: TextStyle(
                                    color: Color.fromRGBO(28, 88, 124, 1),
                                    fontSize: 15)),
                            onPressed: () {
                              setState(() {
                                openDialog = false;
                                //selectedPet=null;
                              });
                            },
                          ),
                        ],
                      ),
                    )
                  : GridView.count(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: <Widget>[
                        for (var item in pets)
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle),
                                ),
                                onTap: () {
                                  setState(() {
                                    openDialog = true;
                                    selectedPet = item;
                                  });
                                }),
                          ),
                      ],
                    ),
              openDialog
                  ? Container()
                  : Container(
                      height: 60,
                      width: 250,
                      decoration:
                          BoxDecoration(color: Color.fromRGBO(28, 88, 124, 1)),
                      child: FlatButton(
                        disabledColor: Color.fromRGBO(238, 238, 238, 1),
                        onPressed: openDialog
                            ? null
                            : () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => Vacinas()));
                                //para testar
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
