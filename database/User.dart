import 'dart:async';
import 'dart:math';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:proyecto/database/db.dart';

Future<void> deleteUser(int id) async {
  // Get a reference to the database.
  final db = await crearDB();

  // Se remueve el ususario de la base de datos
  await db.delete(
    'users',
    // Se busca mediante ID el usuario de entrada para eliminarlo en la base de datos
    where: "id = ?",
    // Prevenimos inyeccion SQL
    whereArgs: [id],
  );
}

Future<void> updateUser(User user) async {
  // Get a reference to the database.
  final db = await crearDB();

  // Actualizamos el usuario obtenido.
  await db.update(
    'users',
    user.toMap(),
    // Nos aseguramos que el usuario de entrada coincida con uno en la base de datos por medio del ID
    where: "id = ?",
    // Se utiliza whereArgs para prevenir una inyecion SQL
    whereArgs: [user.id],
  );
}

Future<void> insertUser(User user) async {  // Creamos nuestra funcion para insertar en la tabla
  final Database db = await crearDB();
  List<Map<String, dynamic>> maps = await db.query('users');
  user.id= maps.length+1;
  // Insertamos el usuario en la tabla correcta.
  // Se usa 'ConflictAlgorithm' por si se inserta el mismo muchas veces
  // asi se reemplaza con el anterior

  // print(db.rawQuery("Select username FROM users WHERE username='$user.username'"));
  await db.insert(
    'users',
    user.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
Future<List<User>> users() async {
  // Get a reference to the database.
  final Database db = await crearDB();

  // Consultamos la tabla Usuarios en la base de datos
  final List<Map<String, dynamic>> maps = await db.query('users');
  print(maps.length);
  // Convertimos el List<Map<String, dynamic> a una List<User>.
  return List.generate(maps.length, (i) {
    return User(
      id: maps[i]['id'],
      username: maps[i]['username'],
      password: maps[i]['password'],
    );
  });
}

class User { // En esta clase creamos la estructura de datos del Usuario
  int id;
  final String username;
  final String password;

  User({this.id,this.username, this.password});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }
  @override
  String toString() {
    return 'User{id: $id, username: $username, password: $password}';
  }
}

Future<User> Logearse(User Usuario) async{
  final Database db = await crearDB();
  var nombre = Usuario.username;
  var pass = Usuario.password;
  var res = await db.rawQuery("SELECT * FROM users WHERE username = '$nombre' and password = '$pass'");
  if(res.length>0){

    return User(id: 0,username: nombre,password: pass);
  }
  return null;
}

Future<User> Validar(User Usuario) async{
  final Database db = await crearDB();
  var nombre = Usuario.username;
  var pass = Usuario.password;
  var res = await db.rawQuery("SELECT * FROM users WHERE username = '$nombre'");
  if(res.length>0){

    return User(id: 0,username: nombre);
  }
  return null;
}

