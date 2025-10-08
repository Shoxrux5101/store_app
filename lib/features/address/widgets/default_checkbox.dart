import 'package:flutter/material.dart';

class DefaultCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const DefaultCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: value,
          onChanged: (val) => onChanged(val ?? false),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        const Expanded(
          child: Text("Make this as a default address", style: TextStyle(fontSize: 15)),
        ),
      ],
    );
  }
}
