import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/data/repository/product_repository.dart';
import '../../../core/routes/routes.dart';
import '../../../data/repository/saved_repository.dart';
import '../../home/managers/product_bloc.dart';
import '../../home/managers/product_event.dart';
import '../../home/managers/product_state.dart';
import '../../home/widgets/custom_bottom_nav_bar.dart';
import '../widgets/recent_searches_widget.dart';
import '../widgets/search_results_widget.dart';
import '../widgets/custom_search_bar.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

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
      create: (context) =>
      ProductBloc(repository: context.read<ProductRepository>())
        ..add(GetAllProductsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Search"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                context.push(Routes.notification);
              },
              icon: SvgPicture.asset('assets/icons/Bell.svg'),
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
                  context.read<ProductBloc>().add(SearchProductsEvent(term));
                },
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: BlocBuilder<ProductBloc, ProductState>(
                    builder: (context, state) {
                      if (state is ProductInitial ||
                          (state is ProductLoaded &&
                              state.products.isEmpty)) {
                        return RecentSearchesWidget(
                          recent: _recent,
                          onTap: (term) {
                            _controller.text = term;
                            context
                                .read<ProductBloc>()
                                .add(SearchProductsEvent(term));
                          },
                          onRemove: _removeRecentAt,
                          onClearAll: _clearAllRecent,
                        );
                      } else if (state is ProductLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is ProductError) {
                        return Center(child: Text(state.error));
                      } else if (state is ProductLoaded) {
                        return SearchResultsWidget(
                          results: state.products,
                          onTap: (p) => _addToRecent(p.title),
                        );
                      } else {
                        return Center(child: Text("No products found"));
                      }
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
