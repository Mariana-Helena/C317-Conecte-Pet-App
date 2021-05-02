import 'package:flutter/material.dart';
import 'menu.dart';
import 'vacinas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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
        body: VacinasRegistroPage(),
      ),
    );
  }
}

class Vacina {
  final data;
  final String pet;
  final String vacina;
  final String fabricante;
  final String tipo;
  final String observacao;

  Vacina(
      {this.data,
      this.pet,
      this.vacina,
      this.fabricante,
      this.tipo,
      this.observacao});

  factory Vacina.fromJson(Map<String, dynamic> json) {
    return Vacina(
      data: json['data'],
      pet: json['pet'],
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
  final snackBar = SnackBar(
      content: Text('Vacinação registrada!'),
      backgroundColor: Color.fromRGBO(10, 140, 30, 1));
  final snackBar2 = SnackBar(
      content: Text('Erro no registro!'),
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
  final vacinaController = TextEditingController();
  final fabricanteController = TextEditingController();
  final observacaoController = TextEditingController();
  Future<Vacina> _futureVacina;
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
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 10, bottom: 0),
                  child: TextFormField(
                    readOnly: pets.length!=0? true : false,
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
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(children: [
                  SizedBox(
                    width: 25,
                  ),
                  Container(
                    height: 40,
                    width: 150,
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
                    height: 40,
                    width: 150,
                    decoration:
                    BoxDecoration(color: Color.fromRGBO(28, 88, 124, 1)),
                    child: FlatButton(
                      disabledColor: Color.fromRGBO(238, 238, 238, 1),
                      onPressed: () {
                        setState(() {
                          selectedPet = null;
                          emailController.text = '';
                          pets = [];
                        });
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
                        items: pets.map((item) {
                          return new DropdownMenuItem(
                            child: new Text(item['nome']),
                            value: item['_id'].toString(),
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
                  child: TextFormField(
                    validator: (_) {
                      if (vacinaController.text == null ||
                          vacinaController.text.isEmpty) {
                        return 'Digite o nome da vacina!';
                      }
                      return null;
                    },
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
                  child: TextFormField(
                    validator: (_) {
                      if (fabricanteController.text == null ||
                          fabricanteController.text.isEmpty) {
                        return 'Digite o nome do fabricante!';
                      }
                      return null;
                    },
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
                    width: 25,
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
                            _futureVacina = createVacina(
                                dataController.text,
                                selectedPet,
                                vacinaController.text,
                                fabricanteController.text,
                                option,
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
      ),
    );
  }

  Future<Vacina> createVacina(
      data, pet_id, vacina, fabricante, numero, observacao) async {
    var pet = pets.firstWhere((pet) => pet['_id'] == pet_id);
    var petJson = {'id': pet['_id'], 'nome': pet['nome'], 'dono': pet['usuario']};
    String tipo;
    if (numero == 1)
      tipo = 'aplicada';
    else
      tipo = 'agendada';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.get('user');
    var expressUser = jsonDecode(user)['express'];
    var crmv = expressUser[0]['crmv'];
    final response = await http.post(
      Uri.parse('http://localhost:5000/vacinas/registro'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'data': data,
        'pet': petJson,
        'vacina': vacina,
        'fabricante': fabricante,
        'tipo': tipo,
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
    final response = await http.get(
      Uri.parse('http://localhost:5000/pets/${email}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    var express = jsonDecode(response.body)['express'];

    setState(() {
      pets = express;
    });
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
