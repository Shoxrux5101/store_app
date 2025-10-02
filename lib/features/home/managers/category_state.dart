part of 'category_cubit.dart';

enum CategoryStatus { idle, loading, success, error }

class CategoryState extends Equatable {
  final CategoryStatus status;
  final List<CategoryModel> categories;
  final int selectedCategoryId;
  final String? errorMessage;

  const CategoryState({
    required this.status,
    required this.categories,
    required this.selectedCategoryId,
    this.errorMessage,
  });

  factory CategoryState.initial() => const CategoryState(
    status: CategoryStatus.idle,
    categories: [],
    selectedCategoryId: -1,
    errorMessage: null,
  );

  CategoryState copyWith({
    CategoryStatus? status,
    List<CategoryModel>? categories,
    int? selectedCategoryId,
    String? errorMessage,
  }) {
    return CategoryState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    categories,
    selectedCategoryId,
    errorMessage,
  ];
}
