
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/features/my_order/widgets/tab_button.dart';

import '../managers/my_order_bloc.dart';
import '../managers/my_order_event.dart';
import '../managers/my_order_state.dart';

class TabSelector extends StatelessWidget {
  const TabSelector({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        final currentTab = state is OrdersLoaded ? state.currentTabIndex : 0;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Expanded(
                child: TabButton(
                  title: "Ongoing",
                  isSelected: currentTab == 0,
                  onTap: () => context.read<OrderBloc>().add(const ChangeOrderTabEvent(0)),
                ),
              ),
              Expanded(
                child: TabButton(
                  title: "Completed",
                  isSelected: currentTab == 1,
                  onTap: () => context.read<OrderBloc>().add(const ChangeOrderTabEvent(1)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
