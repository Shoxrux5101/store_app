import '../../../data/models/my_detail_model.dart';

abstract class MyDetailState {}

class MyDetailInitial extends MyDetailState {}

class MyDetailLoading extends MyDetailState {}

class MyDetailLoaded extends MyDetailState {
  final MyDetail myDetail;

  MyDetailLoaded(this.myDetail);
}

class MyDetailUpdated extends MyDetailState {
  final MyDetail myDetail;

  MyDetailUpdated(this.myDetail);
}

class MyDetailDeleted extends MyDetailState {}

class MyDetailError extends MyDetailState {
  final String message;

  MyDetailError(this.message);
}