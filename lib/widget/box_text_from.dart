import 'package:app_tarefa/style/custom_style_colors.dart';
import 'package:flutter/material.dart';

enum WhatValidator {
  email,
  passaWord,
  task,
  name,
}

class BoxTextFrom extends StatelessWidget {
  final WhatValidator? validatorOfType;
  final bool obscureText;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? label;
  final String? hintText;
  final double paddingBottom;
  final String? Function(String?)? validator;

  const BoxTextFrom({
    Key? key,
    this.obscureText = false,
    this.textInputType,
    this.controller,
    this.label,
    this.hintText,
    this.paddingBottom = 0,
    this.validator,
    this.validatorOfType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: paddingBottom),
      child: TextFormField(
        obscureText: obscureText,
        keyboardType: textInputType,
        controller: controller,
        validator: (value) => metodReturn(value),
        decoration: InputDecoration(
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: CustomStyleColors.red,
              width: 3,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: CustomStyleColors.red,
              width: 3,
            ),
          ),
          label: Text(label ?? ''),
          hintText: hintText,
          filled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: CustomStyleColors.whiter54,
              width: 3,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            borderSide: BorderSide(
              color: CustomStyleColors.blue,
              width: 3,
            ),
          ),
        ),
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }

  String? metodReturn(String? value) {
    print('>>>>>>>>>>>>>>>> entrou no switch');
    switch (validatorOfType) {
      case WhatValidator.email:
        if (value != null &&
            value.isEmpty &&
            !value.contains('@') &&
            !value.contains('.')) {
          return 'Formato do email valido';
        }
        return null;
      case WhatValidator.passaWord:
        if (value != null && value.length <= 6) {
          return 'O mínimo são 6 caracteres';
        }
        return null;

      case WhatValidator.task:
        if (value != null && value.length <= 4) {
          return 'O mínimo são 4 caracteres';
        }
        return null;

      case WhatValidator.name:
        if (value != null && !value.contains(' ') && value.length < 7) {
          return 'Por favor, escreva um nome igual ao exemplo';
        }
        return null;

      default:
        null;
    }
    return null;
  }
}
