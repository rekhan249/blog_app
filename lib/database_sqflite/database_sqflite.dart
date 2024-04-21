import 'package:blogs_app/models/auth_models/signin_model.dart';
import 'package:blogs_app/models/auth_models/signup_model.dart';
import 'package:blogs_app/models/blogs_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

class BlogsDatabase {
  static final BlogsDatabase instance = BlogsDatabase._init();
  static Database? _database;

  BlogsDatabase._init();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('blogs.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = "$filePath$dbPath";
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const blob = 'BLOB';
    await db.execute(
        'CREATE TABLE $tableBlogs (id $idType, $title $textType, $desc $textType, $datetime TEXT, $image $blob, $isSelected INTEGER)');

    await db.execute(
        'CREATE TABLE $tableUsers (id $idType, $username TEXT, $email $textType, $password $textType, $confirmPassoword TEXT)');
  }

  ///  *****************************************   ///
  ///  Database Name is blogs and their columns   ///
  /// *****************************************  ///

  static const String tableBlogs = 'blogs';
  static const String title = 'title';
  static const String desc = 'desc';
  static const String datetime = 'datetime';
  static const String image = 'image';
  static const String isSelected = 'isSelected';

  ///  *****************************************   ///
  ///  Database Name is users and their columns   ///
  /// *****************************************  ///

  static const String tableUsers = 'users';
  static const String username = 'username';
  static const String email = 'email';
  static const String password = 'password';
  static const String confirmPassoword = 'confirmPassoword';

  /// ***************************************************** ///
  ///   Create Table of blogs and Insert Data in Database  ///
  /// *************************************************** ///

  Future<void> create(Blogs blogs) async {
    final db = await instance.database;
    await db.insert(
      tableBlogs,
      blogs.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// ****************************************** ///
  ///   Read Data from Table blogs in Database  ///
  /// **************************************** ///
  Future<Blogs?> getSingleBlog(int id) async {
    final db = await instance.database;
    final maps = await db.rawQuery('SELECT * FROM blogs WHERE id = ?', [id]);
    Blogs? blogs;
    for (int id = 0; id < maps.length; id++) {
      blogs = Blogs.fromMap(maps[id]);
    }
    return blogs;
  }

  /// *********************************************** ///
  ///   Read All Data from Table blogs in Database   ///
  /// ********************************************* ///

  Future<List<Blogs>> readAllreadBlogs() async {
    final db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(tableBlogs);
    List<Blogs> blogsList =
        result.map((element) => Blogs.fromMap(element)).toList();
    print("====================${blogsList.map((e) => e.toMap())}");
    return blogsList;
  }

  /// *********************************************** ///
  ///   Search in Data from Table blogs in Database   ///
  /// ********************************************* ///

  Future<List<Blogs?>?> searchBlogs([String? searchQueary]) async {
    final db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(tableBlogs,
        where: 'title LIKE ?', whereArgs: ['%$searchQueary%']);
    List<Blogs>? blogsList = result.isEmpty
        ? []
        : result.map((element) => Blogs.fromMap(element)).toList();
    return blogsList;
  }

  /// ******************************************** ///
  ///   Update Data from Table blogs in Database  ///
  /// ****************************************** ///
  Future<int> updateData(Blogs blogs, int id) async {
    final db = await instance.database;
    return await db.rawUpdate(
      'UPDATE $tableBlogs SET title = ?, desc = ?, image = ? WHERE id = ?',
      [blogs.title, blogs.desc, blogs.image, id],
    );
  }

  /// ******************************************** ///
  ///   Delete Data from Table blogs in Database  ///
  /// ****************************************** ///
  Future<void> deleteData(int id) async {
    final db = await instance.database;
    try {
      await db.rawDelete('DELETE FROM blogs WHERE id = ?', [id]);
      Fluttertoast.showToast(msg: "Delete data successfully");
    } catch (e) {
      Fluttertoast.showToast(msg: "Something wrong$e");
    }
  }

  Future<void> deleteMultiple(List<int> id) async {
    final db = await instance.database;
    try {
      await db.delete(tableBlogs,
          where: 'id IN (${List.filled(id.length, '?').join(',')})',
          whereArgs: [id]);
      Fluttertoast.showToast(msg: "Delete data successfully");
    } catch (e) {
      Fluttertoast.showToast(msg: "Something wrong$e");
    }
  }

  /// ************************************************************ ///
  ///   Here are the fuctions of the auth authentication          ///
  /// *********************************************************** ///

  /// ***************************************************** ///
  ///   Create Table of blogs and Insert Data in Database  ///
  /// *************************************************** ///

  Future<void> createUserWhileSignUp(SignUpModel signUpModel) async {
    final db = await instance.database;
    await db.insert(tableUsers, signUpModel.toMap());
  }

  Future<void> createUserWhileSignIn(SignInModel signInModel) async {
    final db = await instance.database;
    await db.insert(tableUsers, signInModel.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// ****************************************** ///
  ///   Read Data from Table blogs in Database  ///
  /// **************************************** ///
  // Future<SignUpModel?> getSingleUser(int id) async {
  //   final db = await instance.database;
  //   final maps = await db.rawQuery('SELECT * FROM users WHERE id = ?', [id]);
  //   return maps.isNotEmpty ? SignUpModel.fromMap(maps.first) : null;
  // }

  /// *********************************************** ///
  ///   Read All Data from Table blogs in Database   ///
  /// ********************************************* ///

  // Future<List<SignUpModel>> readAllUsers() async {
  //   final db = await instance.database;
  //   final result = await db.query(tableBlogs);
  //   List<SignUpModel> blogsList = [];
  //   for (var element in result) {
  //     SignUpModel blogs = SignUpModel.fromMap(element);
  //     blogsList.add(blogs);
  //   }
  //   return blogsList;
  // }

  /// ******************************************** ///
  ///   Update Data from Table blogs in Database  ///
  /// ****************************************** ///
  // Future<int> updateUser(Blogs blogs, int id) async {
  //   final db = await instance.database;
  //   return await db.rawUpdate(
  //       'UPDATE $tableUsers SET title = ?, desc = ?, datetime = ?, image = ? WHERE id = ?',
  //       [blogs.title, blogs.desc, blogs.dateTime, blogs.image, id]);
  // }

  /// ******************************************** ///
  ///   Delete Data from Table blogs in Database  ///
  /// ****************************************** ///
  Future<void> deleteUser(int id) async {
    final db = await instance.database;
    try {
      await db.rawDelete('DELETE FROM $tableUsers WHERE id = ?', [id]);
    } catch (e) {
      Fluttertoast.showToast(msg: "Something wrong$e");
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
