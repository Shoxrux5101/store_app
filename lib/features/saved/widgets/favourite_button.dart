import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../product_details/managers/product_detail_bloc.dart';
import '../../product_details/managers/product_detail_even.dart';


class FavouriteButton extends StatelessWidget {
  final dynamic product;
  final double size;
  final double iconSize;
  FavouriteButton({super.key, required this.product,required this.size, required this.iconSize});

  @override
  Widget build(BuildContext context) {
    bool isLiked = product.isLiked;
    return GestureDetector(
      onTap: () {
        context.read<ProductDetailBloc>().add(
            ToggleLikeDetailEvent(product.id, !isLiked)
        );
      },
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          isLiked ? Icons.favorite : Icons.favorite_border,
          color: isLiked ? Colors.red : Colors.black,
          size: size,
        ),
      ),
    );
  }
}
