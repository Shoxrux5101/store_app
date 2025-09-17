// import 'package:bloc/bloc.dart';
// import '../../../data/repository/category_repository.dart';
// import 'home_state.dart';
//
// class CategoryCubit extends Cubit<HomeState> {
//   final CategoryRepository repository;
//
//   CategoryCubit(this.repository) : super(CategoryInitial());
//
//   Future<void> fetchCategories() async {
//     emit(CategoryLoading());
//     try {
//       final categories = await repository.getCategories();
//       emit(CategoryLoaded(categories as List));
//     } catch (e) {
//       emit(HomeError(e.toString()));
//     }
//   }
// }
