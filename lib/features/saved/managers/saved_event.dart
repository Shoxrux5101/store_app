import 'package:equatable/equatable.dart';
import '../../../data/models/saved_item_model.dart';

abstract class SavedEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadSavedItems extends SavedEvent {}

class SaveItem extends SavedEvent {
  final SavedItem item;
  SaveItem(this.item);

  @override
  List<Object?> get props => [item];
}

class UnsaveItem extends SavedEvent {
  final int id;
  UnsaveItem(this.id);

  @override
  List<Object?> get props => [id];
}
