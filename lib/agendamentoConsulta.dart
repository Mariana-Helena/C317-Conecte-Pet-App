import 'package:flutter/material.dart';
import 'menu.dart';
import 'vacinas.dart'; //para testar

class AgendamentoConsulta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MeuAppScaffold(body: AgendamentoConsultaPage());
  }
}

class AgendamentoConsultaPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AgendamentoConsultaPageState();
  }
}

class AgendamentoConsultaPageState extends State<AgendamentoConsultaPage> {
  final pets = ['1', '2', '3', '4'];
  int option = 1;
  String selectedPet;
  DateTime selectedDate;
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
                    image: AssetImage("images/banner_consultas.png"),
                    fit: BoxFit.fitHeight,
                  ),
                ),
                child: Column(
                  children: [
                    Row(children: [
                      SizedBox(
                        width: 10,
                      ),
                      Text('Agendar Consulta',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold)),
                    ]),
                    Padding(
                      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                      padding: const EdgeInsets.only(
                          left: 25, right: 175, top: 0, bottom: 0),
                      child: InputDatePickerFormField(
                        firstDate: new DateTime.utc(1970, 0, 0),
                        lastDate: new DateTime.utc(2100, 0, 0),
                        initialDate: new DateTime.now(),
                        fieldHintText: 'mm/dd/yyyy',
                        fieldLabelText: 'Data',
                        onDateSaved: (value) {
                          setState(() {
                            selectedDate = value;
                          });
                        },
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
                      labelText: 'Email do dono do pet',
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
                      hint: Text('Pet',
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
                      items: <String>['One', 'Two', 'Three', 'Four']
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
                      labelText: 'Horário',
                      hintText: 'HH:MM',
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
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => Vacinas()));
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
                          MaterialPageRoute(builder: (_) => Vacinas()));
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
