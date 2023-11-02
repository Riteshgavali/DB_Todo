import 'package:flutter/material.dart';
// ignore: unused_import
import 'dart:async';
import '../database_helper.dart';
import '../Note.dart';
// ignore: unused_import
import 'Note_details.dart';
// ignore: unused_import
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget {
  const NoteList({super.key});

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  late List<Note> noteList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("RG's ToDo"),
        backgroundColor: Colors.purple,
      ),
      body: getNoteListView(),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          child: Icon(Icons.add),
          onPressed: () {
            navigateToDetail(Note('', '', 2, ''), 'Add Note');
          }),
    );
  }
}

ListView getNoteListView() {
  return ListView.builder(
    itemCount: count,
    itemBuilder: (context, position) {
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.deepPurple,
        elevation: 4.0,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage:
                NetworkImage("https:/learncodeonline.in/mascot.png"),
          ),
          title: Text(
            this.noteList[position].title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          trailing: GestureDetector(
            child: Icon(
              Icons.open_in_new,
              color: Colors.white,
            ),
            onTap: () {
              navigateToDetail(this.noteList[position], 'Edit ToDo');
            },
          ),
          subtitle: Text(this.noteList[position].date),
        ),
      );
    },
  );
}

void navigateToDetail(Note note, String title) async {
  // ignore: unused_local_variable
  BuildContext context;
  bool result = await Navigator.push(
    BuildContext as BuildContext,
    MaterialPageRoute(
      builder: (context) {
        return NoteDetail(note, title);
      },
    ),
  );
  if (result == true) {}

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initalizeDatabase();

    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((NoteList) {
        SetState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}
