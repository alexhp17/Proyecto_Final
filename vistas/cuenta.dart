import 'package:flutter/material.dart';
import 'package:proyecto/main.dart' as m;
import 'package:proyecto/vistas/aspirante.dart';
import 'package:proyecto/vistas/Nosincronizados.dart' as sinc;
Widget principal(BuildContext context, String nombre){
      return new MaterialApp(
        theme: ThemeData(
            primaryColor: Color.fromRGBO(118, 41, 51, 1)

    ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Menú"),
          backgroundColor: Color.fromRGBO(118, 41, 51, 1),
        ),
        drawer: menu(context,nombre)
      ),
    );
}

Widget menu(BuildContext context, nombre){
  if(nombre==null)nombre="";
  return Drawer(
          child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("$nombre"),
              currentAccountPicture: CircleAvatar(
                child: Text("$nombre"[0],  
                  style: TextStyle(color: Color.fromRGBO(118, 41, 51, 1)),),
                backgroundColor: Colors.white,
              ),
            ),
            ListTile(
              title: Text("Agregar Aspirante"),
              leading: Icon(
                Icons.favorite,
                color: Color.fromRGBO(118, 41, 51, 1),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return  aspiranteScreen();
                  }));
              },
            ),
            ListTile(
              title: Text("Sincronizar"),
              leading: Icon(
                Icons.bookmark,
                color: Color.fromRGBO(118, 41, 51, 1),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return  sinc.sincronizadox(context);
                }));
              },
            ),
            ListTile(
              title: Text("No sincronizados"),
              leading: Icon(
                Icons.camera_alt,
                color: Color.fromRGBO(118, 41, 51, 1),
              ),
              onTap: () {},
            ),
            ListTile(
              title: Text("Cerrar sesión"),
              leading: Icon(
                Icons.map,
                color: Color.fromRGBO(118, 41, 51, 1),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return m.Login();
                }));
              },
            ),
          ],
        ));
}