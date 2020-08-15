import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  DBHelper._();

  static DBHelper _instance = DBHelper._();

  static DBHelper getInstance() {
    return _instance;
  }

  static const String TABLE_USER = "tb_user";
  static const String TABLE_USER_COLUMN_ID = "id";
  static const String TABLE_USER_COLUMN_UID = "uid";
  static const String TABLE_USER_COLUMN_USER_NAME = "username";
  static const String TABLE_USER_COLUMN_CREATE_DATA = "create_dt";
  static const String TABLE_USER_COLUMN_UPDATE_DATA = "update_dt";
  static const String TABLE_USER_COLUMN_NAME = "name";
  static const String TABLE_USER_COLUMN_STATE = "state";
  static const String TABLE_USER_COLUMN_PORTRAIT = "portrait";
  static const String TABLE_USER_COLUMN_TYPE = "type";

  static const String _CREATE_USER_TABLE = "CREATE TABLE $TABLE_USER("
      "$TABLE_USER_COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,"
      "$TABLE_USER_COLUMN_UID TEXT NOT NULL UNIQUE,"
      "$TABLE_USER_COLUMN_USER_NAME TEXT,"
      "$TABLE_USER_COLUMN_CREATE_DATA TEXT,"
      "$TABLE_USER_COLUMN_UPDATE_DATA TEXT,"
      "$TABLE_USER_COLUMN_NAME TEXT,"
      "$TABLE_USER_COLUMN_STATE INTEGER,"
      "$TABLE_USER_COLUMN_PORTRAIT TEXT,"
      "$TABLE_USER_COLUMN_TYPE INTEGER)";

  static const String _CREATE_GROUP_TABLE = "";

  static final _version = 1;

  Future<Database> openDB(String uid) async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, uid+".db");
    print("open db: $path");
    Database db = await openDatabase(path, version: _version, onUpgrade: _onUpgrade, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    print("DBHelper _onCreat() version: $_version");
    await db.execute(_CREATE_USER_TABLE);
//    await db.execute(_CREATE_GROUP_TABLE);
    db.close();
    print("DBHelper _onCreat() success: $_version");
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("DB Helper _onUpgrade() oldVersion = $oldVersion newVersion = $newVersion");
  }
}
