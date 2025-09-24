import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../managers/product_cubit.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search for clothes...",
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                suffixIcon: Icon(Icons.mic, color: Colors.grey),
              ),
              onChanged: (query) {
                context.read<ProductCubit>().searchProducts(query);
              },
            ),
          ),
        ),
        SvgPicture.asset('assets/icons/filter.svg'),
      ],
    );
  }
}