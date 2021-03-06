import 'package:imlib/imlib.dart';
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

  static const String TABLE_GROUP = "tb_group";
  static const String TABLE_GROUP_COLUMN_ID = "id";
  static const String TABLE_GROUP_COLUMN_GROUP_ID = "group_id";
  static const String TABLE_GROUP_COLUMN_NAME = "name";
  static const String TABLE_GROUP_COLUMN_PORTRAIT = "portrait";
  static const String TABLE_GROUP_COLUMN_CONVERSATION_ID = "conversation_id";
  static const String TABLE_GROUP_COLUMN_OWNER_ID = "owner_uid";
  static const String TABLE_GROUP_COLUMN_STATUS = "status";
  static const String TABLE_GROUP_COLUMN_UPDATE_DATA = "update_dt";

  static const String TABLE_GROUP_MEMBER = "tb_group_member";
  static const String TABLE_GROUP_MEMBER_COLUMN_ID = "id";

  static const String TABLE_GROUP_MEMBER_COLUMN_GROUP_ID = "group_id";
  static const String TABLE_GROUP_MEMBER_COLUMN_MEMBER_ID = "uid";
  static const String TABLE_GROUP_MEMBER_COLUMN_UPDATE_DATA = "update_dt";
  static const String TABLE_GROUP_MEMBER_COLUMN_STATUS = "status";

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
  static final _version = 1;

  Future<Database> openDB(String uid) async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, uid + ".db");
    SLog.i("open db: $path");
    Database db = await openDatabase(path, version: _version, onUpgrade: _onUpgrade, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    SLog.i("DBHelper _onCreat() version: $_version");
    await db.execute(_CREATE_USER_TABLE);
    db.close();
    SLog.i("DBHelper _onCreat() success: $_version");
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    SLog.i("DB Helper _onUpgrade() oldVersion = $oldVersion newVersion = $newVersion");
  }
}
