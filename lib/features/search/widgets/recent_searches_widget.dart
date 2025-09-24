import 'package:flutter/material.dart';

class RecentSearchesWidget extends StatelessWidget {
  final List<String> recent;
  final Function(String) onTap;
  final Function(int) onRemove;
  final VoidCallback onClearAll;

  const RecentSearchesWidget({
    super.key,
    required this.recent,
    required this.onTap,
    required this.onRemove,
    required this.onClearAll,
  });

  @override
  Widget build(BuildContext context) {
    if (recent.isEmpty) {
      return const Center(child: Text("No recent searches"));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recent Searches",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextButton(
              onPressed: onClearAll,
              child: const Text("Clear all"),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Expanded(
          child: ListView.separated(
            itemCount: recent.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final term = recent[index];
              return ListTile(
                title: Text(term),
                trailing: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => onRemove(index),
                ),
                onTap: () => onTap(term),
              );
            },
          ),
        ),
      ],
    );
  }
}
