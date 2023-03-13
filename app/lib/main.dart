import 'dart:convert';

import 'package:app/create.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'note.dart';
import 'create.dart';
import 'update.dart';

const String url = "http://10.0.2.2:8000";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Django Flutter App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Client client = http.Client();
  List<Note> notes = [];

  @override
  void initState() {
    _retriveNotes();
    super.initState();
  }

  _retriveNotes() async {
    notes = [];
    List response =
        json.decode((await client.get(Uri.parse("$url/notes"))).body);
    response.forEach((element) {
      notes.add(Note.fromMap(element));
    });
    setState(() {});
  }

  void _deleteNote(int id) async {
    client.delete(Uri.parse("$url/notes/$id/delete"));
    await _retriveNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _retriveNotes();
        },
        child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(notes[index].note),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UpdatePage(
                      client: client,
                      id: notes[index].id,
                      note: notes[index].note,
                    ),
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteNote(notes[index].id),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CreatePage(
              client: client,
            ),
          ),
        ),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
