import 'package:equatable/equatable.dart';
import '../../../data/models/saved_item_model.dart';

abstract class SavedState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SavedInitial extends SavedState {}

class SavedLoading extends SavedState {}

class SavedLoaded extends SavedState {
  final List<SavedItem> items;
  SavedLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class SavedError extends SavedState {
  final String message;
  SavedError(this.message);

  @override
  List<Object?> get props => [message];
}
