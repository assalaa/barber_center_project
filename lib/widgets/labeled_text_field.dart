import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LabeledTextField extends StatelessWidget {
  const LabeledTextField({
    required this.controller,
    required this.title,
    required this.hintText,
    this.validatorText,
    this.textInputType = TextInputType.name,
    this.textInputFormatters,
    this.validator,
    this.enabled = true,
    super.key,
  });

  final TextEditingController controller;
  final String title;
  final String hintText;
  final String? validatorText;
  final String? Function(String?)? validator;
  final TextInputType textInputType;
  final List<TextInputFormatter>? textInputFormatters;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        keyboardType: textInputType,
        textInputAction: TextInputAction.next,
        inputFormatters: textInputFormatters ??
            (textInputType == TextInputType.phone
                ? [FilteringTextInputFormatter.digitsOnly]
                : null),
        validator: validator ??
            (value) {
              if (value!.isEmpty) {
                return validatorText;
              }
              return null;
            },
        decoration: InputDecoration(
          label: Text(title),
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 16),
          labelStyle: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
