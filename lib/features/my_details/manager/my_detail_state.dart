import 'package:equatable/equatable.dart';
import '../../../data/models/my_detail_model.dart';

abstract class MyDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MyDetailInitial extends MyDetailState {}

class MyDetailLoading extends MyDetailState {}

class MyDetailLoaded extends MyDetailState {
  final List<MyDetail> details;

  MyDetailLoaded(this.details);

  @override
  List<Object?> get props => [details];
}

class MyDetailError extends MyDetailState {
  final String message;

  MyDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
