import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/data/models/my_cart_model.dart';
import '../managers/my_cart_bloc.dart';
import '../managers/my_cart_event.dart';

class CartItemsList extends StatelessWidget {
  final MyCartItemModel cart;

  const CartItemsList({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(14),
        itemCount: cart.items.length,
        itemBuilder: (context, index) {
          final item = cart.items[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                // Rasm
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[200],
                    image: item.image.isNotEmpty
                        ? DecorationImage(
                      image: NetworkImage(item.image),
                      fit: BoxFit.cover,
                    )
                        : null,
                  ),
                  child: item.image.isEmpty
                      ? Icon(Icons.image, color: Colors.grey[400])
                      : null,
                ),
                const SizedBox(width: 16),

                // Ma'lumotlar
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Size ${item.size}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '\$${item.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                // Delete va Quantity
                Column(
                  children: [
                    // DELETE tugmasi
                    GestureDetector(
                      onTap: () {
                        context.read<MyCartBloc>().add(
                          RemoveMyCartProduct(item.id),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        child: Icon(
                          Icons.delete_outline,
                          color: Colors.red[400],
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // QUANTITY controls
                    Row(
                      children: [
                        // MINUS tugmasi - TO'G'RI!
                        GestureDetector(
                          onTap: () {
                            if (item.quantity > 1) {
                              context.read<MyCartBloc>().add(
                                UpdateMyCartQuantity(
                                  itemId: item.id,
                                  quantity: item.quantity - 1, // Kamaytirish
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: item.quantity > 1
                                    ? Colors.grey[300]!
                                    : Colors.grey[200]!,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.remove,
                              size: 16,
                              color: item.quantity > 1
                                  ? Colors.black
                                  : Colors.grey[400],
                            ),
                          ),
                        ),

                        // Quantity ko'rsatish
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '${item.quantity}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        // PLUS tugmasi - TO'G'RI!
                        GestureDetector(
                          onTap: () {
                            context.read<MyCartBloc>().add(
                              UpdateMyCartQuantity(
                                itemId: item.id,
                                quantity: item.quantity + 1, // Oshirish
                              ),
                            );
                          },
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey[300]!),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Icon(Icons.add, size: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}