import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/database/dbaspirante.dart';

import 'package:proyecto/database/db.dart' as data;
import 'package:proyecto/vistas/cuenta.dart' as cuenta;
import 'package:proyecto/objetos/widgetsChidos.dart' as obj;
import 'package:proyecto/objetos/login.dart';
import 'package:proyecto/objetos/login.dart';
import 'package:proyecto/vistas/registro.dart';
import 'package:proyecto/database/db.dart';
import 'package:http/http.dart' as http;

List<Aspirante> listaspirantex = [];

class _sincronizado extends StatefulWidget {
  @override
  sincronizado createState() => new sincronizado();
}

class sincronizado extends State<_sincronizado> {
  @override
  Widget build(BuildContext context) {}
}

Widget sincronizadox(BuildContext context) {
  return new MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text("Lista de empleados"),
      ),
      body: FutureBuilder(
        future: aspirantes(),
        builder: (context, snapshot) {
          if (snapshot.data == null)
            return Center(
              child: CircularProgressIndicator(),
            );
          else
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, indice) {
                return ListTile(
                  leading: Text(snapshot.data[indice].nombre),
                  title: Text(snapshot.data[indice].date),
                  subtitle: Text(snapshot.data[indice].phone),
                );
              },
            );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          listaspirantex = await aspirantes();

          //Solicitud
          var url;

          //Realizar la solicitud

          for (var X in listaspirantex) {
            var nombre = X.nombre;
            var email = X.correo;
            var movil = X.phone;
            print("X VALE = ");
            print(X.sincronizado);
            if (X.sincronizado == 0) {
              url =
                  "http://sistemas.upiiz.ipn.mx/isc/sira/api/actionAddAspiranteApp.php?nombre=$nombre&email= $email&movil=$movil&accion=agregar";
              var respuestaPI = await http.get(url);
              if (respuestaPI.statusCode == 200) {
                var misAspirantesAPI = jsonDecode(respuestaPI.body);
                //print(misAspirantesAPI);
                if (misAspirantesAPI.toString() ==
                    '{estado: 1, mensaje: Sincronizado}') {
                  print("holi bb");
                  Sincronizzar(X);
                  print(misAspirantesAPI);
                }

              }
            }
          }

          return listaspirantex;
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Color.fromRGBO(118, 41, 51, 1),
      ),
    ),
  );
}

/*
Future<List<Aspirante>> getAspirantesAPI() async {


  //Solicitud

  var url = "http://sistemas.upiiz.ipn.mx/isc/sira/api/actionAddAspiranteApp.php?nombre=$nombre&email= $email&movil=$movil&accion=agregar";

  //Realizar la solicitud
  var respuestaPI = await http.get(url);

  //Revisa el estado de la solicitud
  if (respuestaPI.statusCode == 200) {
    var misAspirantesAPI = jsonDecode(respuestaPI.body);
    print(misAspirantesAPI);
    //Por medio de un ciclo añadir los datos de los empleados
    //Ciclo de campo empleados
    for (var asp in misAspirantesAPI["easpirante"])
      listaspirantex.add(Aspirante(
          //id: emp["id"],
          nombre: asp["nombre"],
         phone: asp["clave"],
          date:  asp["usuario"]));
  }

  return listaspirantex;
}
*/
