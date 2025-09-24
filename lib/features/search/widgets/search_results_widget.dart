import 'package:flutter/material.dart';
import '../../../../data/models/product_model.dart';

class SearchResultsWidget extends StatelessWidget {
  final List<ProductModel> results;
  final Function(ProductModel) onTap;

  const SearchResultsWidget({
    super.key,
    required this.results,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300, width: 8),
              ),
              child: const Icon(Icons.search, size: 40, color: Colors.grey),
            ),
            const SizedBox(height: 18),
            const Text(
              'No Results Found!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try a similar word or something more general.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      );
    }
    return ListView.separated(
      itemCount: results.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final p = results[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          leading: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: p.image.isNotEmpty
                ? Image.network(p.image, fit: BoxFit.cover)
                : const Icon(Icons.image, size: 38, color: Colors.grey),
          ),
          title: Text(
            p.title,
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          subtitle: p.discount > 0
              ? Row(
            children: [
              Text(
                '\$${p.price}',
                style: const TextStyle(color: Colors.black54),
              ),
              const SizedBox(width: 8),
              Text(
                '-${p.discount}%',
                style: const TextStyle(color: Colors.red),
              ),
            ],
          )
              : Text('\$${p.price}', style: const TextStyle(color: Colors.black54)),
          trailing: const Icon(Icons.open_in_new),
          onTap: () => onTap(p),
        );
      },
    );
  }
}
