import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/home/widgets/custom_button.dart';

import '../managers/card_bloc.dart';
import '../managers/card_event.dart';
import '../managers/card_state.dart';
import 'new_cards_page.dart';


class CardsScreen extends StatefulWidget {
  const CardsScreen({super.key});

  @override
  State<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends State<CardsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CardBloc>().add(const LoadCards());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cards", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: BlocBuilder<CardBloc, CardState>(
        builder: (context, state) {
          if (state is CardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CardLoaded) {
            final cards = state.cards;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      final card = cards[index];
                      return ListTile(
                        title: Text(card.cardNumber),
                        subtitle: Text(card.cardType ?? "Unknown"),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<CardBloc>().add(DeleteCard(card.id!));
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: CustomButton(text: "Add New Card", onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => NewCardPage()));}),
                )
              ],
            );
          } else if (state is CardError) {
            return Center(child: Text(state.message));
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }
}
