import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/product_model.dart';
import '../../../data/models/saved_item_model.dart';
import '../../home/managers/product_cubit.dart';
import '../managers/saved_bloc.dart';
import '../managers/saved_event.dart';

class FavouriteButton extends StatelessWidget {
  final ProductModel product;

  const FavouriteButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (!product.isLiked) {
          await context.read<ProductCubit>().toggleLike(product);
          context.read<SavedBloc>().add(SaveItem(
            SavedItem(
              id: product.id,
              categoryId: product.categoryId,
              title: product.title,
              image: product.image,
              price: product.price,
              isLiked: true,
              discount: product.discount,
            ),
          ));
        } else {
          await context.read<ProductCubit>().toggleLike(product);
          context.read<SavedBloc>().add(UnsaveItem(product.id));
        }
      },

      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          product.isLiked ? Icons.favorite : Icons.favorite_border,
          color: product.isLiked ? Colors.red : Colors.black,
          size: 18,
        ),
      ),
    );
  }
}