// ignore: unused_import
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter/scheduler.dart';

class Note {
  // ignore: unused_field
  late int _id;
  // ignore: unused_field
  late String _title;
  // ignore: unused_field
  late String _description;
  // ignore: unused_field
  late String _date;
  // ignore: unused_field
  late int _priority;

  Note(this._title, this._date, this._priority, this._description);
  Note.withId(
      this._id, this._title, this._date, this._priority, this._description);

  // ALL the Getters

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  int get priority => _priority;

  // ALL the Setters

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 2) {
      this._priority = newPriority;
    }
  }
//Used to save and retrive from database
//convert note object to map object

  Map<String, dynamic> toMap() {
    // ignore: unused_local_variable, prefer_collection_literals
    var map = Map<String, dynamic>();
    // ignore: unnecessary_null_comparison
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;
    return map;
  }

  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
  }
}
