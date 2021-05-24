import 'package:flutter/material.dart';
import 'vetVacinas.dart';
import 'menu.dart';
import 'vacinasRegistro.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class VacinasPet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MeuAppScaffold(body: VacinasPetPage());
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

class VacinasPets {
  final String id;
  final String nomePet;
  final String emailDono;
  final String fabricante;
  final double vacina;
  final double data;
  final String tipo;
  final String observacao;
  final String crmv;
  VacinasPets({this.id,this.nomePet, this.emailDono, this.fabricante, this.vacina, this.data, this.tipo, this.observacao, this.crmv});

  factory VacinasPets.fromJson(Map<String, dynamic> json) {
    return VacinasPets(
        id: json['_id'],
        nomePet: json['pet']['nome'],
        emailDono: json['pet']['dono'],
        fabricante: json['fabricante'],
        vacina: json['vacina'],
        data: json['data'],
        tipo: json['tipo'],
        observacao: json['observacao'],
        crmv: json['crmv']
    );
  }
}

class VacinasPetPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return VacinasPetPageState();
  }
}

class VacinasPetPageState extends State<VacinasPetPage> {

  var pets = [];
  var vacinas = [];
  var ehvet = false;
  bool openDialog = false;
  var selectedPetId = new List();
  String selectedPetNome;
  String selectedDonoEmail;
  var selectedFabricante = new List();
  var selectedVacina = new List();
  var selectedData = new List();
  var selectedTipo = new List();
  var selectedCRMV = new List();
  var selectedPetObs = new List();

  String selectedPetIdPet;

  Future<UserPets> _futureLogin;
  Future<VacinasPets> _futureLogin2;

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
                Text('Vacinas dos Pets',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        color: Color.fromRGBO(28, 88, 124, 1),
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 50,
                ),
              ]),
              openDialog
                  ? SizedBox(
                // width: 100,
                // height: 100,
                child: AlertDialog(
                  title: Text('$selectedPetNome',
                      style: TextStyle(
                          color: Color.fromRGBO(28, 88, 124, 1),
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                  content: CustomScrollView(
                    shrinkWrap: true,
                    slivers: <Widget>[
                      SliverPadding(
                        padding: const EdgeInsets.all(20.0),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate(
                            <Widget>[
                              for(var i=0;i<selectedFabricante.length;i++)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                    children:[
                                  // height: 20,
                                  Container(
                                    height: 20,
                                    child: Text('Fabricante: ${selectedFabricante[i]}', style: TextStyle(fontSize: 15),textAlign: TextAlign.left),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 20,
                                    child: Text('Vacina: ${selectedVacina[i]}', style: TextStyle(fontSize: 15),textAlign: TextAlign.left),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 20,
                                    child: Text('Data: ${selectedData[i]}', style: TextStyle(fontSize: 15),textAlign: TextAlign.left),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 20,
                                    child: Text('Tipo: ${selectedTipo[i]}', style: TextStyle(fontSize: 15), textAlign: TextAlign.left),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 20,
                                    child: Text('Veterinário: ${selectedCRMV[i]} ', style: TextStyle(fontSize: 15),textAlign: TextAlign.left),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    height: 20,
                                    child: Text('Observação: ${selectedPetObs[i]}', style: TextStyle(fontSize: 15),textAlign: TextAlign.left),
                                  ),
                                  Container(
                                    height: 10,
                                  ),
                            ]),
                          ]),
                        ),
                      ),
                    ],
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
                          selectedFabricante.clear();
                          selectedData.clear();
                          selectedVacina.clear();
                          selectedTipo.clear();
                          selectedCRMV.clear();
                          selectedPetObs.clear();
                        });
                      },
                    ),
                  ],
                ),
              )
                  :
              ehvet?
                Container(
                child: Column(
                children: <Widget>[
                  Container(
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
                                builder: (_) => VetVacinasPet()));
                      },
                      child: Text(
                        'Visualizar vacinas',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
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
                      builder: (_) => VacinasRegistro()));
                      },
                      child: Text(
                      'Registrar vacina',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    ]
                    ))
                  :
                GridView.count(
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
                          child: ClipOval(
                            child: Image.memory(item['foto'], height: 100.0,
                                width: 100.0,fit: BoxFit.cover),
                          ),
                          onTap: () {
                            setState(() {
                              if (pets.length != 0)
                              {
                                if (item['nome'] != null){
                                  getVacinas(item['_id']);
                                    }
                                }
                                openDialog = true;
                            });
                          }),
                    ),
                ],
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
    var ehveterinario = expressUser[0]['ehveterinario'];
    final response = await http.get(
      Uri.parse('http://localhost:5000/pets/${email}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    log(response.body);
    var express = jsonDecode(response.body)['express'];
    setState(() {
      pets = express;
      for (var item in pets) {
        var url = item['foto'];
        item['foto'] = base64.decode(url.split(',').last);
      }
      if (ehveterinario){
        ehvet = true;
      }
    });

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

Future<VacinasPets> getVacinas(idPet) async {
  log('loading...');
  final response = await http.get(
    Uri.parse('http://localhost:5000/vacinas/${idPet}'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  log(response.body);
  var express = jsonDecode(response.body)['express'];
  setState(() {
    vacinas = express;
    for (var item2 in vacinas)
      if (vacinas.length != 0) {
        selectedPetId.add(item2['_id']);
        selectedPetNome = item2['pet']['nome'];
        selectedDonoEmail = item2['pet']['dono'];
        selectedFabricante.add(item2['fabricante']);
        selectedVacina.add(item2['vacina']);
        selectedData.add(item2['data']);
        selectedTipo.add(item2['tipo']);
        selectedCRMV.add(item2['crmv']);
        selectedPetObs.add(item2['observacao']);
        log(selectedPetNome);
      }
  });

  if (response.statusCode == 200) {
    if (response.body == jsonEncode(<String, List>{'express': []})) {
      //encontrado

    } else {
      //não encontrado
    }
    return VacinasPets.fromJson(jsonDecode(response.body));
  } else {
    //ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

}

