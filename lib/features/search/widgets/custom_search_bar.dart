import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/managers/product_bloc.dart';
import '../../home/managers/product_event.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController textController;
  final ValueChanged<String> onSearch;

  CustomSearchBar({
    super.key,
    required this.textController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: textController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search for clothes...",
                ),
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  context.read<ProductBloc>().add(SearchProductsEvent(value));
                },
                onSubmitted: onSearch,
              ),
            ),
            IconButton(
              icon: Icon(Icons.mic_none, color: Colors.grey),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
