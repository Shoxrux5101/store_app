import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/category_model.dart';
import '../managers/category_cubit.dart';


class CategoryTabsWidget extends StatelessWidget {
  const CategoryTabsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryCubit, CategoryState>(
      builder: (context, state) {
        if (state.status == CategoryStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == CategoryStatus.error) {
          return Center(child: Text('Xato: ${state.errorMessage}'));
        }
        if (state.categories.isEmpty) {
          return const SizedBox.shrink();
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];
                print(category);
                return _CategoryTabButton(
                  category: category,
                  isSelected: category.id == state.selectedCategoryId,
                  onPressed: () {
                    context.read<CategoryCubit>().selectCategory(category.id);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _CategoryTabButton extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onPressed;

  const _CategoryTabButton({
    required this.category,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isSelected ? Colors.black : Colors.white;
    final textColor = isSelected ? Colors.white : Colors.grey[800];
    final borderColor = isSelected ? Colors.black : Colors.grey[300];

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          side: BorderSide(color: borderColor!, width: 1.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 0,
        ),
        child: Text(
          category.title,
          style: TextStyle(
            color: textColor,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}