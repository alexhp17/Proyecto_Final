import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:proyecto/Aspirante.dart';
import 'package:proyecto/main.dart' as mainn;
import 'package:proyecto/User.dart' as data;
import 'package:proyecto/db.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart' as select;
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:proyecto/Aspirante.dart' as asp;

Widget aspirante(BuildContext context) {
  var height = MediaQuery.of(context).size.height;
  var width = MediaQuery.of(context).size.width;

  final controlNombre = TextEditingController();
  final controlPaterno = TextEditingController();
  final controlMaterno = TextEditingController();
  final controledad = TextEditingController();
  final controlsexo = TextEditingController();
  final controlcorreo = TextEditingController();
  final controlmovil = TextEditingController();
  final controlprepa = TextEditingController();
  final controlop1 = TextEditingController();
  final controlop2 = TextEditingController();
  final controlop3 = TextEditingController();
  final controlfecha = TextEditingController();

  return Scaffold(
      appBar: AppBar(
        title: Text("Agregar aspirante"),
        backgroundColor: Color.fromRGBO(118, 41, 51, 1),
        automaticallyImplyLeading: true,

        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: ListView(
        children: <Widget>[
          Container(
            height: 40,
            child: ListTile(
              leading: Text("Nombre:"),
              title: Container(
                padding: EdgeInsets.only(left: 60),
                child: TextField(

                    controller: controlNombre,
                    decoration: InputDecoration(border: OutlineInputBorder())
                ),
              )
            ),
          ),
          Container(
            height: 55,
            padding: EdgeInsets.only(top:15),
            child: ListTile(
              leading: Text("Apellido paterno:"),
              title: Container(
                padding: EdgeInsets.only(left: 10),
                child: TextField(
                    controller: controlPaterno,
                    decoration: InputDecoration(border: OutlineInputBorder())
                ),
              )
            ),
          ),
          Container(
            height: 55,
            padding: EdgeInsets.only(top:15),
            child: ListTile(
              leading: Text("Apellido materno:"),
              title: Container(
                padding: EdgeInsets.only(left: 5),
                child: TextField(
                    controller: controlMaterno,
                    decoration: InputDecoration(border: OutlineInputBorder())
                ),
              )
            ),
          ),
          Container(
            height: 55,
            padding: EdgeInsets.only(top:15),
            child: ListTile(
              leading: Text("Edad:"),
              title: Container(
                padding: EdgeInsets.only(left: 75),
                child: TextField(
                    controller: controledad,
                    decoration: InputDecoration(border: OutlineInputBorder())
                ),
              )
            ),
          ),
          Container(
            height: 55,
            padding: EdgeInsets.only(top:15),
            child: ListTile(
              leading: Text("Sexo:"),
              title: Container(
                padding: EdgeInsets.only(left: 75),
                child:
                Radio(),
              )
            ),
          ),
          Container(
            height: 55,
            padding: EdgeInsets.only(top:15),
            child: ListTile(
              leading: Text("Correo:"),
              title: Container(
                padding: EdgeInsets.only(left: 70),
                child: TextField(
                    controller: controlcorreo,
                    decoration: InputDecoration(border: OutlineInputBorder())
                ),
              )
            ),
          ),
          Container(
            height: 55,
            padding: EdgeInsets.only(top:15),
            child: ListTile(
              leading: Text("Celular:"),
              title: Container(
                padding: EdgeInsets.only(left: 70),
                child: TextField(
                    controller: controlmovil,
                    decoration: InputDecoration(border: OutlineInputBorder())
                ),
              )
            ),
          ),
          Container(
            height: 55,
            padding: EdgeInsets.only(top:15),
            child: ListTile(
              leading: Text("Preparatoria:"),
              title: Container(
                padding: EdgeInsets.only(left: 35),
                child: TextField(
                    controller: controlprepa,
                    decoration: InputDecoration(border: OutlineInputBorder())
                ),
              )
            ),
          ),
          Container(
            height: 55,
            padding: EdgeInsets.only(top:15),
            child: ListTile(
              leading: Text("Opción 1:"),
              title: Container(
                padding: EdgeInsets.only(left: 60),
                child: TextField(
                    controller: controlop1,
                    decoration: InputDecoration(border: OutlineInputBorder())
                ),
              )
            ),
          ),
          Container(
            height: 55,
            padding: EdgeInsets.only(top:15),
            child: ListTile(
              leading: Text("Opción 2:"),
              title: Container(
                padding: EdgeInsets.only(left: 60),
                child: TextField(
                    controller: controlop2,
                    decoration: InputDecoration(border: OutlineInputBorder())
                ),
              )
            ),
          ),
          Container(
            height: 55,
            padding: EdgeInsets.only(top:15),
            child: ListTile(
              leading: Text("Opción 3:"),
              title: Container(
                padding: EdgeInsets.only(left: 60),
                child: DropdownButton(
                  onChanged: (value){

                    Text(controlop3.toString());

                },
                  hint: Text("Programa Académico"),
                  items: [
                    DropdownMenuItem(
                      value: controlop3,
                      child:Text("Ing. Sistemas Computacionales")
                    ),
                    DropdownMenuItem(
                      value: controlop3,
                      child: Text("Ing. Mecatrónica")
                    ),
                  ],
                ),
              )
            ),
          ),
          Container(
            height: 55,
            padding: EdgeInsets.only(top:15),
            child: ListTile(
              leading: Text("Fecha:"),
              title: Container(
                padding: EdgeInsets.only(left: 75),
                child: TextField(
                    controller: controlfecha,
                    decoration: InputDecoration(border: OutlineInputBorder())
                ),
              )
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 100,right: 100, top:30),
            child: RaisedButton(
              onPressed: (){

              },
              child: Text("Agregar Aspirante"),
              color: Color.fromRGBO(118, 41, 51, 1),
            ),
          )
        ],
      ));
}

Widget Selectt(){
var _value;
  DropdownButton _itemDown() => DropdownButton<String>(
    items: [
      DropdownMenuItem(
        value: "1",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Icon(Icons.build),
            SizedBox(width: 10),
            Text(
              "build",
            ),
          ],
        ),
      ),
      DropdownMenuItem(
        value: "2",
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(Icons.settings),
            SizedBox(width: 10),
            Text(
              "Setting",
            ),
          ],
        ),
      ),
    ],
    onChanged: (value) {

    },
    value: _value,
    isExpanded: true,
  );

}
bool validarNum(String controlmovil) {
  // tamaño
  bool espacio = false;
  bool rtn = true;
  if (controlmovil.length < 8)
    return false;
  for (int i = 0; i < controlmovil.length; i++) {
    var c = controlmovil.substring(i,controlmovil.length);
    if (c == ' ' || c != '~') {
      rtn = false; //Espacio o fuera de rango
      break;
    }
    return rtn;
  }
}

