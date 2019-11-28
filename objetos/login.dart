import 'package:flutter/material.dart';
import 'package:proyecto/objetos/widgetsChidos.dart';
import 'package:proyecto/database/User.dart' as data;
import 'package:proyecto/vistas/cuenta.dart';
// CONTROLADORES
var user = TextEditingController();
var pass = TextEditingController();
Widget LoginForm(altura,ancho,context){
  void reset(){
    user.clear();
    pass.clear();
  }
  return Column(
    children: <Widget>[
      logoUpiiz(altura, ancho),
      Divider(height: altura*.03,),
      Container(
      padding: EdgeInsets.only(left: ancho*.1, right: ancho*.1),
      child: TextField(
      controller: user,
      decoration: InputDecoration(
      hintText: "Usuario", border: OutlineInputBorder()),
    ),    
  ),
      SizedBox(height: altura*.020),
      Container(
      padding: EdgeInsets.only(left: ancho*.1, right: ancho*.1),
      child: TextField(
      controller: pass,
      decoration: InputDecoration(
      hintText: "Contraseña", border: OutlineInputBorder()),
      obscureText: true,
    ),    
  ),
      SizedBox(height: altura*.015,),
    RaisedButton(
      onPressed: () async{
        //Validamos que el usuario y contraseña sean los mismos que
        //En la base de datos
        //En caso de que El usuario o contraseña no se valide en la
        //Base de datos imprimimos un error en la interfaz
        if (await data.Logearse(data.User( id: 0, username: user.text, password: pass.text)) == null) {
          reset();
          mostrarAlerta(context: context, mensaje: "usuario o contraseña incorrecta");
        }
        //En caso de ser validados por la base de datos pasamos al Menu
        else {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
          String aux = user.text;
         // reset();
          return menu(context,aux);
        }));
}
      },
      child: Text("Iniciar Sesión"),
    ),

    ],
  );
}