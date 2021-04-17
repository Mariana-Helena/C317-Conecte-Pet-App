import 'package:flutter/material.dart';
import 'menu.dart';
import 'vacinas.dart'; //para testar
import 'main.dart';
import 'cadastroPet.dart';

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
  int option = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                      width: 60,
                      height: 60,
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
                child: TextField(
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
                child: TextField(
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
                child: TextField(
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
                        });
                      },
                    ),
                  ),
                ],
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => CadastroPet()));
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
    );
  }
}
