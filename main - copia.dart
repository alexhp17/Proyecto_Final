import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proyecto/vistas/AgregarAspirante.dart' as pirante;
import 'package:proyecto/User.dart' as data;
import 'package:proyecto/db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:proyecto/Aspirante.dart' as asp;
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

import 'package:intl/intl.dart';
//Variables Globales

final Controlador1L = TextEditingController();
final Controlador2L = TextEditingController();

final Controlador1R = TextEditingController();
final Controlador2R = TextEditingController();
final Controlador3R = TextEditingController();

int selectRadio;
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

TextEditingController _inputFieldDateController = new TextEditingController();


final now = new DateTime.now();
final date = new DateTime(now.year,now.month,now.day);

void main() {
  runApp(MaterialApp(
    title: 'Navigation Basics',
    home: Login(),
  ));
}

//LOGIN
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // This widget is the root of your application.


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
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: height*.3,
                  decoration: BoxDecoration(),
                  child: Image.asset('assets/upiiz.png', fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: height*.03,),
                Container(
                  padding: EdgeInsets.only(left: width*.1, right: width*.1),
                  child: TextField(
                    controller: Controlador1L,
                    decoration: InputDecoration(
                        hintText: "Usuario", border: OutlineInputBorder()),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: width*.1, right: width*.1, top: width*.1),
                    child: TextField(
                      controller: Controlador2L,
                      decoration: InputDecoration(
                          hintText: "Contraseña", border: OutlineInputBorder()),
                      obscureText: true,
                    )),
                Container(
                  padding: EdgeInsets.only(left: width*.15, right: width*.15, top: width*.1),
                  child: RaisedButton(
                    onPressed: () async {
                      //Validamos que el usuario y contraseña sean los mismos que
                      //En la base de datos

                      //En caso de que El usuario o contraseña no se valide en la
                      //Base de datos imprimimos un error en la interfaz
                      if (await data.Logearse(data.User(
                          id: 0,
                          username: Controlador1L.text,
                          password: Controlador2L.text)) ==
                          null) {
                        mostrarAlerta(
                            context: context,
                            mensaje: "usuario o contraseña incorrecta");
                      }
                      //En caso de ser validados por la base de datos pasamos al Menu
                      else {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return menu(context,Controlador1L.text);
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
              padding: EdgeInsets.only(left: width*.1, right: width*.1),
              child: TextField(
                controller: Controlador1R,
                decoration: InputDecoration(
                    hintText: "Usuario", border: OutlineInputBorder()),
              ),
            ),
            Container(
                padding: EdgeInsets.only(left: 50, right: 50, top: 30),
                child: TextField(
                  controller: Controlador2R,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Contraseña", border: OutlineInputBorder()),
                )),
            Container(
                padding: EdgeInsets.only(left: 50, right: 50, top: 30),
                child: TextField(
                  controller: Controlador3R,
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
                  if ((Controlador2R.text == Controlador3R.text) &&
                      (await data.Validar(data.User(
                          id: 0,
                          username: Controlador1R.text,
                          password: Controlador2R.text))) ==
                          null) {
                    //Una vez cumplida la condición agregamos al usuario
                    await data.insertUser(new data.User(
                        id: 0,
                        username: Controlador1R.text,
                        password: Controlador2R.text));
                    //Cuando agregamos al usuario esta linea
                    //Imprime en consola la lista de usuarios y contraseñas de estos
                    print(await data.users());
                    AlertaExitoR(context: context,mensaje: "¡Registro exitoso!");
                  } else {
                    //En caso de tener el campo "Contraseña" y "Repetir contraseña" distintos
                    //Mostramos una alerta de error
                    if (Controlador2R.text != Controlador3R.text) {
                      mostrarAlerta(
                          context: context,
                          mensaje: 'Las contraseñas deben coincidir.');
                      //En caso de que el usuario ya exista mostramos una alerta de error
                    } else if (await data.Validar(data.User(
                        id: 0,
                        username: Controlador1R.text,
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

Widget menu(BuildContext context, String nombre){
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
                    return  _aspirantex();
                  }));
                },
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

class _aspirantex extends StatefulWidget{
  @override
  aspirantex createState() => aspirantex();
}

class aspirantex extends State<_aspirantex>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      selectRadio = 0;
    }
    setSelectRadio(int val){
      setState(() {
        selectRadio = val;
      });
    }

    return new MaterialApp(
      home:Scaffold(
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
                      padding: EdgeInsets.only(left: 15),
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
                      padding: EdgeInsets.only(left: 10),
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
                      padding: EdgeInsets.only(left: 65),
                      child: TextField(
                        maxLength: 3,
                          keyboardType: TextInputType.phone,
                          controller: controledad,
                          decoration: InputDecoration(border: OutlineInputBorder())
                      ),
                    )
                ),
              ),
              Container(
                height: 55,
                padding: EdgeInsets.only(top:15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(

                      padding:EdgeInsets.only(right: 100) ,
                      child: Text("Sexo: "),
                    ),
                    new Radio(value: 1, groupValue: selectRadio, onChanged: (val){ print("Radio $val"); setSelectRadio(val);}),
                    new Text('Masculino'),
                    new Radio(value: 2, groupValue: selectRadio, onChanged: (val){ print("Radio $val");setSelectRadio(val);}),
                    new Text('Femenino'),
                  ],
                )
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
                          decoration: InputDecoration(border: OutlineInputBorder()),
                          keyboardType: TextInputType.emailAddress,
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
                        maxLength: 10,
                          keyboardType: TextInputType.phone,
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
                child: _crearDropdown1()
              ),
              Container(
                height: 55,
                padding: EdgeInsets.only(top:15),
                child: _crearDropdown2()
              ),
              Container(
                height: 55,
                padding: EdgeInsets.only(top:15),
                child:_crearDropdown3(),

              ),
              Container(
                height: 55,
                padding: EdgeInsets.only(top:15),
                child:Row(
                  children: <Widget>[
                    Container(
                      child: Text("Fecha de registro: "),
                    ),
                    Container(
                      child: Text(new DateFormat("dd-MM-yyyy").format(now)),
                    )
                  ],
                )
              ),
              Container(
                padding: EdgeInsets.only(left: 100,right: 100, top:30),
                child: RaisedButton(
                  onPressed: (){

                  },
                  child: Text("Agregar Aspirante",

                    style:TextStyle(color: Colors.white) ,),
                  color: Color.fromRGBO(118, 41, 51, 1),
                ),
              )
            ],
          )) ,
    );
  }
  String _opcionSeleccionada3 = 'Ingeniería en Sistemas';
  List<String> _poderes3 = ['Ingeniería en Sistemas', 'Ingeniería en Mecatrónica', 'Ingeniería Metalúrgica', 'Ingeniería Ambiental', 'Ingeniería en Alimentos'];
  List<DropdownMenuItem<String>> getOpcionesDropdown() {
    List<DropdownMenuItem<String>> lista = new List();
    _poderes3.forEach((poder) {
      lista.add(new DropdownMenuItem(
        child: Text(poder), // lo que se muestra
        value: poder,
      ));
    });
    return lista;
  }
  Widget _crearDropdown3() {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20),

          child: Text("Opción 3:"),
        ),
        SizedBox(width: 100.0,),
        Container(


          child: DropdownButton(
            value: _opcionSeleccionada3,
            items: getOpcionesDropdown(),
            onChanged: (opt){
              setState(() {
                _opcionSeleccionada3 = opt;
              });
            },
          ),
        )

      ],
    );

  }

  String _opcionSeleccionada2 = 'Ingeniería en Sistemas';
  List<String> _poderes2 = ['Ingeniería en Sistemas', 'Ingeniería en Mecatrónica', 'Ingeniería Metalúrgica', 'Ingeniería Ambiental', 'Ingeniería en Alimentos'];
  List<DropdownMenuItem<String>> getOpcionesDropdown2() {
    List<DropdownMenuItem<String>> lista = new List();
    _poderes2.forEach((poder) {
      lista.add(new DropdownMenuItem(
        child: Text(poder), // lo que se muestra
        value: poder,
      ));
    });
    return lista;
  }
  Widget _crearDropdown2() {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20),

          child: Text("Opción 2:"),
        ),
        SizedBox(width: 100.0,),
        Container(


          child: DropdownButton(
            value: _opcionSeleccionada2,
            items: getOpcionesDropdown(),
            onChanged: (opt){
              setState(() {
                _opcionSeleccionada2 = opt;
              });
            },
          ),
        )

      ],
    );
  }
  String _opcionSeleccionada1 = 'Ingeniería en Sistemas';
  List<String> _poderes1 = ['Ingeniería en Sistemas', 'Ingeniería en Mecatrónica', 'Ingeniería Metalúrgica', 'Ingeniería Ambiental', 'Ingeniería en Alimentos'];
  List<DropdownMenuItem<String>> getOpcionesDropdown1() {
    List<DropdownMenuItem<String>> lista = new List();
    _poderes1.forEach((poder) {
      lista.add(new DropdownMenuItem(
        child: Text(poder), // lo que se muestra
        value: poder,
      ));
    });
    return lista;
  }
  Widget _crearDropdown1() {
    return Row(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20),

          child: Text("Opción 1:"),
        ),
        SizedBox(width: 100.0,),
        Container(


          child: DropdownButton(
            value: _opcionSeleccionada1,
            items: getOpcionesDropdown(),
            onChanged: (opt){
              setState(() {
                _opcionSeleccionada1 = opt;
              });
            },
          ),
        )

      ],
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
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}

void AlertaExitoR({BuildContext context, String mensaje}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: new Text("Éxito."),
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
            onPressed: () {
              Navigator.pop(context);
              final route = MaterialPageRoute(
                builder: (context)=>Login(),
              );
              Navigator.push(context, route);
            },
          ),
        ],
      );
    },
  );
}
