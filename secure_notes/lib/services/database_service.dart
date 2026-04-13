import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:securenotes/models/note.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, "notes.db");

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE notes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        description TEXT
      )
    ''');
  }

  Future<int> addNote(Note note) async {
    final db = await database;
    return await db.insert('notes', note.toMap());
  }

  Future<List<Note>> getAllNotes() async {
    final db = await database;
    final maps = await db.query('notes');

    return maps.map((e) => Note.fromMap(e)).toList();
  }

  Future<int> updateNote(Note note) async {
    final db = await database;

    return await db.update(
      'notes',
      note.toMap(),
      where: 'id = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> deleteNote(int id) async {
    final db = await database;

    return await db.delete('notes', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAllNotes() async {
    final db = await database;
    return await db.delete('notes');
  }
}
