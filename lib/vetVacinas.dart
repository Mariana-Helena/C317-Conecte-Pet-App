import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'menu.dart';
import 'vacinas.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class VetVacinasPet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MeuAppScaffold(body: VetVacinasPetPage());
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

class VetVacinasPetPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return VetVacinasPetPageState();
  }
}

class VetVacinasPetPageState extends State<VetVacinasPetPage> {

  var vacinas = [];
  var ehvet = true;
  bool openDialog = false;
  var selectedPetId = new List();
  var selectedPetNome = new List();
  var selectedDonoEmail = new List();

  var selectedPetId1 = new List();
  String selectedPetNome1;
  String selectedDonoEmail1;
  var selectedFabricante = new List();
  var selectedVacina = new List();
  var selectedData = new List();
  var selectedTipo = new List();
  var selectedCRMV = new List();
  var selectedPetObs = new List();

  String selectedPetIdPet;

  Future<VacinasPets> _futureLogin;

  @override
  void initState() {
    _futureLogin = getVacinasPet();
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
                                                              MaterialPageRoute(builder: (_) => VetVacinasPet()));
                                                        },
                                                      );
                                                      Widget continuaButton = FlatButton(
                                                        child: Text("Continuar"),
                                                        onPressed:  () {
                                                          excluirVacina(selectedPetId1[i]);
                                                          Navigator.push(context,
                                                              MaterialPageRoute(builder: (_) => VetVacinasPet()));
                                                        },
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
                            getVacinas(selectedPetId[index]);
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
                              MaterialPageRoute(builder: (_) => VacinasPet()));
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

  Future<VacinasPets> getVacinasPet() async {
    log('loading...');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.get('user');
    var expressUser = jsonDecode(user)['express'];
    var crmv = expressUser[0]['crmv'];
    final response = await http.get(
      Uri.parse('http://localhost:5000/vacinas/vet/${crmv}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    log(response.body);
    var express = jsonDecode(response.body)['express'];
    selectedPetId = [];
    setState(() {
      vacinas = express;
      for (var item2 in vacinas)
        if (vacinas.length != 0) {
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
      return VacinasPets.fromJson(jsonDecode(response.body));
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
          selectedPetId1.add(item2['_id']);
          selectedPetNome1 = item2['pet']['nome'];
          selectedDonoEmail1 = item2['pet']['dono'];
          selectedFabricante.add(item2['fabricante']);
          selectedVacina.add(item2['vacina']);
          selectedData.add(item2['data']);
          selectedTipo.add(item2['tipo']);
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
      return VacinasPets.fromJson(jsonDecode(response.body));
    } else {
      //ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<VacinasPets> excluirVacina(idVacina) async {
    log('loading...');
    log('Vacinaaa ${idVacina}');
    final response = await http.delete(
      Uri.parse('http://localhost:5000/veterinario/vacinas/${idVacina}'),
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
      return VacinasPets.fromJson(jsonDecode(response.body));
    } else {
      //ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

}

