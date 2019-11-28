import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
final tablaUsuarios ="CREATE TABLE users(id INTEGER PRIMARY KEY, username TEXT, password VARCHAR);";
final tablaAspirante ="CREATE TABLE aspirante(id INTEGER PRIMARY KEY, nombre VARCHAR, edad VARCHAR, sexo VARCHAR, correo VARCHAR, phone VARCHAR, escuela VARCHAR, op1 VARCHAR, op2 VARCHAR, op3 VARCHAR, date VARCHAR, sincronizado INT);";
Future<Database> crearDB() async{
  final database = openDatabase(
    // Se establece la ruta de la base de datos.
    join(await getDatabasesPath(), 'cursozsfe.db'),
    // Cuando la base de datos se crea, también crearemos una tabla para almacenar usuarios
    onCreate: (db, version) {
      db.execute(tablaUsuarios);
      db.execute(tablaAspirante);
    },
    // Se establece la version. Esto ejecuta una funcion onCreate que provee
    // una ruta para hacer actualizar o regresar a una version de la base de datos

    version: 1, // Nueva version, ahora es la 2 xd
  );
  return database;
}

