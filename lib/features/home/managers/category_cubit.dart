import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/category_model.dart';
import '../../../data/repository/category_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository repository;

  CategoryCubit(this.repository) : super(CategoryState.initial());

  Future<void> fetchCategories() async {
    emit(state.copyWith(status: CategoryStatus.loading));

    final result = await repository.getCategories();

    result.fold(
          (error) {
        emit(state.copyWith(
          status: CategoryStatus.error,
          errorMessage: error.toString(),
        ));
      },
          (categories) {
        final updated = [
          CategoryModel(id: -1, title: 'All'),
          ...categories,
        ];
        emit(state.copyWith(
          status: CategoryStatus.success,
          categories: updated,
          selectedCategoryId: -1,
        ));
      },
    );
  }

  void selectCategory(int id) {
    emit(state.copyWith(selectedCategoryId: id));
  }
}
