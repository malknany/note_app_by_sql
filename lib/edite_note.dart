import 'package:flutter/material.dart';
import 'package:task_cis_c2/homepage.dart';
import 'package:task_cis_c2/sql.dart';

class EditNote extends StatefulWidget {
  const EditNote({Key? key,required this.title,required this.note,required this.color,required this.id})
      : super(key: key);
  final title, note, color, id;

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  final note = TextEditingController();

  final title = TextEditingController();

  final color = TextEditingController();
  final MySql _mySql = MySql();

  @override
  void initState() {
    note.text = widget.note;
    title.text = widget.title;
    color.text = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'Edit Note',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // int response = await _mySql.upDateData('''
          //       UPDATE notes SET
          //       note = "${note.text}",
          //       title = "${title.text}",
          //       color = "${color.text}"
          //       WHERE  id = ${widget.id}
          //        ''');
          int response =await _mySql.upDate('notes', {
            'note': note.text,
            'title': title.text,
            'color': color.text
          }, 'id=${widget.id}');
          if (response > 0) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const MyHomePage(),
                ),
                (route) => false);
          }
        },
        backgroundColor: Colors.teal,
        child: const Icon(Icons.edit, color: Colors.white),
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
