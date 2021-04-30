import 'package:flutter/material.dart';
import 'menu.dart';
import 'vacinas.dart'; //para testar
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

Future<Vacina> createVacina(
    data, pet_id, vacina, fabricante, numero, observacao) async {
  String tipo;
  if (numero == 1)
    tipo = 'aplicada';
  else
    tipo = 'agendada';
  final response = await http.post(
    Uri.parse('http://localhost:5000/vacinas/registro'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'data': data,
      'pet_id': pet_id,
      'vacina': vacina,
      'fabricante': fabricante,
      'tipo': tipo,
      'observacao': observacao
    }),
  );

  if (response.statusCode == 200) {
    log('Sucesso!');
  } else {
    throw Exception('Erro ao registrar a vacina.');
  }
}

class Vacina {
  final data;
  final String pet_id;
  final String vacina;
  final String fabricante;
  final String tipo;
  final String observacao;

  Vacina(
      {this.data,
      this.pet_id,
      this.vacina,
      this.fabricante,
      this.tipo,
      this.observacao});

  factory Vacina.fromJson(Map<String, dynamic> json) {
    return Vacina(
      data: json['data'],
      pet_id: json['pet_id'],
      vacina: json['vacina'],
      fabricante: json['fabricante'],
      tipo: json['tipo'],
      observacao: json['observacao'],
    );
  }
}

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
  int option = 1;
  String selectedPet;
  DateTime selectedDate;

  final dataController = TextEditingController();
  final emailController = TextEditingController();
  final vacinaController = TextEditingController();
  final fabricanteController = TextEditingController();
  final observacaoController = TextEditingController();
  Future<Vacina> _futureVacina;
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

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
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: Column(
                  children: [
                    Row(children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text('Registrar vacina',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold)),
                    ]),
                    Padding(
                      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                      padding: const EdgeInsets.only(
                          left: 25, right: 175, top: 10, bottom: 0),
                      child: TextField(
                        controller: dataController,
                        style: TextStyle(
                          height: 0.75,
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            fillColor: Color.fromRGBO(255, 255, 255, 0.85),
                            filled: true,
                            hintText: 'DD/MM/YYYY',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 10, bottom: 0),
                child: TextField(
                  controller: emailController,
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
              SizedBox(
                height: 10,
              ),
              Row(children: [
                SizedBox(width: 25),
                SizedBox(
                  width: 310,
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 5, top: 0, bottom: 0),
                    decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1, style: BorderStyle.solid))),
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text('Pet',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(color: Colors.black, fontSize: 16)),
                      value: selectedPet,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      underline: SizedBox.shrink(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedPet = newValue;
                        });
                      },
                      items: <String>['One', 'Two', 'Three', 'Four']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ]),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 10, bottom: 0),
                child: TextField(
                  controller: vacinaController,
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
                  controller: fabricanteController,
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
                      activeColor: Color.fromRGBO(28, 88, 124, 1),
                      groupValue: option,
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
                      activeColor: Color.fromRGBO(28, 88, 124, 1),
                      groupValue: option,
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
                    left: 25, right: 25, top: 0, bottom: 0),
                child: TextField(
                  controller: observacaoController,
                  minLines: 1,
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
                height: 15,
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
                      setState(() {
                        _futureVacina = createVacina(
                            dataController.text,
                            selectedPet,
                            vacinaController.text,
                            fabricanteController.text,
                            option,
                            observacaoController.text);
                      });
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
                      BoxDecoration(color: Color.fromRGBO(122, 150, 172, 1)),
                  child: FlatButton(
                    disabledColor: Color.fromRGBO(238, 238, 238, 1),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => VacinasPet()));
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
