import 'package:app_livros/models/livro.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'livros.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE livros(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            titulo TEXT,
            autor TEXT,
            genero TEXT,
            cor INTEGER,
            lido INTEGER,
            liked INTEGER,
            disliked INTEGER
          )
          ''');
      },
      version: 1,
    );
  }

  static Future<int> insertLivro(Livro livro) async {
    final db = await getDatabase();
    final id = await db.insert('livros', livro.toMap());

    print('Livro salvo no banco com ID: $id');

    return id;
  }

  static Future<List<Livro>> getLivros() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('livros');

    print('Livros encontrados no banco: ${maps.length}');
    print(maps);

    return maps.map((map) => Livro.fromMap(map)).toList();
  }

  static Future<void> updateLivro(Livro livro) async {
    final db = await getDatabase();
    await db.update(
      'livros',
      livro.toMap(),
      where: 'id = ?',
      whereArgs: [livro.id],
    );
  }

  static Future<void> deleteLivro(int id) async {
    final db = await getDatabase();
    await db.delete('livros', where: 'id = ?', whereArgs: [id]);
  }
}
