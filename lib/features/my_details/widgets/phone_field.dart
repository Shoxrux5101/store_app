import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneField extends StatefulWidget {
  final TextEditingController controller;

  PhoneField({required this.controller});

  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  String _selectedCountry = '🇺🇸';
  String _selectedCode = '+1';

  final List<Map<String, String>> _countries = [
    {'flag': '🇺🇸', 'code': '+1'},
    {'flag': '🇬🇧', 'code': '+44'},
    {'flag': '🇷🇺', 'code': '+7'},
    {'flag': '🇺🇿', 'code': '+998'},
    {'flag': '🇹🇷', 'code': '+90'},
  ];

  void _selectCountry() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: _countries.map((country) {
            return ListTile(
              leading: Text(country['flag']!, style: TextStyle(fontSize: 28)),
              title: Text(country['code']!, style: TextStyle(fontSize: 16)),
              onTap: () {
                setState(() {
                  _selectedCountry = country['flag']!;
                  _selectedCode = country['code']!;
                });
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly, // faqat raqamlar
      ],
      validator: (v) {
        if (v == null || v.trim().isEmpty) return 'Telefon raqamni kiriting';
        if (v.length < 7) return 'Kamida 7 ta raqam kiriting';
        return null;
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 8, right: 12),
          child: GestureDetector(
            onTap: _selectCountry,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_selectedCountry, style: TextStyle(fontSize: 24)),
                SizedBox(width: 8),
                Icon(Icons.arrow_drop_down, color: Colors.black),
                SizedBox(width: 4),
                Text(
                  _selectedCode,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 8),
              ],
            ),
          ),
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
        hintText: '123 45 67',
        hintStyle: TextStyle(color: Colors.grey[400]),
        contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blueAccent, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}
