import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:restaurantbooking/JsonModels/users.dart';
import 'package:intl/intl.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  static Database? _database;

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'restaurantpack.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        userid INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        email TEXT,
        phone INTEGER,
        username TEXT,
        password TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE menubook (
        bookid INTEGER PRIMARY KEY AUTOINCREMENT,
        userid INTEGER,
        bookdate DATE,
        booktime TIME,
        eventdate DATE,
        eventtime TIME,
        menupackage TEXT,
        numguest INTEGER,
        packageprice DOUBLE,
        FOREIGN KEY (userid) REFERENCES users (userid)
      )
    ''');

    await db.execute('''
      CREATE TABLE administrator (
        adminid INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT
      )
    ''');
  }

  Future<void> insertUser(String name, String email, int phone, String username,
      String password) async {
    final db = await database;
    await db.insert(
      'users',
      {
        'name': name,
        'email': email,
        'phone': phone,
        'username': username,
        'password': password,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> getUserIdByUsername(String username) async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    if (results.isNotEmpty) {
      return results.first['userid'];
    }
    return -1; // Or handle error accordingly
  }

  Future<void> insertBooking(
      int userId,
      DateTime bookDateTime,
      DateTime eventDateTime,
      String menuPackage,
      int numGuest,
      double packagePrice) async {
    final db = await database;
    await db.insert(
      'menubook',
      {
        'userid': userId,
        'bookdate': DateFormat('yyyy-MM-dd').format(bookDateTime),
        'booktime': DateFormat('HH:mm:ss').format(bookDateTime),
        'eventdate': DateFormat('yyyy-MM-dd').format(eventDateTime),
        'eventtime': DateFormat('HH:mm:ss').format(eventDateTime),
        'menupackage': menuPackage,
        'numguest': numGuest,
        'packageprice': packagePrice,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Login
  Future<bool> login(Users user) async {
    final db = await database;

    // Check Password
    var result = await db.rawQuery(
        "SELECT * from users where username = '${user.username}' AND password = '${user.password}'");

    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  // Sign Up
  Future<int> signup(Users user) async {
    final db = await database;

    return db.insert('users', user.toMap());
  }
}
