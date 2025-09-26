import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:store_app/features/card/managers/card_bloc.dart';
import 'package:store_app/features/card/managers/card_event.dart';
import 'package:store_app/features/card/managers/card_state.dart';
import '../../../core/routes/routes.dart';
import '../../home/widgets/custom_bottom_nav_bar.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  int _currentIndex = 0;

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
    _currentIndex = 3;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      CardBloc(repository: context.read())..add(const LoadCards()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back)),
          centerTitle: true,
          title: Text('My Card',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
          actions: [
            IconButton(onPressed: (){context.push(Routes.notification);}, icon: SvgPicture.asset('assets/icons/Bell.svg')),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: BlocBuilder<CardBloc, CardState>(
            builder: (context, state) {
              if (state is CardLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CardLoaded) {
                return ListView.builder(
                  itemCount: state.cards.length,
                  itemBuilder: (context, index) {
                    final card = state.cards[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey,width: 1),
                      ),
                      child: Row(
                        children: [

                        ],
                      )
                    );
                  },
                );
              } else if (state is CardError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox.shrink();
            },
          ),
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
      ),
    );
  }
}
