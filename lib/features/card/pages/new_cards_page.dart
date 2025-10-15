import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/home/widgets/custom_button.dart';
import 'package:store_app/features/home/widgets/cutom_app_bar.dart';
import '../managers/card_bloc.dart';
import '../managers/card_event.dart';
import '../managers/card_state.dart';

class NewCardPage extends StatefulWidget {
  NewCardPage({super.key});

  @override
  State<NewCardPage> createState() => _NewCardPageState();
}

class _NewCardPageState extends State<NewCardPage> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvcController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvcController.dispose();
    super.dispose();
  }

  String _formatExpiryDate(String input) {
    final clean = input.replaceAll('/', '');
    if (clean.length == 4) {
      final month = clean.substring(0, 2);
      final year = clean.substring(2, 4);
      final fullYear = '20$year';
      return '$fullYear-$month-01';
    }
    return input;
  }

  void _addCard() {
    if (_formKey.currentState!.validate()) {
      final formattedDate = _formatExpiryDate(_expiryDateController.text);
      context.read<CardBloc>().add(AddCard(
        cardNumber: _cardNumberController.text,
        expiryDate: formattedDate,
        securityCode: _cvcController.text,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CardBloc, CardState>(
      listener: (context, state) {
        if (state is CardAdded) {
          Navigator.pop(context);
        } else if (state is CardError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(title: "New Card"),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 20),
                Text("Add Debit or Credit Card",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                SizedBox(height: 16),
                Text("Card number"),
                SizedBox(height: 8),
                TextFormField(
                  controller: _cardNumberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                  ],
                  decoration: InputDecoration(
                    hintText: "Enter your card number",
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter card number";
                    }
                    if (value.length < 16) {
                      return "Card number must be 16 digits";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Expiry Date"),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: _expiryDateController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(5),
                            ],
                            decoration: InputDecoration(
                              hintText: "MM/YY",
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {},
                            validator: (value) {
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Security Code"),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: _cvcController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(3),
                            ],
                            decoration: InputDecoration(
                              hintText: "CVC",
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) return "Required";
                              if (value.length != 3) return "3 digits";
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                CustomButton(
                  text: "New Card",
                  onTap: _addCard,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
