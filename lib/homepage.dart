import 'package:flutter/material.dart';
import 'package:task_cis_c2/add_note.dart';
import 'package:task_cis_c2/edite_note.dart';
import 'package:task_cis_c2/sql.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final MySql _mySql = MySql();
  List<Map> notes = [];
  bool isLoading = true;

  Future readData() async {
    // List<Map> response = await _mySql.readData("SELECT * FROM 'notes' ");
    List<Map> response = await _mySql.read('notes');
    notes.addAll(response);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.teal,
        title: const Text(
          'Home Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNote(),
              ));
        },
        backgroundColor: Colors.teal,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: isLoading
          ? const CircularProgressIndicator()
          : SizedBox(
              child: ListView(
                children: <Widget>[
                  ListView.builder(
                    itemCount: notes.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            '${notes[index]['title']}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.teal),
                          ),
                          subtitle: Text(
                            '${notes[index]['note']}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.teal),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  // int response = await _mySql.deleteData(
                                  //     "DELETE FROM notes WHERE id=${notes[index]['id']}");
                                  int response = await _mySql.delete(
                                      'notes', 'id=${notes[index]['id']}');
                                  if (response > 0) {
                                    notes.removeWhere((element) =>
                                        element['id'] == notes[index]['id']);
                                    setState(() {});
                                  } else {
                                    print("something wroing");
                                  }
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => EditNote(
                                      title: notes[index]['title'],
                                      color: notes[index]['color'],
                                      note: notes[index]['note'],
                                      id: notes[index]['id'],
                                    ),
                                  ));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
    );
  }
}

// Text(
//'${notes[index]['color']}',
//style: TextStyle(fontSize: 16, color: Colors.teal),
// )
//
// ElevatedButton(
//   onPressed: () async {
//     int response = await _mySql.insertData(
//         "INSERT INTO 'notes' ('note') VALUES ('note one') ");
//     print(response);
//   },
//   style: ElevatedButton.styleFrom(
//     padding: const EdgeInsets.symmetric(vertical: 5),
//     backgroundColor: Colors.teal,
//   ),
//   child: const Text(
//     'Insert Data',
//     style: TextStyle(fontSize: 15, color: Colors.white),
//   ),
// ),
//ElevatedButton(
//   onPressed: () async {
//     List<Map> response =
//         await _mySql.readData("SELECT * FROM 'notes' ");
//     print(response);
//   },
//   style: ElevatedButton.styleFrom(
//     padding: const EdgeInsets.symmetric(vertical: 5),
//     backgroundColor: Colors.teal,
//   ),
//   child: const Text(
//     'Read Data',
//     style: TextStyle(fontSize: 15, color: Colors.white),
//   ),
// ),
// ElevatedButton(
//   style: ElevatedButton.styleFrom(
//     padding: const EdgeInsets.symmetric(vertical: 5),
//     backgroundColor: Colors.teal,
//   ),
//   onPressed: () async {
//    setState(() {
//    });
//    int response = await _mySql
//        .deleteData("DELETE FROM 'notes' WHERE id = 5 ");
//     print(response);
//   },
//   child: const Text(
//     'Delate Data',
//     style: TextStyle(fontSize: 15, color: Colors.white),
//   ),
// ),
