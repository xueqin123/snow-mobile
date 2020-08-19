import 'package:sqflite/sqflite.dart';

abstract class SnowIMDao{
  Database database;
  SnowIMDao(this.database);
}