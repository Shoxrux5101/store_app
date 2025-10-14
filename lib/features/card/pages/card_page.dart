import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../managers/card_bloc.dart';
import '../managers/card_event.dart';
import '../managers/card_state.dart';


class CardsScreen extends StatelessWidget {
  const CardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mening kartalarim'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<CardBloc>().add(const LoadCards());
            },
          ),
        ],
      ),
      body: BlocConsumer<CardBloc, CardState>(
        listener: (context, state) {
          if (state is CardError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is CardAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Karta muvaffaqiyatli qo\'shildi'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is CardDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Karta o\'chirildi'),
                backgroundColor: Colors.orange,
              ),
            );
          } else if (state is CardUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Karta yangilandi'),
                backgroundColor: Colors.blue,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is CardLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is CardLoaded) {
            if (state.cards.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.credit_card_off, size: 80, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      'Kartalar topilmadi',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.cards.length,
              itemBuilder: (context, index) {
                final card = state.cards[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: const Icon(Icons.credit_card, color: Colors.blue),
                    title: Text(
                      _formatCardNumber(card.cardNumber),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    subtitle: Text('ID: ${card.id}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.orange),
                          onPressed: () => _showEditDialog(context, card.id, card.cardNumber),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _showDeleteDialog(context, card.id),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text('Kartalarni yuklash uchun refresh bosing'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  String _formatCardNumber(String cardNumber) {
    if (cardNumber.length == 16) {
      return cardNumber.replaceAllMapped(
        RegExp(r'.{4}'),
            (match) => '${match.group(0)} ',
      ).trim();
    }
    return cardNumber;
  }

  void _showAddDialog(BuildContext context) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Yangi karta qo\'shish'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Karta raqami',
            hintText: '1234567812345678',
          ),
          keyboardType: TextInputType.number,
          maxLength: 16,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Bekor qilish'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<CardBloc>().add(AddCard(controller.text));
                Navigator.pop(dialogContext);
              }
            },
            child: const Text('Qo\'shish'),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, int cardId, String currentNumber) {
    final controller = TextEditingController(text: currentNumber);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Kartani tahrirlash'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Karta raqami',
          ),
          keyboardType: TextInputType.number,
          maxLength: 16,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Bekor qilish'),
          ),
          ElevatedButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                context.read<CardBloc>().add(
                  UpdateCard(cardId: cardId, cardNumber: controller.text),
                );
                Navigator.pop(dialogContext);
              }
            },
            child: const Text('Yangilash'),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, int cardId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('O\'chirish'),
        content: const Text('Ushbu kartani o\'chirishni xohlaysizmi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Yo\'q'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<CardBloc>().add(DeleteCard(cardId));
              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Ha, o\'chirish'),
          ),
        ],
      ),
    );
  }
}