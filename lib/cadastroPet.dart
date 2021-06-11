import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'menu.dart';
import 'dart:convert';
import 'pets.dart'; //para testar
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
// import 'dart:io';
import 'dart:html';
class Pet {
  final String foto;
  final String nome;
  final String especie;
  final String raca;
  final String idade;
  final String peso;
  final String observacao;
  final String usuario;

  Pet(
      {
        this.foto,
        this.nome,
        this.especie,
        this.raca,
        this.idade,
        this.peso,
        this.observacao,
        this.usuario});

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
        foto: json['foto'],
        nome: json['nome'],
        especie: json['especie'],
        raca: json['raca'],
        idade: json['idade'],
        peso: json['peso'],
        observacao: json['observacao'],
        usuario: json['usuario']
    );
  }
}


class CadastroPet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MeuAppScaffold(body: CadastroPetPage());
  }
}

class CadastroPetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CadastroPetPageState();
  }
}

class CadastroPetPageState extends State<CadastroPetPage> {
  final snackBar = SnackBar(
      content: Text('Pet registrado!'),
      backgroundColor: Color.fromRGBO(10, 140, 30, 1.0));
  final snackBar2 = SnackBar(
      content: Text('Erro no registro do Pet!'),
      backgroundColor: Color.fromRGBO(219, 13, 30, 1.0));
  int option = 1;
  String selectedPet;
  DateTime selectedDate;

  final nomeController = TextEditingController();
  final especieController = TextEditingController();
  final racaController = TextEditingController();
  final sexoController = TextEditingController();
  final idadeController = TextEditingController();
  final pesoController = TextEditingController();
  final observacaoController = TextEditingController();
  final usuarioController = TextEditingController();
  Future<Pet> _futurePet;
  final _formKey = GlobalKey<FormState>();

  String _strImage;
  var _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await ImagePickerWeb.getImage(outputType: ImageType.bytes);

    setState(() {
      if (pickedFile != null) {
        _strImage = "data:image/jpeg;base64," + base64Encode(pickedFile);
        _image = base64Decode(_strImage.split(',').last);
      } else {
        print('No image selected.');
      }
    });
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
                      image: AssetImage("images/banner_cadastro.png"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                          children:[
                            SizedBox(
                              width: 10,
                            ),
                            Text('Cadastro Pet',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold)),

                          ]),
                      Row(
                        children:[
                          SizedBox(
                            width: 50,
                          ),
                          ClipOval(
                          child: _image == null
                              ? Image.asset("images/iconePerfil.png", height: 50.0,
                              width: 50.0,fit: BoxFit.cover):
                            Image.memory(_image, height: 50.0,
                              width: 50.0,fit: BoxFit.cover),
                        ),
                        Container(
                          height: 60,
                          width: 100,
                          child: ListTile(
                            leading: Icon(Icons.add_a_photo, color: Colors.white),
                            onTap: getImage,
                          ),
                          decoration:
                          BoxDecoration(color: Color.fromRGBO(122, 150, 172, 1)),
                          ),
                      ],),
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
                      if (nomeController.text == null ||
                          nomeController.text.isEmpty) {
                        return 'Digite o nome do Pet!';
                      }
                      return null;
                    },
                    controller: nomeController,
                    style: TextStyle(
                      height: 0.75,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        fillColor: Color.fromRGBO(255, 255, 255, 0.85),
                        filled: true,
                        labelText: 'Nome',
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
                        hint: Text('Espécie',
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
                        items: <String>['Cachorro', 'Gato']
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
                  child: TextFormField(
                    validator: (_) {
                      if (racaController.text == null ||
                          racaController.text.isEmpty) {
                        return 'Digite a raça do Pet!';
                      }
                      return null;
                    },
                    controller: racaController,
                    style: TextStyle(
                      height: 0.75,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        fillColor: Color.fromRGBO(255, 255, 255, 0.85),
                        filled: true,
                        labelText: 'Raça',
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
                      if (idadeController.text == null ||
                          idadeController.text.isEmpty) {
                        return 'Digite a idade do Pet!';
                      }
                      return null;
                    },
                    controller: idadeController,
                    style: TextStyle(
                      height: 0.75,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        fillColor: Color.fromRGBO(255, 255, 255, 0.85),
                        filled: true,
                        labelText: 'Idade',
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
                      if (pesoController.text == null ||
                          pesoController.text.isEmpty) {
                        return 'Digite o peso do Pet!';
                      }
                      return null;
                    },
                    controller: pesoController,
                    style: TextStyle(
                      height: 0.75,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        fillColor: Color.fromRGBO(255, 255, 255, 0.85),
                        filled: true,
                        labelText: 'Peso',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                ),
                Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('Macho'),
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
                      title: const Text('Fêmea'),
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
                            _futurePet = createPet(
                                _strImage,
                                nomeController.text,
                                selectedPet,
                                racaController.text,
                                option,
                                idadeController.text,
                                pesoController.text,
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
                            MaterialPageRoute(builder: (_) => Pets()));
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
  Future<Pet> createPet(
      img,nome, especie, raca, sexo,idade, peso,observacao) async {
    String tipo;
    if (sexo == 1)
      tipo = 'macho';
    else
      tipo = 'fêmea';
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.get('user');
    var expressUser = jsonDecode(user)['express'];
    var usuario = expressUser[0]['email'];
    final response = await http.post(
      Uri.parse('http://localhost:5000/pets/cadastro'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'foto': img,
        'nome': nome,
        'especie': especie,
        'raca': raca,
        'sexo': tipo,
        'idade': idade,
        'peso': peso,
        'observacao':observacao,
        'usuario': usuario
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      log(response.toString());
      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
    }
  }
}
