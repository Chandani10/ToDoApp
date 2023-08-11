import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final int? maxLength;
  final bool readOnly;
  final String? counterText;
  final TextInputAction textInputAction;
  final String? validator;
  final Function? onTabFunction;

  const TextFormFieldWidget({Key? key,
    this.controller,
    this.hintText,
    this.maxLength, this.readOnly = false, this.counterText, this.textInputAction = TextInputAction.next,
    this.validator, this.onTabFunction,


  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        maxLength: maxLength,
        keyboardType: TextInputType.text,
        controller: controller,readOnly: readOnly,
        textInputAction: textInputAction,
        onTap: onTabFunction== null ?(){}:(){
          onTabFunction!();
        },
        style: const TextStyle(
            fontFamily: 'Urbanist-Regular', fontSize: 16, color: Colors.black),
        decoration: InputDecoration(
          counterText: counterText,
            hintText: hintText,hintStyle: const TextStyle(fontFamily: 'Urbanist-Medium',
            fontSize: 16,
            color: Colors.black),
            contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
            labelStyle: const TextStyle(fontFamily: 'Urbanist-Medium',
                fontSize: 20,
                color: Colors.black),
        ));
  }
}
