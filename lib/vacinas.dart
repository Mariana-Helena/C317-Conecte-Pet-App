import 'package:flutter/material.dart';
import 'menu.dart';
import 'vacinasRegistro.dart';

class VacinasPet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MeuAppScaffold(body: VacinasPetPage());
  }
}

class VacinasPetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VacinasPetPageState();
  }
}

class VacinasPetPageState extends State<VacinasPetPage> {
  final pets = ['Pet1', 'Pet2', 'Pet3', 'Pet4'];
  bool openDialog = false;
  String selectedPet;
  var ehvet = false;
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
                Text('Vacinação dos Pets',
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
                        Text('Vacina:', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Fabricante:', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Aplicação:', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Próx. Aplicação:', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Veterinário:', style: TextStyle(fontSize: 18)),
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
                                    title: Text("Excluir vacina"),
                                    content: Text("Deseja mesmo excluir essa vacina ?"),
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
                        Text('Vacina2:', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Fabricante:', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Aplicação:', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Próx. Aplicação:', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Veterinário:', style: TextStyle(fontSize: 18)),
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
                                    title: Text("Excluir vacina"),
                                    content: Text("Deseja mesmo excluir essa vacina ?"),
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
              Container(
                height: 60,
                width: 100,
                decoration:
                BoxDecoration(color: Color.fromRGBO(28, 88, 124, 1)),
                child: FlatButton(
                  disabledColor: Color.fromRGBO(238, 238, 238, 1),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => VacinasRegistro()));
                  },
                  child: Text(
                    'Registrar Vacina',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
