import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/data/repository/product_repository.dart';
import '../../home/managers/product_cubit.dart';
import '../../home/managers/product_state.dart';
import '../widgets/recent_searches_widget.dart';
import '../widgets/search_results_widget.dart';
import '../widgets/custom_search_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _recent = [
    'Jeans',
    'Casual clothes',
    'Hoodie',
    'Nike shoes black',
    'V-neck tshirt',
    'Winter clothes',
  ];

  void _addToRecent(String term) {
    setState(() {
      _recent.remove(term);
      _recent.insert(0, term);
      if (_recent.length > 10) _recent.removeLast();
    });
  }

  void _removeRecentAt(int index) {
    setState(() {
      _recent.removeAt(index);
    });
  }

  void _clearAllRecent() {
    setState(() {
      _recent.clear();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(context.read<ProductRepository>())..fetchProducts(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Search"),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              CustomSearchBar(
                textController: _controller,
                onSearch: (term) {
                  if (term.trim().isEmpty) return;
                  _addToRecent(term);
                  context.read<ProductCubit>().searchProducts(term);
                },
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: BlocBuilder<ProductCubit, ProductState>(
                    builder: (context, state) {
                      if ((state.searchQuery?.isEmpty ?? true)) {
                        return RecentSearchesWidget(
                          recent: _recent,
                          onTap: (term) {
                            _controller.text = term;
                            context.read<ProductCubit>().searchProducts(term);
                          },
                          onRemove: _removeRecentAt,
                          onClearAll: _clearAllRecent,
                        );
                      }
                      if (state.status == ProductStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state.status == ProductStatus.error) {
                        return Center(
                          child: Text(state.errorMassage ?? "Something went wrong"),
                        );
                      }
                      return SearchResultsWidget(
                        results: state.filterProducts,
                        onTap: (p) => _addToRecent(p.title),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
