import 'dart:async';
import 'dart:math';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:proyecto/db.dart';


class Aspirante{

  int id;
  final String nombre;
  final String apellidoP;
  final String apellidoM;
  final String sexo;
  final int edad;
  final String email;
  final String movil;
  final String procedencia;
  final String op1;
  final String op2;
  final String op3;
  final String fechaR;

  Aspirante({ this.id,
              this.nombre,
              this.apellidoP,
              this.apellidoM,
              this.sexo,
              this.edad,
              this.email,
              this.movil,
              this.procedencia,
              this.op1,
              this.op2,
              this.op3,
              this.fechaR});

  Map<String, dynamic> toMap(){
    return {
    'id':id,
    'nombre':nombre,
    'apellidop':apellidoP,
    'apellidom':apellidoM,
    'sexo':sexo,
    'edad':edad,
    'email':email,
    'movil':movil,
    'procedencia':procedencia,
    'op1':op1,
    'op2':op2,
    'op3':op3,
    'fechar':fechaR
  };
  }
  @override
  String toString(){
    return 'Apirante( id:$id, nombre: $nombre, apellidoP: $apellidoP, apellidoM: $apellidoM, sexo: $sexo, edad: $edad, email: $email, movil: $movil, procedencia: $procedencia, op1: $op1, op2: $op2, op3: $op3, fechaR: $fechaR)';
  }
}

Future<void> deleteAspirante(int id) async {
  // Get a reference to the database.
  final db = await crearDB();

  // Se remueve el aspirante de la base de datos
  await db.delete(
    'aspirantes',
    // Se busca mediante ID el aspirante de entrada para eliminarlo en la base de datos
    where: "id = ?",
    // Prevenimos inyeccion SQL
    whereArgs: [id],
  );
}

Future<void> updateAspirante(Aspirante aspirante) async {
  // Get a reference to the database.
  final db = await crearDB();

  // Actualizamos el aspirante obtenido.
  await db.update(
    'aspirantes',
    aspirante.toMap(),
    // Nos aseguramos que el aspirante de entrada coincida con uno en la base de datos por medio del ID
    where: "id = ?",
    // Se utiliza whereArgs para prevenir una inyecion SQL
    whereArgs: [aspirante.id],
  );
}

Future<void> insertAspirante(Aspirante aspirante) async {  // Creamos nuestra funcion para insertar en la tabla
  final Database db = await crearDB();
  List<Map<String, dynamic>> maps = await db.query('aspirantes');
  aspirante.id= maps.length+1;
  // Insertamos el aspirante en la tabla correcta.
  // Se usa 'ConflictAlgorithm' por si se inserta el mismo muchas veces
  // asi se reemplaza con el anterior

  // print(db.rawQuery("Select username FROM users WHERE username='$user.username'"));
  await db.insert(
    'users',
    aspirante.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}
Future<List<Aspirante>> aspirantex() async {
  // Get a reference to the database.
  final Database db = await crearDB();

  // Consultamos la tabla aspirantes en la base de datos
  final List<Map<String, dynamic>> maps = await db.query('aspirantes');
  print(maps.length);
  // Convertimos el List<Map<String, dynamic> a una List<Aspirante>.
  return List.generate(maps.length, (i) {
    return Aspirante(
      id: maps[i]['id'],
      nombre: maps[i]['nombre'],
      apellidoP: maps[i]['apellidoP'],
      apellidoM: maps[i]['apellidoM'],
      edad: maps[i]['edad'],
      sexo: maps[i]['sexo'],
      email: maps[i]['email'],
      movil: maps[i]['movil'],
      procedencia: maps[i]['procedencia'],
      op1: maps[i]['op1'],
      op2: maps[i]['op2'],
      op3: maps[i]['op3'],
      fechaR: maps[i]['fechaR'],
    );
  });
}