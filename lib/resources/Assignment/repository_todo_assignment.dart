import 'package:app_tarefa/model/to_do.dart';
import 'package:app_tarefa/resources/Assignment/to_do_assignment.dart';

class ReposirotyToDoAssignment {
  final String collectionPath;
  ReposirotyToDoAssignment({required this.collectionPath});

  final ToDoAssignment _toDoAssignment = ToDoAssignment();
  void createNewassignment({
    required String assignment,
    required DateTime time,
    bool conclusion = false,
  }) =>
      _toDoAssignment.createNewAssignment(
          collectionPath: collectionPath, assignment: assignment, time: time);

  void todoIsDoneOrAlterTask({
    required String uidTask,
    bool? conclused,
    String? task,
  }) =>
      _toDoAssignment.toDoIsDoneOrAlterTask(
        collectionPath: collectionPath,
        idTask: uidTask,
        conclused: conclused,
        assignment: task,
      );

  void toDoDelete({required String uid}) => _toDoAssignment.toDoDelete(
        uid: uid,
        collectionPath: collectionPath,
      );

  void deleteAll({required List<ToDo> listOfToDo}) =>
      _toDoAssignment.toDoDeleteAll(
        collectionPath: collectionPath,
        listOfToDo: listOfToDo,
      );
}
