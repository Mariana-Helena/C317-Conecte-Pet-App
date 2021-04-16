import 'package:flutter/material.dart';
import 'menu.dart';
import 'vacinas.dart';
import 'main.dart';
class CadastroUser extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MeuAppScaffold(
        body: CadastroUserPage());
  }
}

class CadastroUserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState(){
    return CadastroUserState();
  }
}

class CadastroUserState extends State<CadastroUserPage> {
  static const IconData account_circle_rounded = IconData(0xf03e, fontFamily: 'MaterialIcons');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.topCenter,
              image: AssetImage("images/banner_cadastroUser.png"),
            ),
          ),
        child: Container(
          height: 550,
         child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                    height: 550,
                    child: Column(
                    children: <Widget>[
                    Padding(
                      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 130, bottom: 30),
                      child: TextField(
                        style: TextStyle(
                          height: 0.75,
                        ),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0),
                              borderSide: BorderSide(
                                style: BorderStyle.solid,
                              ),
                            ),
                            fillColor: Color.fromRGBO(255, 255, 255, 0.85),
                            filled: true,
                            labelText: 'Nome',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 0, bottom: 30),
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
                                style: BorderStyle.solid,
                              ),
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
                          left: 25, right: 25, top: 0, bottom: 30),
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
                                style: BorderStyle.solid,
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
                          left: 25, right: 25, top: 0, bottom: 30),
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
                                style: BorderStyle.solid,
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
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, top: 0, bottom: 30),
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
                                style: BorderStyle.solid,
                              ),
                            ),
                            fillColor: Color.fromRGBO(255, 255, 255, 0.85),
                            filled: true,
                            labelText: 'CRMV',
                            labelStyle: TextStyle(
                              color: Colors.black,
                            )),
                      ),
                    ),
                  ],
                  ),
                  ),
                  Container(
                    height: 50,
                    width: 270,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          color: Colors.lightBlue.shade800,
                          disabledColor: Color.fromRGBO(238, 238, 238, 1),
                          onPressed: ()   {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (_) => Vacinas()));
                            //para testar
                          },
                          child: Text(
                            'Cadastrar',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        FlatButton(
                          color: Colors.blueGrey.shade200,
                          disabledColor: Color.fromRGBO(238, 238, 238, 1),
                          onPressed: ()   {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (_) => LoginDemo()));
                            //para testar
                          },
                          child: Text(
                            'Cancelar',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
            ]
            ),
        ),
        ),
    ),
    );
  }
}



