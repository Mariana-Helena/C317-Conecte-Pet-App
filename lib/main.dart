import 'package:conecte_pet/agendamentoConsulta.dart';
import 'package:flutter/material.dart';
import 'pets.dart';
import 'vacinasRegistro.dart';
import 'vacinas.dart';
import 'consultas.dart';
import 'agendamentoConsulta.dart';
import 'consultas.dart';
import 'cadastroUser.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conecte Pet',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => LoginDemo(),
        '/pets': (context) => Pets(),
        '/consultas': (context) => AgendamentoConsulta(),
        '/vacinas': (context) => VacinasRegistro(),
        '/usuario/cadastro': (context) => CadastroUser(),
      },
    );
  }
}

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/Wallpaper.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Center(
                  child: Container(
                      width: 200,
                      height: 200,
                      child: Image.asset('images/logopng.png')),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 10, bottom: 0),
                child: TextField(
                  style: TextStyle(
                    height: 0.75,
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
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
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 10, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  style: TextStyle(
                    height: 0.75,
                  ),
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      fillColor: Color.fromRGBO(255, 255, 255, 0.85),
                      filled: true,
                      labelText: 'Senha',
                      labelStyle: TextStyle(
                        color: Colors.black,
                      )),
                ),
              ),
              FlatButton(
                onPressed: () {
                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                },
                child: Text(
                  'Esqueceu a senha?',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              Container(
                height: 50,
                width: 310,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Color.fromRGBO(28, 88, 124, 1)),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_) => Pets()));
                  },
                  child: Text(
                    'Entrar',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: 310,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color: Color.fromRGBO(60, 72, 88, 1)),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CadastroUser()));
                  },
                  child: Text(
                    'Cadastrar',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
