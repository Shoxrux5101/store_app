import 'package:flutter/material.dart';

class NewAddressWidget extends StatefulWidget {
  const NewAddressWidget({super.key});

  @override
  State<NewAddressWidget> createState() => _NewAddressWidgetState();
}

class _NewAddressWidgetState extends State<NewAddressWidget> {
  final TextEditingController addressController = TextEditingController();
  String? nickname;
  bool isDefault = false;

  final List<String> nicknames = ["Home", "Office", "Apartment", "Parent's House"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Address"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Map placeholder
          Container(
            height: 250,
            color: Colors.grey.shade300,
            child: const Center(
              child: Icon(Icons.location_pin, size: 48, color: Colors.black),
            ),
          ),

          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Address",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 16),

                  // Nickname Dropdown
                  DropdownButtonFormField<String>(
                    value: nickname,
                    decoration: const InputDecoration(
                      labelText: "Address Nickname",
                      border: OutlineInputBorder(),
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
                  const SizedBox(height: 16),

                  // Full Address Field
                  TextField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      labelText: "Full Address",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 8),

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
                      ),
                      const Text("Make this as a default address")
                    ],
                  ),

                  const Spacer(),

                  // Add button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Bloc orqali createAddress chaqiriladi
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text("Add"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
