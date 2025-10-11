import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateField extends StatelessWidget {
  final TextEditingController controller;

  DateField({required this.controller});

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate = DateTime(1990, 7, 12);
    if (controller.text.isNotEmpty) {
      try {
        initialDate = DateFormat('MM/dd/yyyy').parse(controller.text);
      } catch (_) {}
    }
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) controller.text = DateFormat('MM/dd/yyyy').format(picked);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: AbsorbPointer(
        child: TextFormField(
          controller: controller,
          validator: (v) => v == null || v.isEmpty ? 'Iltimos, tug\'ilgan sanangizni kiriting' : null,
          decoration: InputDecoration(
            hintText: 'MM/DD/YYYY',
            suffixIcon: Icon(Icons.calendar_today_outlined, color: Colors.grey[600], size: 20),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[300]!)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.black, width: 2)),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ),
    );
  }
}
