import 'package:flutter/material.dart';
import 'menu.dart';
import 'cadastroPet.dart'; //para testar

class ConsultaPet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MeuAppScaffold(body: ConsultaPetPage());
  }
}

class ConsultaPetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ConsultaPetPageState();
  }
}

class ConsultaPetPageState extends State<ConsultaPetPage> {
  final pets = ['Pet1', 'Pet2', 'Pet3', 'Pet4'];
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
                Text('Consultas dos Pets',
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
                        Text('Data da Consulta:', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Veterinário:', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Retorno:', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Observações:', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FloatingActionButton(
                                mini: true,
                                backgroundColor: Color.fromRGBO(28, 88, 124, 1),
                                child: Icon(Icons.delete),
                                onPressed: () {
                                  Widget cancelaButton = FlatButton(
                                    child: Text("Cancelar"),
                                    onPressed:  () {},
                                  );
                                  Widget continuaButton = FlatButton(
                                    child: Text("Continar"),
                                    onPressed:  () {},
                                  );
                                  //configura o AlertDialog
                                  AlertDialog alert = AlertDialog(
                                    title: Text("Excluir consulta"),
                                    content: Text("Deseja mesmo excluir essa consulta ?"),
                                    actions: [
                                      cancelaButton,
                                      continuaButton,
                                    ],
                                  );
                                  //exibe o diálogo
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );
                                }
                            ),
                          ],
                        ),
                        Text('Data da Consulta2:', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Veterinário:', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Retorno:', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Observações:', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FloatingActionButton(
                                mini: true,
                                backgroundColor: Color.fromRGBO(28, 88, 124, 1),
                                child: Icon(Icons.delete),
                                onPressed: () {
                                  Widget cancelaButton = FlatButton(
                                    child: Text("Cancelar"),
                                    onPressed:  () {},
                                  );
                                  Widget continuaButton = FlatButton(
                                    child: Text("Continar"),
                                    onPressed:  () {},
                                  );
                                  //configura o AlertDialog
                                  AlertDialog alert = AlertDialog(
                                    title: Text("Excluir consulta"),
                                    content: Text("Deseja mesmo excluir essa consulta ?"),
                                    actions: [
                                      cancelaButton,
                                      continuaButton,
                                    ],
                                  );
                                  //exibe o diálogo
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return alert;
                                    },
                                  );
                              }
                            ),

                          ],
                        ),
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
