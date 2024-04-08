import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

@HiveType(typeId: 1)
class TodoModel {
  @HiveField(0)
  String title;

  TodoModel({required this.title});
}
