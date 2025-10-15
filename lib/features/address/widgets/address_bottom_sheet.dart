import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/address/widgets/show_diaolog_widget.dart';
import '../managers/address_bloc.dart';
import '../managers/address_event.dart';
import '../../../data/models/address_model.dart';
import 'add_button.dart';
import 'address_input_field.dart';
import 'address_nickname_dropdown.dart';
import 'coordinates_title.dart';
import 'default_checkbox.dart';


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

  final nicknames = ["Home", "Office", "Apartment"];

  bool get isButtonEnabled => nickname != null && addressController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Add Address", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Divider(height: 1),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Address Nickname", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 12),
                  AddressNicknameDropdown(
                    value: nickname,
                    items: ["Home", "Office", "Apartment"],
                    onChanged: (val) => setState(() => nickname = val),
                  ),
                  SizedBox(height: 24),
                  Text("Full Address", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  SizedBox(height: 12),
                  AddressInputField(
                    controller: addressController,
                    onChanged: (context) => setState(() {}),
                  ),
                  SizedBox(height: 16),
                  DefaultCheckbox(
                    value: isDefault,
                    onChanged: (val) => setState(() => isDefault = val),
                  ),
                  SizedBox(height: 16),
                  CoordinatesTile(
                    latitude: widget.latitude,
                    longitude: widget.longitude,
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: AddButton(
              isEnabled: isButtonEnabled,
              onPressed: () {
                final newAddress = Address(
                  id: DateTime.now().millisecondsSinceEpoch,
                  nickname: nickname!,
                  fullAddress: addressController.text,
                  isDefault: isDefault,
                  lat: widget.latitude,
                  lng: widget.longitude,
                );
                context.read<AddressBloc>().add(CreateAddressEvent(newAddress));
                showSuccessDialog(context, onClose: () {
                  Navigator.pop(context);
                });
              },
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
