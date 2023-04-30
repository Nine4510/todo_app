import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    getStorage();
  }

  Future<void> getStorage() async {
    toDos = await Storage().getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PRIMARY,
      body: SafeArea(
        child: Padding(
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
                  IconButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Modify(
                          modify: (ToDo todo) {
                            setState(() {
                              toDos.add(todo);
                              Storage().saveData(toDos);
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
                    child: CheckboxListTile(
                      title: Text(
                        toDos[index].keterangan,
                        style: TextStyle(
                          decoration: toDos[index].isComplete
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                      ),
                      value: toDos[index].isComplete,
                      activeColor: PURPLE,
                      onChanged: (value) {
                        setState(() {
                          toDos[index].isComplete = value!;
                        });
                      },
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
