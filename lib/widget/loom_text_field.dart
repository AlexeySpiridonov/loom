import 'package:flutter/material.dart';

class LoomTextField extends StatelessWidget {
  const LoomTextField({
    Key? key,
    required this.initialValue,
    required this.onChanged,
    required this.labelText,
    this.autofocus,
  }) : super(key: key);

  final String initialValue;
  final Function(String)? onChanged;
  final String labelText;
  final bool? autofocus;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      autofocus: autofocus ?? false,
      decoration: InputDecoration(
        labelText: labelText,
        contentPadding:
            const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.purple, width: 0),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
