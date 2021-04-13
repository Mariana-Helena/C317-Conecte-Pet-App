import 'package:flutter/material.dart';
import 'pets.dart';

class MeuAppScaffold extends StatelessWidget {
  final Widget body;

  MeuAppScaffold({this.body});

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: Container(
          /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
          child: Image.asset('images/ConectePet.png')),

    );

    final appBar = AppBar(
      title: Text('Conecte Pet'),
      actions: <Widget> [],
      backgroundColor: Color.fromRGBO(28, 88, 124, 1),
    );

    final drawer = Drawer(
      child: Container(
        decoration: BoxDecoration(
              color: (
                Color.fromRGBO(28, 88, 124, 1)
              )
        ),
        child: ListView(
            children: <Widget> [
              SizedBox(
              height : 250.0,
                child  : new DrawerHeader(
                    child  : logo,
                    decoration: new BoxDecoration(color: Colors.white),
                    margin : EdgeInsets.zero,
                    padding: EdgeInsets.zero
                ),
              ),
              ListTile(
                leading: Icon(Icons.pets, color: Colors.white),
                title: Text('Pets',style: TextStyle( color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.medical_services_outlined, color: Colors.white), //se possível colocar icone de vacina
                title: Text('Carteira de vacinação',style: TextStyle( color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.calendar_today, color: Colors.white),
                title: Text('Consultas',style: TextStyle( color: Colors.white)),
                onTap: () {
                  Navigator.pop(context);
                },
              ),]
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      drawer: drawer,
      body: body,
    );
  }
}