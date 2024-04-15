import 'package:blogs_app/models/blogs_model.dart';
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
    await db.execute('''
      CREATE TABLE $tableBlogs ( 
      ${BlogsFields.id} $idType,
      ${BlogsFields.title} $textType,
      ${BlogsFields.desc} $textType,
      ${BlogsFields.dateTime} $textType,
      ${BlogsFields.image} image BLOB
      )
    ''');
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

  /// ******************************************** ///
  ///   Create Table and Insert Data in Database  ///
  /// ****************************************** ///

  Future<Blogs> create(Blogs blogs) async {
    final db = await instance.database;
    final id = await db.insert(tableBlogs, blogs.toMap());
    return blogs.copy(id: id);
  }

  /// ************************************ ///
  ///   Read Data from Table in Database  ///
  /// ********************************** ///

  Future<Blogs> readBlog(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      tableBlogs,
      columns: BlogsFields.values,
      where: '${BlogsFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return Blogs.fromMap(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  /// ***************************************** ///
  ///   Read All Data from Table in Database   ///
  /// *************************************** ///

  Future<List<Blogs>> readAllreadBlogs() async {
    final db = await instance.database;
    final result = await db.query(tableBlogs);
    List<Blogs> blogsList = [];
    for (var element in result) {
      Blogs blogs = Blogs.fromMap(element);
      print("object ${blogs.toMap()}");
      blogsList.add(blogs);
    }
    return blogsList;
  }

  /// ************************************** ///
  ///   Update Data from Table in Database  ///
  /// ************************************ ///

  Future<int> update(Blogs blogs) async {
    final db = await instance.database;
    return db.update(
      tableBlogs,
      blogs.toMap(),
      where: '${BlogsFields.id} = ?',
      whereArgs: [blogs.id],
    );
  }

  /// ************************************** ///
  ///   Delete Data from Table in Database  ///
  /// ************************************ ///

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.delete(
      tableBlogs,
      where: '${BlogsFields.id} = ?',
      whereArgs: [id],
    );
  }
}

const String tableBlogs = 'blogs';

class BlogsFields {
  static final List<String> values = [
    /// Add all fields
    id, title, desc, dateTime, image
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String desc = 'desc';
  static const String dateTime = 'dateTime';
  static const String image = 'image';
}
