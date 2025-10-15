import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_app/features/home/managers/product_bloc.dart';
import 'package:store_app/features/home/managers/product_event.dart';
import 'package:store_app/features/home/widgets/filtered_bottom_sheet_widget.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search for clothes...",
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                suffixIcon: Icon(Icons.mic, color: Colors.grey),
              ),
              onChanged: (query) {
                context.read<ProductBloc>().add(SearchProductsEvent(query));
              },
            ),
          ),
        ),
        IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> FilterBottomSheet()));}, icon: SvgPicture.asset('assets/icons/filter.svg'),),
      ],
    );
  }
}
