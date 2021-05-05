import 'dart:convert';
import 'dart:developer';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'menu.dart';
import 'main.dart';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class Usuario {
  final String nome;
  final String email;
  final String senha;
  final String telefone;
  final bool ehveterinario;
  final String crmv;

  Usuario(
      {this.nome,
        this.email,
        this.senha,
        this.telefone,
        this.ehveterinario,
        this.crmv});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      nome: json['nome'],
      email: json['email'],
      senha: json['senha'],
      telefone: json['telefone'],
      ehveterinario: json['ehveterinario'],
      crmv: json['crmv']
    );
  }
}

class CadastroUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MeuAppScaffold(body: CadastroUserPage());
  }
}

class CadastroUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CadastroUserPageState();
  }
}

class CadastroUserPageState extends State<CadastroUserPage> {
  final snackBar = SnackBar(
      content: Text('Usuário registrado!'),
      backgroundColor: Color.fromRGBO(10, 140, 30, 1));
  final snackBar2 = SnackBar(
      content: Text('Erro no registro!'),
      backgroundColor: Color.fromRGBO(219, 13, 30, 1));

  int option = 1;

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final telefoneController = TextEditingController();
  final crmvController = TextEditingController();
  Future<Usuario> _futureUsuario;
  final _formKey = GlobalKey<FormState>();
  var ehvet = false;
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
                      image: AssetImage("images/banner_cadastroUser.png"),
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
                            Text('Cadastrar Usuário',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold)),

                          ]),
                      Container(
                        width: 100, //60
                        height: 100, //60
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("images/iconePerfil.png"),
                            fit: BoxFit.fitHeight,
                          ),
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
                      if (nomeController.text == null ||
                          nomeController.text.isEmpty) {
                        return 'Digite o seu nome!';
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
                Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 10, bottom: 0),
                  child: TextFormField(
                    validator: (_) {
                      if (telefoneController.text == null ||
                          telefoneController.text.isEmpty) {
                        return 'Digite o seu telefone!';
                      }
                      return null;
                    },
                    controller: telefoneController,
                    style: TextStyle(
                      height: 0.75,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        fillColor: Color.fromRGBO(255, 255, 255, 0.85),
                        filled: true,
                        labelText: 'Telefone',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 10, bottom: 0),
                  child: TextFormField(
                    validator: (_) {
                      Pattern pattern =
                          r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$';
                      RegExp regex = new RegExp(pattern);
                      if (emailController.text == null ||
                          emailController.text.isEmpty) {
                        return 'Digite o seu email';
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
                        labelText: 'Email',
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
                      if (senhaController.text == null ||
                          senhaController.text.isEmpty) {
                        return 'Digite a sua senha!';
                      }
                      return null;
                    },
                    controller: senhaController,
                    style: TextStyle(
                      height: 0.75,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        fillColor: Color.fromRGBO(255, 255, 255, 0.85),
                        filled: true,
                        labelText: 'Senha',
                        labelStyle: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                ),
                Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('Dono de Pet'),
                      leading: Radio(
                        activeColor: Color.fromRGBO(28, 88, 124, 1),
                        groupValue: option,
                        value: 1,
                        onChanged: (value) {
                          setState(() {
                            option = 1;
                            ehvet = false;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Veterinário'),
                      leading: Radio(
                        activeColor: Color.fromRGBO(28, 88, 124, 1),
                        groupValue: option,
                        value: 2,
                        onChanged: (value) {
                          setState(() {
                            option = 2;
                            ehvet = true;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                if (ehvet==false) Text("") else Padding(
                  //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, top: 10, bottom: 0),
                  child: TextFormField(
                    validator: (_) {
                      if (crmvController.text == null ||
                          crmvController.text.isEmpty) {
                        return 'Digite o seu CRMV!';
                      }
                      return null;
                    },
                    controller: crmvController,
                    style: TextStyle(
                      height: 0.75,
                    ),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                        fillColor: Color.fromRGBO(255, 255, 255, 0.85),
                        filled: true,
                        labelText: 'CRMV',
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
                            _futureUsuario = createUsuario(
                                nomeController.text,
                                emailController.text,
                                senhaController.text,
                                telefoneController.text,
                                option,
                                crmvController.text);
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
                            MaterialPageRoute(builder: (_) => LoginDemo()));
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
  Future<Usuario> createUsuario(
    nome, email, senha, telefone,ehveterinario, crmv) async {
    bool tipo;
    if (ehveterinario == 1)
      tipo = false;
    else
      tipo = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.get('user');
    final response = await http.post(
      Uri.parse('http://localhost:5000/usuario/cadastro'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'nome': nome,
        'email': email,
        'senha': senha,
        'telefone': telefone,
        'ehveterinario':tipo,
        'crmv': crmv
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
    }
  }
}

