import 'package:app_tarefa/style/custom_style_text.dart';
import 'package:app_tarefa/widget/box_text_from.dart';
import 'package:flutter/material.dart';

Future _baseShowDialog(
  context, {
  required Widget widget,
  double height = 320,
}) {
  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            margin: MediaQuery.of(context).viewInsets,
            padding: const EdgeInsets.all(8),
            height: height,
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: widget,
          )
        ],
      );
    },
  );
}

Future showdialogCreateUser(
  context, {
  TextEditingController? controllerCreateNewUserName,
  TextEditingController? controllerCreateNewUserEmail,
  TextEditingController? controllerCreateNewUserPassWord,
  void Function()? onPressedOfCreate,
  void Function()? onPressedOfCancel,
}) {
  return _baseShowDialog(
    context,
    widget: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text(
          'Para realizar o cadastro, preenchar, logo abaixo, o seu email e senha.',
          textAlign: TextAlign.center,
          style: CustomStyleText.textCreateUser,
        ),
        Material(
          child: BoxTextFrom(
            label: 'Nome e Sobrenome',
            hintText: 'José Santos',
            textInputType: TextInputType.name,
            controller: controllerCreateNewUserName,
          ),
        ),
        Material(
          child: BoxTextFrom(
            label: 'Digite seu e-mail',
            hintText: 'Ex: exemplo@exemplo.com',
            textInputType: TextInputType.emailAddress,
            controller: controllerCreateNewUserEmail,
          ),
        ),
        Material(
          child: BoxTextFrom(
            label: 'Crie uma senha',
            obscureText: true,
            textInputType: TextInputType.emailAddress,
            controller: controllerCreateNewUserPassWord,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: onPressedOfCreate,
              child: const Text('Cadastrar'),
            ),
            TextButton(
              onPressed: onPressedOfCancel,
              child: const Text('Cancelar'),
            ),
          ],
        )
      ],
    ),
  );
}

showDialogAddNewTodo(
  context, {
  TextEditingController? controller,
  void Function()? funcaoFloatAdd,
}) {
  return _baseShowDialog(
    context,
    height: 100,
    widget: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: Material(
            child: BoxTextFrom(
              label: 'Nova Tarefas',
              hintText: 'Por favor, digite a nova tarefa',
              controller: controller,
            ),
          ),
        ),
        Material(
          child: IconButton(
            icon: const Icon(Icons.add),
            onPressed: funcaoFloatAdd,
          ),
        ),
      ],
    ),
  );
}

//O flutter_slidable: ^2.0.0 não ficou muito compatível com o showdialog, por isso crie um manualmente
Future showDialogAlterTask(
  context, {
  required TextEditingController? controller,
  required void Function() funccaoConfirm,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 20,
              right: 20,
            ),
            height: 185,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 15),
                  child: Text(
                    'Deseja alterar a tarefa?',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Material(
                  child: BoxTextFrom(
                    controller: controller,
                    label: 'Tarefa',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: funccaoConfirm,
                      child: const Text('Confirmar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}
