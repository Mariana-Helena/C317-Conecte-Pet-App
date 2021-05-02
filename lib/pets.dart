import 'package:flutter/material.dart';
import 'menu.dart';
import 'cadastroPet.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class Pets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MeuAppScaffold(body: PetsPage());
  }
}

class UserPets {
  final String id;
  final String nome;
  final String especie;
  final String raca;
  final double idade;
  final double peso;
  final String sexo;
  final String observacao;
  UserPets({this.id, this.nome, this.especie, this.raca, this.idade, this.peso, this.sexo, this.observacao});

  factory UserPets.fromJson(Map<String, dynamic> json) {
    return UserPets(
      id: json['_id'],
      nome: json['nome'],
      especie: json['especie'],
      raca: json['raca'],
      idade: json['idade'],
      peso: json['peso'],
      sexo: json['sexo'],
      observacao: json['observacao']

    );
  }
}

class PetsPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return PetsPageState();
  }
}

class PetsPageState extends State<PetsPage> {

  var pets = [];
  bool openDialog = false;
  String selectedPetId;
  String selectedPetNome;
  String selectedPetEspecie;
  String selectedPetRaca;
  String selectedPetSexo;
  String selectedPetIdade;
  String selectedPetPeso;
  String selectedPetObs;
  Future<UserPets> _futureLogin;

  @override
  void initState() {
    _futureLogin = getPets();
  }

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
                  title: Text('$selectedPetNome',
                      style: TextStyle(
                          color: Color.fromRGBO(28, 88, 124, 1),
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text('Espécie: $selectedPetEspecie', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Raça: $selectedPetRaca', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Sexo: $selectedPetSexo', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Idade: $selectedPetIdade anos', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Peso: $selectedPetPeso kg', style: TextStyle(fontSize: 18)),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Observação: $selectedPetObs',
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
                              if (pets.length != 0)
                              {
                                selectedPetId = item['_id'];
                                selectedPetNome = item['nome'];
                                selectedPetEspecie = item['especie'];
                                selectedPetRaca = item['raca'];
                                selectedPetSexo = item['sexo'];
                                selectedPetIdade = item['idade'];
                                selectedPetPeso = item['peso'];
                                selectedPetObs = item['observacao'];
                              }

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
                            builder: (_) => CadastroPet()));
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
  Future<UserPets> getPets() async {
    log('loading...');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.get('user');
    var expressUser = jsonDecode(user)['express'];
    var email = expressUser[0]['email'];
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
        //encontrado

      } else {
        //não encontrado
      }
      return UserPets.fromJson(jsonDecode(response.body));
    } else {
      //ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}