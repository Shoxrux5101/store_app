import 'package:equatable/equatable.dart';
import '../../../data/models/category_model.dart';

enum Status { idle, loading, success, error }

class HomeState extends Equatable {
  final Status status;
  final List<CategoryModel> categories;
  final String? errorMassage;

  HomeState({
    required this.status,
    required this.categories,
    required this.errorMassage,
  });

  factory HomeState.initial() =>
      HomeState(status: Status.idle, categories: [], errorMassage: null);

  HomeState copyWith({
    String? errorMassage,
    Status? status,
    List<CategoryModel>? categories,
  }) => HomeState(
    status: status ?? this.status,
    categories: categories ?? this.categories,
    errorMassage: errorMassage ?? this.errorMassage,
  );

  @override
  List<Object?> get props => [];
}
