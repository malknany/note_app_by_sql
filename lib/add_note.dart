import 'package:flutter/material.dart';
import 'package:task_cis_c2/homepage.dart';
import 'package:task_cis_c2/sql.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final note = TextEditingController();

  final title = TextEditingController();

  final color = TextEditingController();
  final MySql _mySql = MySql();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Add Note',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // int response = await _mySql.insertData(
          //     '''
          //     INSERT INTO 'notes' ( 'note' , 'title' , 'color' )
          //     VALUES ('${note.text}','${title.text}','${color.text}')
          //      ''');
          int response = await _mySql.insert(
            'notes',
            {'note': note.text, 'title': title.text, 'color': color.text},
          );
          if (response > 0) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const MyHomePage(),
                ),
                (route) => false);
          }
        },
        backgroundColor: Colors.teal,
        child: const Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          TextFormField(
            controller: title,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: note,
            decoration: const InputDecoration(hintText: 'Note'),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: color,
            decoration: const InputDecoration(hintText: 'Color'),
          ),
        ],
      ),
    );
  }
}
