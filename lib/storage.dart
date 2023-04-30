import 'dart:convert';
import 'dart:developer';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/todo.dart';

class Storage {
  Future<void> saveData(List<ToDo> todos) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setStringList('todos', todos.map((e) => jsonEncode(e)).toList());
    log(todos.map((e) => jsonEncode(e.toJson())).toList().first);
    Fluttertoast.showToast(msg: "Data saved");
  }

  Future<List<ToDo>> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref
            .getStringList('todos')
            ?.map((e) => ToDo.fromJson(jsonDecode(e)))
            .toList() ??
        [];
  }
}
