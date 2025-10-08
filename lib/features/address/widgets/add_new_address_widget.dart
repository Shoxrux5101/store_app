import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/address/managers/address_bloc.dart';

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
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            color: Colors.grey.shade300,
            child: Center(
              child: Icon(Icons.location_pin, size: 48, color: Colors.black),
            ),
          ),

          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Address",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 16),
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
                  SizedBox(height: 16),
                  TextField(
                    controller: addressController,
                    decoration: const InputDecoration(
                      labelText: "Full Address",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 8),
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
                      Text("Make this as a default address")
                    ],
                  ),
                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<AddressBloc>();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text("Add"),
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
