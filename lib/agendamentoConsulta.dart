import 'package:flutter/material.dart';
import 'menu.dart';
import 'consultas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';

class UserPets {
  final String id;
  final String nome;
  final String especie;
  final String raca;
  final double idade;
  final double peso;
  final String sexo;
  final String observacao;
  UserPets(
      {this.id,
      this.nome,
      this.especie,
      this.raca,
      this.idade,
      this.peso,
      this.sexo,
      this.observacao});

  factory UserPets.fromJson(Map<String, dynamic> json) {
    return UserPets(
        id: json['_id'],
        nome: json['nome'],
        especie: json['especie'],
        raca: json['raca'],
        idade: json['idade'],
        peso: json['peso'],
        sexo: json['sexo'],
        observacao: json['observacao']);
  }
}

class SnackBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnackBar Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('SnackBar Demo'),
        ),
        body: AgendamentoConsultaPage(),
      ),
    );
  }
}

class Consulta {
  final data;
  final String pet;
  final String horario;
  final String observacao;

  Consulta({this.data, this.pet, this.horario, this.observacao});

  factory Consulta.fromJson(Map<String, dynamic> json) {
    return Consulta(
      data: json['data'],
      pet: json['pet'],
      horario: json['horario'],
      observacao: json['observacao'],
    );
  }
}

class AgendamentoConsulta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MeuAppScaffold(body: AgendamentoConsultaPage());
  }
}

class AgendamentoConsultaPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AgendamentoConsultaPageState();
  }
}

class AgendamentoConsultaPageState extends State<AgendamentoConsultaPage> {
  final snackBar = SnackBar(
      content: Text('Consulta agendada!'),
      backgroundColor: Color.fromRGBO(10, 140, 30, 1));
  final snackBar2 = SnackBar(
      content: Text('Erro no agendamento!'),
      backgroundColor: Color.fromRGBO(219, 13, 30, 1));
  final snackBar3 = SnackBar(
      content: Text('Pet encontrado!'),
      backgroundColor: Color.fromRGBO(10, 140, 30, 1));
  final snackBar4 = SnackBar(
      content: Text('Erro!'), backgroundColor: Color.fromRGBO(219, 13, 30, 1));
  var pets = [];
  int option = 1;
  String selectedPet;
  DateTime selectedDate;
  final dataController = TextEditingController();
  final emailController = TextEditingController();
  final horarioController = TextEditingController();
  final observacaoController = TextEditingController();
  Future<Consulta> _futureConsulta;
  Future<UserPets> _futurePets;
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/banner_consultas.png"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text('Agendar Consulta',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold)),
                      ]),
                      Padding(
                        //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                        padding: const EdgeInsets.only(
                            left: 25, right: 175, top: 10, bottom: 0),
                        child: TextFormField(
                          validator: (_) {
                            Pattern pattern =
                                r'^(0[1-9]|[12][0-9]|3[01])[- /.](0[1-9]|1[012])[- /.](19|20)\d\d$';
                            RegExp regex = new RegExp(pattern);
                            if (dataController.text == null ||
                                dataController.text.isEmpty) {
                              return 'Digite a data!';
                            } else if (!regex.hasMatch(dataController.text))
                              return 'Data inválida!';
                            else
                              return null;
                          },
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
                    child: TextFormField(
                      validator: (_) {
                        Pattern pattern =
                            r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$';
                        RegExp regex = new RegExp(pattern);
                        if (emailController.text == null ||
                            emailController.text.isEmpty) {
                          return 'Digite o email do dono do pet!';
                        } else if (!regex.hasMatch(emailController.text))
                          return 'Email inválido!';
                        else
                          return null;
                      },
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
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(children: [
                  SizedBox(
                    width: 50,
                  ),
                  Container(
                    height: 45,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(28, 88, 124, 1)),
                    child: FlatButton(
                      disabledColor: Color.fromRGBO(238, 238, 238, 1),
                      onPressed: () {
                        Pattern pattern =
                            r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$';
                        RegExp regex = new RegExp(pattern);
                        if (regex.hasMatch(emailController.text)) {
                          setState(() {
                            _futurePets = getPets(emailController.text);
                          });
                        }
                      },
                      child: Icon(
                        Icons.search,
                        color: Colors.blue,
                        size: 36.0,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 45,
                    decoration:
                        BoxDecoration(color: Color.fromRGBO(28, 88, 124, 1)),
                    child: FlatButton(
                      disabledColor: Color.fromRGBO(238, 238, 238, 1),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _futureConsulta = createConsulta(
                                dataController.text,
                                selectedPet,
                                horarioController.text,
                                observacaoController.text);
                          });
                        }
                      },
                      child: Icon(
                        Icons.clear,
                        color: Colors.blue,
                        size: 36.0,
                      ),
                    ),
                  ),
                ]),
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
                            style:
                                TextStyle(color: Colors.black, fontSize: 16)),
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
                        items: pets.map<DropdownMenuItem<String>>((value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                ]),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 10, bottom: 0),
                  child: TextFormField(
                    validator: (_) {
                      Pattern pattern =
                          r'^(0?[1-9]|1[0-2]):([0-5]\d)\s?((?:A|P)\.?M\.?)$';
                      RegExp regex = new RegExp(pattern);
                      if (horarioController.text == null ||
                          horarioController.text.isEmpty) {
                        return 'Digite o horário da consulta!';
                      } else if (!regex.hasMatch(horarioController.text))
                        return 'Horário inválido!';
                      else
                        return null;
                    },
                    controller: horarioController,
                    style: TextStyle(
                      height: 0.75,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        fillColor: Color.fromRGBO(255, 255, 255, 0.85),
                        filled: true,
                        labelText: 'Horário',
                        hintText: 'HH:MM AM/PM',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 0, bottom: 0),
                  child: TextField(
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
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            _futureConsulta = createConsulta(
                                dataController.text,
                                selectedPet,
                                horarioController.text,
                                observacaoController.text);
                          });
                        }
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
                            MaterialPageRoute(builder: (_) => ConsultaPet()));
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
      ),
    );
  }

  Future<Consulta> createConsulta(data, pet, horario, observacao) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.get('user');
    var expressUser = jsonDecode(user)['express'];
    var crmv = expressUser[0]['crmv'];
    final response = await http.post(
      Uri.parse('http://localhost:5000/consultas/agendamento'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'data': data,
        'pet': pet,
        'horario': horario,
        'observacao': observacao,
        'crmv': crmv
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
    }
  }

  Future<UserPets> getPets(email) async {
    log(email);
    final response = await http.get(
      Uri.parse('http://localhost:5000/pets/${email}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    log(response.body);
    var express = jsonDecode(response.body)['express'];
    pets = express;
    if (response.statusCode == 200) {
      if (response.body == jsonEncode(<String, List>{'express': []})) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar4);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(snackBar3);
      }
      return UserPets.fromJson(jsonDecode(response.body));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar4);
      return null;
    }
  }
}
