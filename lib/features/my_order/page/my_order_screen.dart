import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:store_app/core/authInterceptor.dart';
import 'package:store_app/data/repository/my_order_repository.dart';
import '../../../core/network/api_client.dart';
import '../../home/widgets/cutom_app_bar.dart';
import '../managers/my_order_bloc.dart';
import '../managers/my_order_event.dart';
import '../managers/my_order_state.dart';
import '../widgets/empty_orders_widget.dart';
import '../widgets/orders_card.dart';
import '../widgets/tab_selector.dart';

class MyOrderScreen extends StatelessWidget {
  const MyOrderScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderBloc(
        repository: MyOrderRepository(apiClient: ApiClient(interceptor: AuthInterceptor(secureStorage: FlutterSecureStorage()))),
      )..add(LoadOrdersEvent()),
      child: Scaffold(
        extendBody: true,
        appBar: CustomAppBar(title: "My Orders"),
        body: Column(
          children: [
            const TabSelector(),
            Expanded(
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  if (state is OrderLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                      ),
                    );
                  }
                  if (state is OrderError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.red[300],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Error loading orders',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              state.message,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red
                              ),
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              onPressed: () =>
                                  context.read<OrderBloc>().add(LoadOrdersEvent()),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFFFFFFFF),
                                foregroundColor: Color(0xFFFFFFFF),
                                padding: EdgeInsets.symmetric(
                                  horizontal: 32,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text('Try Again'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  if (state is OrdersLoaded) {
                    final displayOrders = state.currentTabIndex == 0
                        ? state.ongoingOrders
                        : state.completedOrders;

                    if (displayOrders.isEmpty) {
                      return EmptyOrdersWidget(
                        isOngoing: state.currentTabIndex == 0,
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: displayOrders.length,
                      itemBuilder: (context, index) {
                        return OrderCard(order: displayOrders[index]);
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            SizedBox(height: 60,)
          ],
        ),
      )
    );
  }
}

