import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'menu.dart';
import 'consultas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class VetConsultasPet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MeuAppScaffold(body: VetConsultasPetPage());
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


class VetConsultasPetPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return VetConsultasPetPageState();
  }
}

class VetConsultasPetPageState extends State<VetConsultasPetPage> {

  var consultas = [];
  var ehvet = true;
  bool openDialog = false;
  var selectedPetId = new List();
  var selectedPetNome = new List();
  var selectedDonoEmail = new List();

  var selectedPetId1 = new List();
  String selectedPetNome1;
  String selectedDonoEmail1;
  var selectedData = new List();
  var selectedHorario= new List();
  var selectedCRMV = new List();
  var selectedPetObs = new List();

  String selectedPetIdPet;

  Future<ConsultasPets> _futureLogin;

  @override
  void initState() {
    _futureLogin = getConsultasPet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: openDialog ? Colors.grey : Colors.white,
        body: SingleChildScrollView(
            child: Container(
                child: Column(
                    children: <Widget>[
                      openDialog
                          ? SizedBox(
                        child: AlertDialog(
                          title: Text('$selectedPetNome1',
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
                                                // height: 20,
                                                Container(
                                                  height: 20,
                                                  child: Text('Data: ${selectedData[i]}', style: TextStyle(fontSize: 15),textAlign: TextAlign.left),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  height: 20,
                                                  child: Text('Horário: ${selectedHorario[i]}', style: TextStyle(fontSize: 15),textAlign: TextAlign.left),
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
                                                                onPressed:  () {
                                                                  Navigator.push(context,
                                                                      MaterialPageRoute(builder: (_) => VetConsultasPet()));
                                                                },
                                                              );
                                                              Widget continuaButton = FlatButton(
                                                                child: Text("Continuar"),
                                                                onPressed:  () {
                                                                  excluirConsulta(selectedPetId1[i]);
                                                                  Navigator.push(context,
                                                                      MaterialPageRoute(builder: (_) => VetConsultasPet()));
                                                                },
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
                                                                  return alert;},
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
                          :
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:[
                        ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: selectedPetNome.length,
                          separatorBuilder: (BuildContext context, int index) => Divider(),
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text('Nome do Pet: ${selectedPetNome[index]}'+' | ' + 'Dono do Pet: ${selectedDonoEmail[index]}' ),
                              onTap: () {
                                getConsultas(selectedPetId[index]);
                                openDialog = true;
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 60,
                          width: 200,
                          decoration:
                          BoxDecoration(color: Color.fromRGBO(122, 150, 172, 1)),
                          child: FlatButton(
                            disabledColor: Color.fromRGBO(238, 238, 238, 1),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => ConsultasPet()));
                              //para testar
                            },
                            child: Text(
                              'Voltar',
                              style: TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                        ])
                    ])
            ))
    );
  }

  Future<ConsultasPets> getConsultasPet() async {
    log('loading...');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.get('user');
    var expressUser = jsonDecode(user)['express'];
    var crmv = expressUser[0]['crmv'];
    final response = await http.get(
      Uri.parse('http://localhost:5000/consultas/vet/${crmv}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    log(response.body);
    var express = jsonDecode(response.body)['express'];
    selectedPetId = [];
    setState(() {
      consultas = express;
      for (var item2 in consultas)
        if (consultas.length != 0) {
          if (selectedPetId.contains(item2['pet']['id']) == false){
            selectedPetId.add(item2['pet']['id']);
            selectedPetNome.add(item2['pet']['nome']);
            selectedDonoEmail.add(item2['pet']['dono']);
          }
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
          selectedPetId1.add(item2['_id']);
          selectedPetNome1 = item2['pet']['nome'];
          selectedDonoEmail1 = item2['pet']['dono'];
          selectedData.add(item2['data']);
          selectedHorario.add(item2['horario']);
          selectedCRMV.add(item2['crmv']);
          selectedPetObs.add(item2['observacao']);
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

  Future<ConsultasPets> excluirConsulta(idConsulta) async {
    log('loading...');
    log('Vacinaaa ${idConsulta}');
    final response = await http.delete(
      Uri.parse('http://localhost:5000/veterinario/consultas/${idConsulta}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
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

