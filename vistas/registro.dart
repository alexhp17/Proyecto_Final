import 'package:flutter/material.dart';
import 'package:proyecto/main.dart';
import 'package:proyecto/database/User.dart' as data;
import 'package:proyecto/objetos/widgetsChidos.dart';

var c1 = TextEditingController();
var c2 = TextEditingController();
var c3 = TextEditingController();
class registro extends StatefulWidget {
  @override
  _registroState createState() => _registroState();
}

class _registroState extends State<registro> {
  void reset(){
    setState(() {
      c1.clear(); c2.clear(); c3.clear();
    });
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Color.fromRGBO(118, 41, 51, 1),
        title: Text("Registro", style: TextStyle(color: Colors.white),),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          Column(
        children: <Widget>[
          logoUpiiz(height, width),
          Container(
              padding: EdgeInsets.only(left: width*.1, right: width*.1),
              child: TextField(
                controller: c1,
                decoration: InputDecoration(
                    hintText: "Usuario", border: OutlineInputBorder()),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 50, right: 50, top: 30),
                child: TextField(
                  controller: c2,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Contraseña", border: OutlineInputBorder()),
                )),
            Container(
                padding: EdgeInsets.only(left: 50, right: 50, top: 30),
                child: TextField(
                  controller: c3,
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
  if ((c2.text == c3.text) && (await data.Validar(data.User( id: 0, username: c1.text, password: c2.text))) == null) {
//Una vez cumplida la condición agregamos al usuario
    await data.insertUser(new data.User( id: 0, username: c1.text, password: c2.text));
//Cuando agregamos al usuario esta linea
//Imprime en consola la lista de usuarios y contraseñas de estos
  print(await data.users());
  AlertaExitoR(context: context,mensaje: "¡Registro exitoso!",vista: 1);
} else {
//En caso de tener el campo "Contraseña" y "Repetir contraseña" distintos
//Mostramos una alerta de error
  if (c2.text != c3.text) {
    mostrarAlerta( context: context, mensaje: 'Las contraseñas deben coincidir.');
//En caso de que el usuario ya exista mostramos una alerta de error
} else if (await data.Validar(data.User( id: 0, username: c1.text, password: null)) != null) {
    mostrarAlerta(context: context, mensaje: "Usuario no disponible.");
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
        ],
      ),
    );
  }
}


