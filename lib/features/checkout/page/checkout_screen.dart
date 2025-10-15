import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/data/models/address_model.dart';
import 'package:store_app/features/home/widgets/cutom_app_bar.dart';
import '../managers/checkout_bloc.dart';
import '../managers/checkout_event.dart';
import '../managers/checkout_state.dart';
import '../widgets/address_selection_sheet.dart';
import '../widgets/card_selection_sheet.dart';
import '../widgets/delivery_address_widget.dart';
import '../widgets/order_summery_widget.dart';
import '../widgets/payment_method_widget.dart';
import '../widgets/place_order_widget.dart';
import '../widgets/promo_code_widget.dart';


class CheckoutScreen extends StatefulWidget {
  final double subtotal;
  final Address? initialAddress;

  const CheckoutScreen({Key? key, required this.subtotal,required this.initialAddress}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final TextEditingController _promoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CheckoutBloc>().add(InitializeCheckout(widget.subtotal));
    if (widget.initialAddress != null) {
      context.read<CheckoutBloc>().add(SelectAddress(widget.initialAddress!));
    }
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Checkout"),
      body: BlocConsumer<CheckoutBloc, CheckoutState>(
        listener: (context, state) {
          if (state is CheckoutError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is OrderPlaced) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Order placed successfully!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is CheckoutLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CheckoutReady) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DeliveryAddressWidget(
                          state: state,
                          onChangePressed: () => _showAddressSelection(context),
                        ),
                        const SizedBox(height: 24),
                        PaymentMethodWidget(
                          state: state,
                          onCardSelectPressed: () => _showCardSelection(context),
                        ),
                        const SizedBox(height: 24),
                        OrderSummaryWidget(state: state),
                        const SizedBox(height: 24),
                        PromoCodeWidget(
                          controller: _promoController,
                          onApplyPressed: () {
                            if (_promoController.text.isNotEmpty) {
                              context.read<CheckoutBloc>().add(
                                ApplyPromoCode(_promoController.text),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                PlaceOrderButtonWidget(state: state),
              ],
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
  void _showAddressSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddressSelectionSheet(),
    );
  }
  void _showCardSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CardSelectionSheet(),
    );
  }
}
