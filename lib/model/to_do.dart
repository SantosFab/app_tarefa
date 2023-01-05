// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:app_tarefa/resources/Assignment/to_do_assignment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ToDo {
  final String _uid;
  final String _task;
  final bool _isConclused;
  final DateTime _timeSave;
  ToDo(
    this._uid,
    this._task,
    this._isConclused,
    this._timeSave,
  );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      ToDoAssignment.uid: _uid,
      ToDoAssignment.task: _task,
      ToDoAssignment.isConclused: _isConclused,
      ToDoAssignment.timeSave: _timeSave.millisecondsSinceEpoch,
    };
  }

  factory ToDo.fromMap(Map<String, dynamic> map) {
    return ToDo(
      map[ToDoAssignment.uid] as String,
      map[ToDoAssignment.task] as String,
      map[ToDoAssignment.isConclused] as bool,
      DateTime.parse(map[ToDoAssignment.timeSave].toDate().toString()),
    );
  }

  String toJson() => json.encode(toMap());

  static listfromQuerySnapshot(
      {required QuerySnapshot<Map<String, dynamic>>? snapshot}) {
    List<ToDo> list = [];
    snapshot!.docs.map((e) {
      Map<String, dynamic> map = e.data();
      map[ToDoAssignment.uid] = e.id;
      ToDo todo = ToDo.fromMap(map);
      list.add(todo);
    }).toList();
    return list;
  }

  String get uid => _uid;
  String get task => _task;
  bool get conclused => _isConclused;
  String get timeSave {
    return DateFormat("HH:mm dd-MM-yy")
        .format(DateTime.parse(_timeSave.toString()).toLocal());
  }
}
