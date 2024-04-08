import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreenController {
  static List todoListKeys = [];

  static var myBox = Hive.box('todoBox');
  static initKeys() {
    todoListKeys = myBox.keys.toList();
  }

  static Future addTask({required String title}) async {
    await myBox.add({
      "title": title,
    });
    todoListKeys = myBox.keys.toList();
  }

  static Future deleteTask(var key) async {
    await myBox.delete(key);
    todoListKeys = myBox.keys.toList();
  }

  static void editTask({required var key, required String title}) {
    myBox.put(key, {"title": title});
  }
}
