import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/managers/product_cubit.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController textController;
  final ValueChanged<String> onSearch;

  const CustomSearchBar({
    super.key,
    required this.textController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: textController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search for clothes...",
                ),
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  context.read<ProductCubit>().searchProducts(value);
                },
                onSubmitted: onSearch,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.mic_none, color: Colors.grey),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
