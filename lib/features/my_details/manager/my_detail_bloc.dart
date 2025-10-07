import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/data/models/my_detail_model.dart';

import '../../../data/repository/my_detail_repository.dart';
import 'my_detail_event.dart';
import 'my_detail_state.dart';

class MyDetailBloc extends Bloc<MyDetailEvent, MyDetailState> {
  final MyDetailRepository repository;

  MyDetailBloc(this.repository) : super(MyDetailInitial()) {
    on<LoadMyDetail>((event, emit) async {
      emit(MyDetailLoading());

      final result = await repository.getDetails();

      result.fold(
            (error) => emit(MyDetailError(error.toString())),
            (data) => emit(MyDetailLoaded(data as List<MyDetail>)),
      );
    });
  }
}
