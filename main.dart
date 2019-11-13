import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:proyectofinal/db.dart' as data;
import 'db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: Login(),
  ));
}

//LOGIN
class Login extends StatelessWidget {
  // This widget is the root of your application.
  final Controlador1 = TextEditingController();
  final Controlador2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Login"),
          backgroundColor: Color.fromRGBO(118, 41, 51, 1),
        ),
        body: Column(
          children: <Widget>[
            Container(
              child: Image.asset('assets/upiiz.png',
                scale: 25,),
            ),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50),
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
                  obscureText: true,
                )),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50, top: 30),
              child: RaisedButton(
                onPressed: () async {
                  //Validamos que el usuario y contraseña sean los mismos que
                  //En la base de datos

                  //En caso de que El usuario o contraseña no se valide en la
                  //Base de datos imprimimos un error en la interfaz
                  if (await data.Logearse(data.User(
                          id: 0,
                          username: Controlador1.text,
                          password: Controlador2.text)) ==
                      null) {
                    mostrarAlerta(
                        context: context,
                        mensaje: "usuario o contraseña incorrecta");
                  }
                  //En caso de ser validados por la base de datos pasamos al Menu
                  else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Menu();
                    }));
                  }
                },
                child: Text(
                  "Ingresar",
                  style: TextStyle(color: Colors.white),
                ),
                color: Color.fromRGBO(118, 41, 51, 1),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Registro();
            }));
          },
          child: Icon(Icons.add),
          backgroundColor: Color.fromRGBO(118, 41, 51, 1),
        ),
      ),
    );
  }
}

class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final Controlador1 = TextEditingController();
  final Controlador2 = TextEditingController();
  final Controlador3 = TextEditingController();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,

            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Login();
                }));
              },
            ),
            title: Text("Registro"),
            backgroundColor: Color.fromRGBO(118, 41, 51, 1)),
        body: Column(
          children: <Widget>[
            Container(
              child: Image.asset('assets/upiiz.png',
                scale: 25,),
            ),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50),
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
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Contraseña", border: OutlineInputBorder()),
                )),
            Container(
                padding: EdgeInsets.only(left: 50, right: 50, top: 30),
                child: TextField(
                  controller: Controlador3,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Repetir Contraseña",
                      border: OutlineInputBorder()),
                )),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50, top: 30),
              child: RaisedButton(
                onPressed: () async {
                  //Si las contraseñas son iguales y el usuario esta disponible
                  //Entonces agregamos al usuario
                  if ((Controlador2.text == Controlador3.text) &&
                      (await data.Validar(data.User(
                              id: 0,
                              username: Controlador1.text,
                              password: Controlador2.text))) ==
                          null) {
                    //Una vez cumplida la condición agregamos al usuario
                    await data.insertUser(new data.User(
                        id: 0,
                        username: Controlador1.text,
                        password: Controlador2.text));
                    //Cuando agregamos al usuario esta linea
                    //Imprime en consola la lista de usuarios y contraseñas de estos
                    print(await data.users());
                  } else {
                    //En caso de tener el campo "Contraseña" y "Repetir contraseña" distintos
                    //Mostramos una alerta de error
                    if (Controlador2.text != Controlador3.text) {
                      mostrarAlerta(
                          context: context,
                          mensaje: 'Las contraseñas deben coincidir.');
                      //En caso de que el usuario ya exista mostramos una alerta de error
                    } else if (await data.Validar(data.User(
                            id: 0,
                            username: Controlador1.text,
                            password: null)) !=
                        null) {
                      mostrarAlerta(
                          context: context, mensaje: "Usuario no disponible.");
                    }
                  }
                },
                child: Text(
                  "Registrar",
                  style: TextStyle(color: Colors.white),
                ),
                color: Color.fromRGBO(118, 41, 51, 1),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//MENU
class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
        theme: ThemeData(
            primaryColor: Color.fromRGBO(118, 41, 51, 1)

    ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Menú"),
          backgroundColor: Color.fromRGBO(118, 41, 51, 1),
        ),
        drawer: Drawer(
            child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text("raul_chulets@live.com"),
              accountName: Text("Rulero76"),
              currentAccountPicture: CircleAvatar(
                child: Text("R",
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
              onTap: () {},
            ),
            ListTile(
              title: Text("Sincronizar"),
              leading: Icon(
                Icons.bookmark,
                color: Color.fromRGBO(118, 41, 51, 1),
              ),
              onTap: () {},
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
                  return Login();
                }));
              },
            ),
          ],
        )),
      ),
    );
  }
}

void mostrarAlerta({BuildContext context, String mensaje}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: new Text("Error."),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(mensaje),
          ],
        ),
        //
        actions: <Widget>[
          FlatButton(
            child: Text("Aceptar"),
            onPressed: () {},
          ),
        ],
      );
    },
  );
}
