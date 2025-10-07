import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../managers/address_bloc.dart';
import '../managers/address_event.dart';
import '../../../data/models/address_model.dart';

class AddressBottomSheet extends StatefulWidget {
  final double latitude;
  final double longitude;

  const AddressBottomSheet({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  @override
  State<AddressBottomSheet> createState() => _AddressBottomSheetState();
}

class _AddressBottomSheetState extends State<AddressBottomSheet> {
  final TextEditingController addressController = TextEditingController();
  String? nickname;
  bool isDefault = false;

  final List<String> nicknames = [
    "Home",
    "Office",
    "Apartment",
    "Parent's House"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Address",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Form content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Address Nickname",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Nickname Dropdown
                  DropdownButtonFormField<String>(
                    value: nickname,
                    decoration: InputDecoration(
                      hintText: "Choose one",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                    items: nicknames
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        nickname = val;
                      });
                    },
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    "Full Address",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Full Address Field
                  TextField(
                    controller: addressController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Enter your full address...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Default Checkbox
                  Row(
                    children: [
                      Checkbox(
                        value: isDefault,
                        onChanged: (val) {
                          setState(() {
                            isDefault = val!;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const Text(
                        "Make this as a default address",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Display coordinates
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.my_location, size: 16, color: Colors.grey),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            "Lat: ${widget.latitude.toStringAsFixed(6)}, Lon: ${widget.longitude.toStringAsFixed(6)}",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Add button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (nickname != null && addressController.text.isNotEmpty) {
                    final newAddress = Address(
                      id: DateTime.now().millisecondsSinceEpoch,
                      title: nickname!,
                      fullAddress: addressController.text,
                      isDefault: isDefault,
                      lat: widget.latitude,
                      lng: widget.longitude,
                    );

                    context.read<AddressBloc>().add(CreateAddressEvent(newAddress));
                    Navigator.pop(context); // Close bottom sheet
                    Navigator.pop(context); // Go back to address list
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill all fields"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: nickname != null && addressController.text.isNotEmpty
                      ? Colors.black
                      : Colors.grey.shade400,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Add",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }
}