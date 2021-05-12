import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'agendamentoConsulta.dart';
import 'menu.dart';
import 'vacinasRegistro.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class ConsultasPet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MeuAppScaffold(body: ConsultasPetPage());
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

class ConsultasPets {
  final String id;
  final String nomePet;
  final String emailDono;
  final String data;
  final String horario;
  final String observacao;
  final String crmv;
  ConsultasPets({this.id,this.nomePet, this.emailDono, this.data, this.horario, this.observacao, this.crmv});

  factory ConsultasPets.fromJson(Map<String, dynamic> json) {
    return ConsultasPets(
        id: json['_id'],
        nomePet: json['pet']['nome'],
        emailDono: json['pet']['dono'],
        data: json['data'],
        horario: json['horario'],
        observacao: json['observacao'],
        crmv: json['crmv']
    );
  }
}

class ConsultasPetPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return ConsultasPetPageState();
  }
}

class ConsultasPetPageState extends State<ConsultasPetPage> {

  var pets = [];
  var consultas = [];
  bool openDialog = false;
  String selectedPetId;
  String selectedPetNome;
  String selectedDonoEmail;
  var selectedData = new List();
  var selectedHorario= new List();
  var selectedCRMV = new List();
  var selectedPetObs = new List();

  String selectedPetIdPet;

  Future<UserPets> _futureLogin;
  Future<ConsultasPets> _futureLogin2;

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
                Text('Consultas dos Pets',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        color: Color.fromRGBO(28, 88, 124, 1),
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
              ]),
              openDialog
                  ? Container(
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
                                for(var i=0;i<selectedData.length;i++)
                                  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children:[
                                        Container(
                                          height: 20,
                                          child: Text('Data: ${selectedData[i]}', style: TextStyle(fontSize: 15),textAlign: TextAlign.left),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: 20,
                                          child: Text('Tipo: ${selectedHorario[i]}', style: TextStyle(fontSize: 15), textAlign: TextAlign.left),
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
                                            height: 40,
                                            child: Row(
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
                                                        child: Text("Continuar"),
                                                        onPressed:  () {},
                                                      );
                                                      //configura o AlertDialog
                                                      AlertDialog alert = AlertDialog(
                                                        title: Text("Excluir vacina"),
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
                                                )],
                                            )),
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
                          selectedData.clear();
                          selectedHorario.clear();
                          selectedCRMV.clear();
                          selectedPetObs.clear();
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
                          child: ClipOval(
                            child: Image.memory(item['foto'], height: 100.0,
                                width: 100.0,fit: BoxFit.cover),
                          ),
                          onTap: () {
                            setState(() {
                              if (pets.length != 0)
                              {
                                if (item['nome'] != null){
                                  getConsultas(item['_id']);
                                }
                              }
                              openDialog = true;
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
                            builder: (_) => AgendamentoConsulta()));
                  },
                  child: Text(
                    'Registrar consulta',
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
    setState(() {
      pets = express;
      for (var item in pets) {
        var url = item['foto'];
        item['foto'] = base64.decode(url.split(',').last);
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

  Future<ConsultasPets> getConsultas(idPet) async {
    log('loading...');
    final response = await http.get(
      Uri.parse('http://localhost:5000/consultas/${idPet}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    log(response.body);
    var express = jsonDecode(response.body)['express'];
    setState(() {
      consultas = express;
      for (var item2 in consultas)
        if (consultas.length != 0) {
          selectedPetId = item2['_id'];
          selectedPetNome = item2['pet']['nome'];
          selectedDonoEmail = item2['pet']['dono'];
          selectedData.add(item2['data']);
          selectedHorario.add(item2['horario']);
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
      return ConsultasPets.fromJson(jsonDecode(response.body));
    } else {
      //ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

