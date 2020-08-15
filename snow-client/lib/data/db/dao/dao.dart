import 'package:sqflite/sqflite.dart';

abstract class Dao{
  Database database;
  Dao(this.database);

}