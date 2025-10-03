import 'package:flutter/material.dart';

enum FieldType { text, email, password }

class InputField extends StatelessWidget {
  final FieldType type;
  final TextEditingController controller;
  final String? hintText;
  const InputField({
    super.key,
    this.type = FieldType.text,
    required this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          obscureText: type == FieldType.password,
          obscuringCharacter: "*",
          decoration: InputDecoration(labelText: hintText),
          validator: (value) {
            if (value?.trim().isEmpty == true || value == null) {
              return "$hintText is missing";
            }

            switch (type) {
              case FieldType.password:
                if (value.length < 5) {
                  return "Password must at least 5 character";
                }
                break;
              case FieldType.text:
                break;
              case FieldType.email:
                const emailRegex =
                    r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                    r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                    r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                    r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                    r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                    r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                    r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';

                if (!RegExp(emailRegex).hasMatch(value)) {
                  return "Invalid email address";
                }
            }

            return null;
          },
        ),
      ],
    );
  }
}
