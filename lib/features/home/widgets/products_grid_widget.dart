import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/home/widgets/products_card_widget.dart';
import '../../../data/models/product_model.dart';
import '../../product_details/pages/product_detail_page.dart';
import '../managers/product_cubit.dart';
import '../managers/product_state.dart';

class ProductsGridWidget extends StatelessWidget {
  const ProductsGridWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, productState) {
          switch (productState.status) {
            case ProductStatus.loading:
              return const Center(child: CupertinoActivityIndicator());

            case ProductStatus.success:
              if (productState.filterProducts.isEmpty) {
                return _buildEmptyState();
              }
              return _buildProductsGrid(productState);

            case ProductStatus.error:
              return _buildErrorState(context, productState);

            case ProductStatus.idle:
              return const Center(
                child: Text("Loading products..."),
              );
          }
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            "No products found",
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Try adjusting your search or filters",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildProductsGrid(ProductState productState) {
    return GridView.builder(
      padding: const EdgeInsets.only(bottom: 20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 8,
      ),
      itemCount: productState.filterProducts.length,
      itemBuilder: (context, index) {
        final product = productState.filterProducts[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailPage(productId: product.id),
              ),
            );
          },
          child: ProductCard(product: product),
        );
      },
    );
  }


  Widget _buildErrorState(BuildContext context, ProductState productState) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            productState.errorMassage ?? "Something went wrong",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              context.read<ProductCubit>().fetchProducts();
            },
            icon: const Icon(Icons.refresh),
            label: const Text("Retry"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
