import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/database/db.dart' as data;
import 'package:proyecto/vistas/cuenta.dart' as cuenta;
import 'package:proyecto/objetos/widgetsChidos.dart' as obj;
import 'package:proyecto/objetos/login.dart';
import 'package:proyecto/objetos/login.dart';
import 'package:proyecto/vistas/registro.dart';

void main() => runApp(proyectoApp());

class proyectoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
       debugShowCheckedModeBanner: false,
      title: 'Proyec6to Final',
      theme: ThemeData(
        primarySwatch: Colors.orange
      ),
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
      var hg =MediaQuery.of(context).size.height;
      var wid =MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromRGBO(118, 41, 51, 1),
      ),
      body: ListView(
        children: <Widget>[
        LoginForm(hg, wid,context),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, 
      MaterialPageRoute(builder: (context) =>registro())
      );
        },
        child: Icon(Icons.add,color: Colors.white,),
        backgroundColor: Color.fromRGBO(118, 41, 51, 1),
      ),    
    );
  }
}
