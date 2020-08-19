import 'package:imlib/imlib.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SnowIMDBHelper {
  SnowIMDBHelper._();

  static SnowIMDBHelper _instance = SnowIMDBHelper._();

  static SnowIMDBHelper getInstance() {
    return _instance;
  }

  static const String TABLE_CONVERSATION = "tb_conversation";
  static const String TABLE_CONVERSATION_COLUMN_ID = "id";
  static const String TABLE_CONVERSATION_COLUMN_CONVERSATION_ID = "conversation_id";
  static const String TABLE_CONVERSATION_COLUMN_TYPE = "type";
  static const String TABLE_CONVERSATION_COLUMN_UID_LIST = "uid_list";
  static const String TABLE_CONVERSATION_COLUMN_GROUP_ID = "group_id";
  static const String TABLE_CONVERSATION_COLUMN_READ_MESSAGE_ID = "read_msg_id";
  static const String TABLE_CONVERSATION_COLUMN_LAST_ID = "last_id";
  static const String TABLE_CONVERSATION_COLUMN_LAST_UID = "last_uid";
  static const String TABLE_CONVERSATION_COLUMN_LAST_TYPE = "last_type";
  static const String TABLE_CONVERSATION_COLUMN_LAST_CONTENT = "last_content";
  static const String TABLE_CONVERSATION_COLUMN_LAST_TIME = "last_time";
  static const String TABLE_CONVERSATION_COLUMN_TIME = "time";

  static const String _CREATE_CONVERSATION_TABLE = "CREATE TABLE $TABLE_CONVERSATION("
      "$TABLE_CONVERSATION_COLUMN_ID INTEGER PRIMARY KEY AUTOINCREMENT,"
      "$TABLE_CONVERSATION_COLUMN_CONVERSATION_ID TEXT NOT NULL UNIQUE,"
      "$TABLE_CONVERSATION_COLUMN_TYPE INTEGER,"
      "$TABLE_CONVERSATION_COLUMN_UID_LIST TEXT,"
      "$TABLE_CONVERSATION_COLUMN_GROUP_ID TEXT,"
      "$TABLE_CONVERSATION_COLUMN_READ_MESSAGE_ID TEXT,"
      "$TABLE_CONVERSATION_COLUMN_LAST_ID TEXT,"
      "$TABLE_CONVERSATION_COLUMN_LAST_UID TEXT,"
      "$TABLE_CONVERSATION_COLUMN_LAST_TYPE TEXT,"
      "$TABLE_CONVERSATION_COLUMN_LAST_CONTENT TEXT,"
      "$TABLE_CONVERSATION_COLUMN_LAST_TIME TEXT,"
      "$TABLE_CONVERSATION_COLUMN_TIME TEXT)";

  static final _version = 1;

  Future<Database> openDB(String uid) async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, uid + "_im.db");
    SLog.i("open db: $path");
    Database db = await openDatabase(path, version: _version, onUpgrade: _onUpgrade, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    SLog.i("DBHelper _onCreat() version: $_version");
    await db.execute(_CREATE_CONVERSATION_TABLE);
    db.close();
    SLog.i("DBHelper _onCreat() success: $_version");
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    SLog.i("DB Helper _onUpgrade() oldVersion = $oldVersion newVersion = $newVersion");
  }
}
