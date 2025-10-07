import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/address/page/new_address_page.dart';

import '../managers/address_bloc.dart';
import '../managers/address_event.dart';
import '../managers/address_state.dart';


class AddressPage extends StatefulWidget {
  const AddressPage({super.key});

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  int? selectedId;

  @override
  void initState() {
    super.initState();
    context.read<AddressBloc>().add(LoadAddresses());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Saved Address",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),

            // Scroll qilinadigan Cardlar
            Expanded(
              child: BlocBuilder<AddressBloc, AddressState>(
                builder: (context, state) {
                  if (state is AddressLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AddressLoaded) {
                    final addresses = state.addresses;

                    if (addresses.isEmpty) {
                      return const Center(child: Text("No addresses found"));
                    }

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: addresses.length,
                      itemBuilder: (context, index) {
                        final item = addresses[index];
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: const Icon(Icons.location_on_outlined),
                            title: Row(
                              children: [
                                Text(item.title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold)),
                                if (item.isDefault)
                                  Container(
                                    margin: const EdgeInsets.only(left: 6),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: const Text(
                                      "Default",
                                      style: TextStyle(
                                          fontSize: 10, color: Colors.black87),
                                    ),
                                  ),
                              ],
                            ),
                            subtitle: Text(item.fullAddress),
                            trailing: Radio<int>(
                              value: item.id,
                              groupValue: selectedId,
                              onChanged: (val) {
                                setState(() {
                                  selectedId = val;
                                });
                              },
                            ),
                          ),
                        );
                      },
                    );
                  } else if (state is AddressError) {
                    return Center(
                        child: Text("Error: ${state.message.toString()}"));
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),

            // 24 px bo‘sh joy
            const SizedBox(height: 24),

            // Add new address
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewAddressPage()));
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 20),
                    SizedBox(width: 8),
                    Text("Add New Address"),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Apply button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedId != null) {
                    print("Selected address id: $selectedId");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Apply",style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
