import 'package:flutter/material.dart';

class AddressNicknameDropdown extends StatefulWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const AddressNicknameDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  State<AddressNicknameDropdown> createState() => _AddressNicknameDropdownState();
}

class _AddressNicknameDropdownState extends State<AddressNicknameDropdown> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value ?? "");
  }

  @override
  void didUpdateWidget(AddressNicknameDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _controller.text = widget.value ?? "";
    }
  }

  void _showDropdownMenu() async {
    final result = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(100, 400, 100, 0), // joylashuv
      items: widget.items
          .map((e) => PopupMenuItem<String>(
        value: e,
        child: Text(e),
      ))
          .toList(),
    );

    if (result != null) {
      _controller.text = result;
      widget.onChanged(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        labelText: "Address Nickname",
        hintText: "Type or select...",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.arrow_drop_down),
          onPressed: _showDropdownMenu,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
