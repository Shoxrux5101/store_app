import 'package:flutter/material.dart';

class GenderDropdown extends StatelessWidget {
  final List<String> genders;
  final String selectedGender;
  final ValueChanged<String> onChanged;

  GenderDropdown({
    required this.genders,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // har doim oq fon
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedGender,
          isExpanded: true,
          dropdownColor: Colors.white,
          focusColor: Colors.transparent,
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          items: genders.map((gender) {
            return DropdownMenuItem<String>(
              value: gender,
              child: Text(gender),
            );
          }).toList(),
          onChanged: (value) => onChanged(value!),
        ),
      ),
    );
  }
}
