import 'package:flutter/material.dart';
import 'package:proyecto/SQLITEPrueba.dart';
import 'package:proyecto/db.dart' as data;
import 'db.dart';
import 'package:sqflite/sqflite.dart' ;
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
                  obscureText: true,
                )
            ),
            Container(
              padding: EdgeInsets.only(left: 50, right: 50, top: 30),
              child: RaisedButton(
                onPressed: () async {
                  //Validamos que el usuario y contraseña sean los mismos que
                  //En la base de datos

                  //En caso de que El usuario o contraseña no se valide en la
                  //Base de datos imprimimos un error en la interfaz
                  if(await data.Logearse(data.User(id: 0,username:Controlador1.text ,password:Controlador2.text ))== null){
                    mostrarAlerta(context: context,mensaje: "usuario o contraseña incorrecta");
                  }
                  //En caso de ser validados por la base de datos pasamos al Menu
                  else{
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Menu();
                    }));
                  }

                },
                child: Text("Ingresar"),
                color: Colors.orange,
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
          backgroundColor: Colors.orange,
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
    return MaterialApp(
      home: Scaffold(
        body: ListView(
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
                onPressed: () async{
                  //Si las contraseñas son iguales y el usuario esta disponible
                  //Entonces agregamos al usuario
                  if((Controlador2.text==Controlador3.text)
                      &&(await data.Validar(data.User(id: 0,username: Controlador1.text,password: Controlador2.text)))==null) {

                    //Una vez cumplida la condición agregamos al usuario
                    await data.insertUser(new data.User(id: 0,username: Controlador1.text,password: Controlador2.text));
                    //Cuando agregamos al usuario esta linea
                    //Imprime en consola la lista de usuarios y contraseñas de estos
                    print(await data.users());
                  }else{
                    //En caso de tener el campo "Contraseña" y "Repetir contraseña" distintos
                    //Mostramos una alerta de error
                    if(Controlador2.text != Controlador3.text){
                    mostrarAlerta(
                        context: context, mensaje: 'Las contraseñas deben coincidir.');
                    //En caso de que el usuario ya exista mostramos una alerta de error
                  }else if(await data.Validar(data.User(id: 0,username: Controlador1.text,password: null)) != null){
                      mostrarAlerta(context: context,mensaje:"Usuario no disponible.");
                    }
                  }

                },
                child: Text("Registrar"),
                color: Colors.orange,
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
      home: Scaffold(
        appBar: AppBar(
          title: Text("Menú"),
        ),
        drawer: Drawer(
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountEmail: Text("raul_chulets@live.com"),
                  accountName: Text("Rulero76"),
                  currentAccountPicture: CircleAvatar(
                    child: Text("R"),
                  ),
                ),
                ListTile(
                  title: Text("Agregar Aspirante"),
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.blue,
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text("Sincronizar"),
                  leading: Icon(
                    Icons.bookmark,
                    color: Colors.blue,
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text("No sincronizados"),
                  leading: Icon(
                    Icons.camera_alt,
                    color: Colors.blue,
                  ),
                  onTap: () {},
                ),
                ListTile(
                  title: Text("Cerrar sesión"),
                  leading: Icon(
                    Icons.map,
                    color: Colors.blue,
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