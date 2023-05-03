import 'package:flutter/material.dart';
import 'package:todo_app/dialog.dart';
import 'package:todo_app/global.dart';
import 'package:todo_app/modify.dart';
import 'package:todo_app/storage.dart';
import 'package:todo_app/todo.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ToDo> toDos = [];
  final storage = Storage();

  @override
  void initState() {
    super.initState();
    getStorage();
  }

  //todo: Menyimpan data ke database lokal
  Future<void> getStorage() async {
    var temp = await Storage().getData();
    setState(() {
      toDos = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: PRIMARY,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 14, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      "My ToDo's",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 34,
                      ),
                    ),
                  ),
                  //todo: Tombol untuk membuka tampilan untuk menambah data
                  IconButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Modify(
                          //todo: Kode untuk menambahkan data ke list
                          modify: (ToDo todo) {
                            setState(() {
                              toDos.add(todo);
                              storage.saveData(toDos);
                            });
                          },
                        ),
                      ),
                    ),
                    splashColor: SECONDARY,
                    icon: const Icon(Icons.add),
                    iconSize: 40,
                    splashRadius: 24,
                  )
                ],
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                itemCount: toDos.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: SECONDARY,
                    clipBehavior: Clip.antiAlias,
                    child: Dismissible(
                      key: UniqueKey(),
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Modify(
                                modify: (todo) async {
                                  toDos[index] = todo;
                                  await storage.saveData(toDos);
                                  setState(() => toDos);
                                },
                                todo: toDos[index],
                              ),
                            ),
                          );
                          return false;
                        } else {
                          bool? result = await showDeleteDialog(context);
                          if (result ?? false) {
                            toDos.removeAt(index);

                            await storage.saveData(toDos);

                            setState(() => toDos);
                          }
                          return result;
                        }
                      },
                      background: Container(
                        padding: const EdgeInsets.all(12),
                        alignment: Alignment.centerLeft,
                        color: Colors.green,
                        child: const Icon(Icons.edit),
                      ),
                      secondaryBackground: Container(
                        padding: const EdgeInsets.all(12),
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: const Icon(Icons.delete),
                      ),
                      child: CheckboxListTile(
                        title: Text(
                          toDos[index].kegiatan,
                          style: TextStyle(
                            decoration: toDos[index].isComplete
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                        subtitle: Text(toDos[index].keterangan),
                        value: toDos[index].isComplete,
                        activeColor: PURPLE,
                        onChanged: (value) {
                          setState(() {
                            toDos[index].isComplete = value!;
                            storage.saveData(toDos);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
