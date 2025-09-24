import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:store_app/features/review/managers/review_bloc.dart';
import 'package:store_app/features/review/managers/review_event.dart';
import 'package:store_app/features/review/managers/review_state.dart';
import 'package:store_app/data/repository/review_repository.dart';

import '../widgets/review_header.dart';
import '../widgets/review_list.dart';


class ReviewPage extends StatelessWidget {
  final int productId;

  const ReviewPage({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      ReviewBloc(repository: context.read<ReviewRepository>())
        ..add(LoadReviews(productId)),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: const Text("Reviews"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/icons/Bell.svg'),
            ),
          ],
        ),
        body: BlocBuilder<ReviewBloc, ReviewState>(
          builder: (context, state) {
            if (state is ReviewLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ReviewLoaded) {
              if (state.reviews.isEmpty) {
                return const Center(child: Text("No reviews yet"));
              }

              final averageRating = state.reviews.isEmpty
                  ? 0.0
                  : state.reviews
                  .map((r) => r.rating)
                  .reduce((a, b) => a + b) /
                  state.reviews.length;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReviewHeader(
                      averageRating: averageRating,
                      reviewCount: state.reviews.length,
                    ),
                    const SizedBox(height: 16),
                    ReviewList(reviews: state.reviews),
                  ],
                ),
              );
            } else if (state is ReviewError) {
              return Center(child: Text("Error: ${state.message}"));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
