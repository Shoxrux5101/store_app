import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/my_detail_repository.dart';
import 'my_detail_event.dart';
import 'my_detail_state.dart';

class MyDetailBloc extends Bloc<MyDetailEvent, MyDetailState> {
  final MyDetailRepository _repository;

  MyDetailBloc({required MyDetailRepository repository})
      : _repository = repository,
        super(MyDetailInitial()) {
    on<LoadMyDetail>(_onLoadMyDetail);
    on<UpdateMyDetail>(_onUpdateMyDetail);
    on<DeleteMyDetail>(_onDeleteMyDetail);
  }

  Future<void> _onLoadMyDetail(
      LoadMyDetail event,
      Emitter<MyDetailState> emit,
      ) async {
    emit(MyDetailLoading());

    final result = await _repository.getMyDetail();

    result.fold(
          (error) => emit(MyDetailError(error as String)),
          (myDetail) => emit(MyDetailLoaded(myDetail)),
    );
  }

  Future<void> _onUpdateMyDetail(
      UpdateMyDetail event,
      Emitter<MyDetailState> emit,
      ) async {
    emit(MyDetailLoading());

    final result = await _repository.updateMyDetail(event.myDetail);

    result.fold(
          (error) => emit(MyDetailError(error as String)),
          (myDetail) => emit(MyDetailUpdated(myDetail)),
    );
  }

  Future<void> _onDeleteMyDetail(
      DeleteMyDetail event,
      Emitter<MyDetailState> emit,
      ) async {
    emit(MyDetailLoading());

    final result = await _repository.registerMyDetail();

    result.fold(
          (error) => emit(MyDetailError(error as String)),
          (success) => emit(MyDetailDeleted()),
    );
  }
}