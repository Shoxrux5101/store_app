import 'package:bloc/bloc.dart';
import '../../../data/repository/category_repository.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final CategoryRepository repository;

  HomeCubit(this.repository) : super(HomeState.initial());

  Future<void> fetchCategories() async {
    emit(state.copyWith(status: Status.loading));

    final result = await repository.getCategories();

    result.fold(
          (error) {
        emit(state.copyWith(
          status: Status.error,
          errorMessage: error.toString(),
        ));
      },
          (data) {
        emit(state.copyWith(
          status: Status.success,
          categories: data,
        ));
      },
    );
  }
}
