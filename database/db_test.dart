import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  final database = openDatabase(
    // Se establece la ruta de la base de datos.
    join(await getDatabasesPath(), 'curso.db'),
    // Cuando la base de datos se crea, también crearemos una tabla para almacenar usuarios
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE users(id INTEGER PRIMARY KEY, username TEXT, password VARCHAR)",
      );
    },
    // Se establece la version. Esto ejecuta una funcion onCreate que provee
    // una ruta para hacer actualizar o regresar a una version de la base de datos

    version: 1, // Empezamos en la version 1 xdd
  );

  Future<void> insertUser(User user) async {  // Creamos nuestra funcion para insertar en la tabla
    final Database db = await database;

    // Insertamos el usuario en la tabla correcta.
    // Se usa 'ConflictAlgorithm' por si se inserta el mismo muchas veces
    // asi se reemplaza con el anterior
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<User>> users() async {
    // Get a reference to the database.
    final Database db = await database;

    // Consultamos la tabla Usuarios en la base de datos
    final List<Map<String, dynamic>> maps = await db.query('users');

    // Convertimos el List<Map<String, dynamic> a una List<User>.
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        username: maps[i]['username'],
        password: maps[i]['password'],
      );
    });
  }

  Future<void> updateUser(User user) async {
    // Get a reference to the database.
    final db = await database;

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

  Future<void> deleteUser(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Se remueve el ususario de la base de datos
    await db.delete(
      'users',
      // Se busca mediante ID el usuario de entrada para eliminarlo en la base de datos
      where: "id = ?",
      // Prevenimos inyeccion SQL
      whereArgs: [id],
    );
  }

  var alexito = User(  /// Creamos un Alexito de prueba xdd (un usuario, pues)
    id: 0,
    username: 'Alexhp17',
    password: 'futbol_17',
  );

  // Metemos a alexito a la base de datos con el metodo antes creado
  await insertUser(alexito);

  // Imprimimos la lista de usuarios, por ahora solo sale Alexito
  print(await users());

  // Actualizamos la contraseña de Alexito con el metodo antes creado
  alexito = User(
    id: alexito.id,
    username: 'Alexhp17',
    password: 'Futbo_20',
  );
  await updateUser(alexito);

  // Imprimimos la informacion actualizada
  print(await users());

  // Lo eliminamos alv
  await deleteUser(alexito.id);

  // Imprimimos para ver que ya no este el wey
  print(await users());
}

class User { // En esta clase creamos la estructura de datos del Usuario
  final int id;
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