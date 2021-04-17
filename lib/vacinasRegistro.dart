import 'package:flutter/material.dart';
import 'menu.dart';
import 'vacinas.dart'; //para testar

class VacinasRegistro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MeuAppScaffold(body: VacinasRegistroPage());
  }
}

class VacinasRegistroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return VacinasRegistroPageState();
  }
}

class VacinasRegistroPageState extends State<VacinasRegistroPage> {
  final pets = ['1', '2', '3', '4'];
  int option;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/banner_vacinacao.png"),
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Row(children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text('Registrar vacina',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                ]),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 10, bottom: 0),
                child: TextField(
                  style: TextStyle(
                    height: 0.75,
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      fillColor: Color.fromRGBO(255, 255, 255, 0.85),
                      filled: true,
                      labelText: 'Email do dono do pet',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      )),
                ),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 10, bottom: 0),
                child: TextField(
                  style: TextStyle(
                    height: 0.75,
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      fillColor: Color.fromRGBO(255, 255, 255, 0.85),
                      filled: true,
                      labelText: 'Pet',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      )),
                ),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 10, bottom: 0),
                child: TextField(
                  style: TextStyle(
                    height: 0.75,
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      fillColor: Color.fromRGBO(255, 255, 255, 0.85),
                      filled: true,
                      labelText: 'Vacina',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      )),
                ),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 10, bottom: 0),
                child: TextField(
                  style: TextStyle(
                    height: 0.75,
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      fillColor: Color.fromRGBO(255, 255, 255, 0.85),
                      filled: true,
                      labelText: 'Fabricante',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      )),
                ),
              ),
              Column(
                children: <Widget>[
                  ListTile(
                    title: const Text('Vacina aplicada'),
                    leading: Radio(
                      value: 1,
                      onChanged: (value) {
                        setState(() {
                          option = 1;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Vacina agendada'),
                    leading: Radio(
                      value: 2,
                      onChanged: (value) {
                        setState(() {
                          option = 2;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 10, bottom: 0),
                child: TextField(
                  minLines: 3,
                  maxLines: 6,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(
                    height: 1.75,
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      fillColor: Color.fromRGBO(255, 255, 255, 0.85),
                      filled: true,
                      labelText: 'Observações:',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(children: [
                SizedBox(
                  width: 50,
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
                          MaterialPageRoute(builder: (_) => Vacinas()));
                    },
                    child: Text(
                      'Cadastrar',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
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
                          MaterialPageRoute(builder: (_) => Vacinas()));
                      //para testar
                    },
                    child: Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ]),
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
