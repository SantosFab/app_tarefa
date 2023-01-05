import 'package:app_tarefa/model/to_do.dart';
import 'package:app_tarefa/resources/Assignment/repository_todo_assignment.dart';
import 'package:app_tarefa/resources/Assignment/to_do_assignment.dart';
import 'package:app_tarefa/resources/login/repository_login_firebaseauth.dart';
import 'package:app_tarefa/style/custom_style_colors.dart';
import 'package:app_tarefa/utils/utils_show_dialog.dart';
import 'package:app_tarefa/view/toDoList/drawer_page.dart';
import 'package:app_tarefa/widget/widget_dismissible.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ToDoListPage extends StatefulWidget {
  const ToDoListPage({Key? key}) : super(key: key);

  @override
  State<ToDoListPage> createState() => _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  late final TextEditingController _controllerAlterToDo;
  late final TextEditingController _controllerCreateTodo;
  late final ReposirotyToDoAssignment _repositorytoDoAssignment;
  late final RepositoryLoginFireBaseAuth _repositoryloginFireBaseAuth;

  @override
  void initState() {
    super.initState();
    _controllerAlterToDo = TextEditingController();
    _controllerCreateTodo = TextEditingController(text: 'Tarefas');
    _repositoryloginFireBaseAuth = RepositoryLoginFireBaseAuth();
    _repositorytoDoAssignment = ReposirotyToDoAssignment(
      collectionPath: _repositoryloginFireBaseAuth.idUser(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tarefas'),
      ),
      drawer: const DrawerPage(),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection(_repositoryloginFireBaseAuth.idUser())
              .orderBy(ToDoAssignment.timeSave)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<ToDo> list =
                  ToDo.listfromQuerySnapshot(snapshot: snapshot.data);
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return WidgetDismissible(
                    keyOfDismissible: list[index].uid,
                    funcaoDelete: () => _repositorytoDoAssignment.toDoDelete(
                      uid: list[index].uid,
                    ),
                    funcaoEdit: () {
                      _controllerAlterToDo.text = list[index].task;
                      showDialogAlterTask(
                        context,
                        controller: _controllerAlterToDo,
                        funccaoConfirm: () {
                          _repositorytoDoAssignment.todoIsDoneOrAlterTask(
                            uidTask: list[index].uid,
                            task: _controllerAlterToDo.text,
                          );
                          Navigator.of(context).pop();
                        },
                      );
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(list[index].task),
                        leading: IconButton(
                          icon: list[index].conclused
                              ? const Icon(Icons.check_box)
                              : const Icon(
                                  Icons.check_box_outline_blank_outlined),
                          onPressed: () {
                            if (list[index].conclused) {
                              _repositorytoDoAssignment.todoIsDoneOrAlterTask(
                                uidTask: list[index].uid,
                                conclused: false,
                              );
                            } else {
                              _repositorytoDoAssignment.todoIsDoneOrAlterTask(
                                uidTask: list[index].uid,
                                conclused: true,
                              );
                            }
                          },
                        ),
                        subtitle: Text(list[index].timeSave),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasData) {
              return const Center(
                child: Text(
                  'Ocorreu um error, por favor entre em contato com o desenvolver',
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomStyleColors.whiter,
        onPressed: () => showDialogAddNewTodo(
          context,
          controller: _controllerCreateTodo,
          funcaoFloatAdd: () {
            _repositorytoDoAssignment.createNewassignment(
              assignment: _controllerCreateTodo.text,
              time: DateTime.now(),
            );
            _controllerAlterToDo.clear();
            Navigator.of(context).pop();
          },
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
