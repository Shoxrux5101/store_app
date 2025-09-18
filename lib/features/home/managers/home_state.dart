import 'package:equatable/equatable.dart';
import '../../../data/models/category_model.dart';

enum Status { idle, loading, success, error }

class HomeState extends Equatable {
  final Status status;
  final List<CategoryModel> categories;
  final String? errorMessage;

  const HomeState({
    required this.status,
    required this.categories,
    required this.errorMessage,
  });

  factory HomeState.initial() =>
      const HomeState(status: Status.idle, categories: [], errorMessage: null);

  HomeState copyWith({
    Status? status,
    List<CategoryModel>? categories,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, categories, errorMessage];
}
