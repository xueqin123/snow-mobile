import 'package:sqflite/sqflite.dart';

abstract class Dao{
  Database database;
  String currentUid;
  Dao(this.database,this.currentUid);

}