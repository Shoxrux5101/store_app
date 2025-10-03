import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/data/models/saved_item_model.dart';
import 'package:store_app/features/home/widgets/custom_bottom_nav_bar.dart';
import '../../../core/routes/routes.dart';
import '../managers/saved_bloc.dart';
import '../managers/saved_event.dart';
import '../managers/saved_state.dart';
import '../widgets/favourite_button.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  int _currentIndex = 2;
  final List<String> _routes = [
    Routes.homePage,
    Routes.searchPage,
    Routes.savedPage,
    Routes.cartPage,
    Routes.accountPage,
  ];

  @override
  void initState() {
    super.initState();
    context.read<SavedBloc>().add(LoadSavedItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Saved Items"),
        centerTitle: true,
        actions:[
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: IconButton(onPressed: (){context.push(Routes.notification);}, icon: SvgPicture.asset("assets/icons/Bell.svg"),),
          ),
        ],
      ),
      body: BlocBuilder<SavedBloc, SavedState>(
        builder: (context, state) {
          if (state is SavedLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SavedLoaded) {
            if (state.items.isEmpty) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 69),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/icons/Heart-duotone.svg"),
                      Text(
                        "No saved items",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "You don’t have any saved items.\n Go to home and add some.",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[500],
                        ),
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              );
            }
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade200,
                              image: DecorationImage(
                                image: NetworkImage(item.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: FavouriteButton(product: item.toProductModel()),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.title,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      "\$ ${item.price}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (state is SavedError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          context.go(_routes[index]);
        },
      ),
    );
  }
}
