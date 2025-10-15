import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/core/routes/routes.dart';
import 'package:store_app/features/home/widgets/custom_button.dart';
import 'package:store_app/features/home/widgets/cutom_app_bar.dart';
import '../managers/card_bloc.dart';
import '../managers/card_event.dart';
import '../managers/card_state.dart';
import '../widgets/card_item_widget.dart';
import '../widgets/add_card_button.dart';
import '../widgets/delete_card_dialog.dart';
import 'new_cards_page.dart';

class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  int? _selectedCardId;

  @override
  void initState() {
    super.initState();
    context.read<CardBloc>().add(LoadCards());
  }

  void _handleCardDelete(int cardId) {
    DeleteCardDialog.show(
      context: context,
      onConfirm: () {
        context.read<CardBloc>().add(DeleteCard(cardId));
        Future.delayed(const Duration(milliseconds: 300), () {
          context.read<CardBloc>().add(LoadCards());
        });
      },
    );
  }

  void _handleAddNewCard() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => NewCardPage()),
    );
    context.read<CardBloc>().add(LoadCards());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Payment Method"),
      body: BlocBuilder<CardBloc, CardState>(
        builder: (context, state) {
          if (state is CardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CardLoaded) {
            final cards = state.cards;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  const Text(
                    "Saved Cards",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cards.length,
                      itemBuilder: (context, index) {
                        final card = cards[index];
                        final cardNumber = card.cardNumber ?? '';
                        final isSelected = card.id == _selectedCardId;
                        final isDefault = index == 0;

                        return CardItemWidget(
                          id: card.id!,
                          cardNumber: cardNumber,
                          isSelected: isSelected,
                          isDefault: isDefault,
                          onLongPress: () => _handleCardDelete(card.id!),
                          onRadioChanged: (value) {
                            setState(() => _selectedCardId = value);
                          },
                        );
                      },
                    ),
                  ),
                  AddCardButton(onTap: _handleAddNewCard),
                  const SizedBox(height: 20),
                  CustomButton(text: "Apply", onTap: () {context.push(Routes.checkOut);}),
                ],
              ),
            );
          } else if (state is CardError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}