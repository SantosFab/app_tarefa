import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoAssignment {
  static const String task = 'task';
  static const String isConclused = 'isconclused';
  static const String timeSave = 'timeSave';
  static const String uid = 'uid';
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  createNewAssignment(
      {required String collectionPath,
      required String assignment,
      bool conclusion = false,
      required DateTime time}) {
    firestore.collection(collectionPath).doc().set({
      task: assignment,
      isConclused: conclusion,
      timeSave: time,
    });
  }

  toDoIsDoneOrAlterTask({
    required String collectionPath,
    required String idTask,
    bool? conclused,
    String? assignment,
  }) {
    if (assignment != null) {
      firestore.collection(collectionPath).doc(idTask).update({
        task: assignment,
      });
    } else if (conclused != null) {
      firestore.collection(collectionPath).doc(idTask).update({
        isConclused: conclused,
      });
    }
  }

  toDoDelete({required String uid, required String collectionPath}) {
    firestore.collection(collectionPath).doc(uid).delete();
  }
}
