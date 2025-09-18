import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../managers/home_cubit.dart';
import '../managers/home_state.dart';
import '../managers/product_cubit.dart';
import '../managers/product_state.dart';

class CategoryTabsWidget extends StatelessWidget {
  const CategoryTabsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, categoryState) {
          if (categoryState.status == Status.loading) {
            return const Center(child: CupertinoActivityIndicator());
          }

          if (categoryState.status == Status.success) {
            return BlocBuilder<ProductCubit, ProductState>(
              builder: (context, productState) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryState.categories.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        margin: const EdgeInsets.only(right: 12),
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<ProductCubit>().fetchProducts();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: productState.selectedCategoryId == null ? Colors.black : Colors.white,
                            foregroundColor: productState.selectedCategoryId == null ? Colors.white : Colors.black,
                            side: productState.selectedCategoryId == null ? null : const BorderSide(color: Colors.grey),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("All"),
                        ),
                      );
                    }

                    final category = categoryState.categories[index - 1];
                    final isSelected = productState.selectedCategoryId == category.id;

                    return Container(
                      margin: const EdgeInsets.only(right: 12),
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<ProductCubit>().filterByCategory(category.id);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSelected ? Colors.black : Colors.white,
                          foregroundColor: isSelected ? Colors.white : Colors.black,
                          side: isSelected ? null : const BorderSide(color: Colors.grey),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(category.title),
                      ),
                    );
                  },
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
