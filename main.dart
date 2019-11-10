import 'package:flutter/material.dart';
import 'package:proyecto/SQLITE.dart' as holi;

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: Login(),
  ));
}

class Login extends StatelessWidget {
  // This widget is the root of your application.
  final Controlador1 = TextEditingController();
  final Controlador2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 250, left: 50, right: 50),
              child: TextField(
                controller: Controlador1,
                decoration: InputDecoration(
                    hintText: "Usuario", border: OutlineInputBorder()),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 50, right: 50, top: 30),
                child: TextField(
                  controller: Controlador2,
                  decoration: InputDecoration(
                      hintText: "Contraseña", border: OutlineInputBorder()),
                ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Registro();
            }));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.orange,
        ),
      ),
    );
  }
}

//REGISTRO
class Registro extends StatelessWidget {
  final Controlador1 = TextEditingController();
  final Controlador2 = TextEditingController();
  final Controlador3 = TextEditingController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 250, left: 50, right: 50),
              child: TextField(
                controller: Controlador1,
                decoration: InputDecoration(
                    hintText: "Usuario", border: OutlineInputBorder()),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 50, right: 50, top: 30),
                child: TextField(
                  controller: Controlador2,
                  decoration: InputDecoration(
                      hintText: "Contraseña", border: OutlineInputBorder()),
                )),
            Container(
                padding: EdgeInsets.only(left: 50, right: 50, top: 30),
                child: TextField(
                  controller: Controlador3,
                  decoration: InputDecoration(
                      hintText: "Repetir Contraseña",
                      border: OutlineInputBorder()),
                ))
          ],
        ),
      ),
    );
  }
}
class Menu extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Menú"),
        ),
        drawer: Drawer(
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}