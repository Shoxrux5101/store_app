import 'package:equatable/equatable.dart';

abstract class MyDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMyDetail extends MyDetailEvent {}
