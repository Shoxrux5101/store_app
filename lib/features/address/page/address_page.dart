import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/features/address/page/new_address_page.dart';
import 'package:store_app/features/home/widgets/cutom_app_bar.dart';

import '../../../core/routes/routes.dart';
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
      appBar: CustomAppBar(title: "Address"),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Saved Address",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<AddressBloc, AddressState>(
                builder: (context, state) {
                  if (state is AddressLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is AddressLoaded) {
                    final addresses = state.addresses;
                    if (addresses.isEmpty) {
                      return Center(child: Text("No addresses found"));
                    }
                      selectedId ??= addresses.first.id;
                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: addresses.length,
                      itemBuilder: (context, index) {
                        final item = addresses[index];
                        final isDefaultDisplay = index == 0;
                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            leading: Icon(Icons.location_on_outlined),
                            title: Row(
                              children: [
                                Text(item.nickname,
                                    style: TextStyle(fontWeight: FontWeight.bold)),
                                if (isDefaultDisplay)
                                  Container(
                                    margin: EdgeInsets.only(left: 6),
                                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      "Default",
                                      style: TextStyle(fontSize: 10, color: Colors.black87),
                                    ),
                                  ),
                              ],
                            ),
                            subtitle: Text(item.fullAddress),
                            trailing: Radio<int?>(
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
                    return Center(child: Text("Error: ${state.message.toString()}"));
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
            SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => NewAddressPage()));
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 20),
                    SizedBox(width: 8),
                    Text("Add New Address"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (selectedId != null) {
                    final state = context.read<AddressBloc>().state;
                    if (state is AddressLoaded) {
                      final selectedAddress = state.addresses
                          .firstWhere((addr) => addr.id == selectedId);
                      context.push(
                        Routes.checkOut,
                        extra: {
                          'subtotal': 0.0,
                          'address': selectedAddress,
                        },
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select an address')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text("Apply",style: TextStyle(color: Colors.white),),
              ),
            ),
            SizedBox(height: 25,),
          ],
        ),
      ),
    );
  }
}
