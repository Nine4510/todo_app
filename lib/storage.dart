import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/todo.dart';

class Storage {
  Future<void> saveData(List<ToDo> todos) async {
    //menyiapkan shared preferences
    SharedPreferences pref = await SharedPreferences.getInstance();
    //menyimpan data sebagi list string
    await pref.setStringList('todos', todos.map((e) => jsonEncode(e)).toList());
    Fluttertoast.showToast(msg: "Data saved");
  }

  Future<List<ToDo>> getData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    //mengambil data dari shared preferences
    return pref.getStringList('todos')?.map((e) {
          //mengubah data menjadi objek
          return ToDo.fromJson(jsonDecode(e));
        }).toList() ??
        [];
  }
}
