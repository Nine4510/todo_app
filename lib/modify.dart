import 'package:flutter/material.dart';

import 'package:todo_app/global.dart';
import 'package:todo_app/todo.dart';

class Modify extends StatelessWidget {
  final Function(ToDo) modify;
  final ToDo todo;

  Modify({Key? key, required this.modify, ToDo? todo})
      : todo = todo ?? ToDo('', '', false),
        super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: PRIMARY,
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: Colors.transparent,
              body: Padding(
                padding: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(6, 10, 6, 0),
                  child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(Icons.chevron_left),
                              iconSize: 40,
                              splashRadius: 24,
                            ),
                            const Text(
                              'Catatan',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 34,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          initialValue: todo.kegiatan,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelText: 'Kegiatan',
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                          ),
                          onChanged: (newValue) => todo.kegiatan = newValue,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Kegiatan tidak boleh kosong";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          initialValue: todo.keterangan,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            labelText: 'Keterangan',
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                          ),
                          onChanged: (newValue) => todo.keterangan = newValue,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Keterangan tidak boleh kosong";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              modify(todo);
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: RED,
                              padding: const EdgeInsetsDirectional.symmetric(
                                  vertical: 14, horizontal: 20),
                            ),
                            icon: const Icon(Icons.save),
                            label: const SizedBox(child: Text('Simpan')),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'shared/background.png',
                height: 300,
                fit: BoxFit.fitHeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
