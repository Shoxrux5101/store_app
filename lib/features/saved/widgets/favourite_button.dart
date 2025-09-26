import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/saved/managers/saved_bloc.dart';
import 'package:store_app/features/saved/managers/saved_event.dart';
import 'package:store_app/data/models/saved_item_model.dart';

class FavouriteButton extends StatelessWidget {
  final SavedItem item;

  const FavouriteButton({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (item.isLiked) {
          context.read<SavedBloc>().add(UnsaveItem(item.id));
        } else {
          context.read<SavedBloc>().add(SaveItem(item));
        }
      },
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Center(
          child: Icon(
            Icons.favorite,
            size: 18,
            color: item.isLiked ? Colors.red : Colors.grey,
          ),
        ),
      ),
    );
  }
}
