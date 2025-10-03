import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_app/data/models/saved_item_model.dart';
import '../../../data/repository/saved_repository.dart';
import 'saved_event.dart';
import 'saved_state.dart';

class SavedBloc extends Bloc<SavedEvent, SavedState> {
  final SavedRepository repository;
  final List<SavedItem> _items = [];

  SavedBloc({required this.repository}) : super(SavedInitial()) {
    on<LoadSavedItems>((event, emit) async {
      emit(SavedLoading());
      final result = await repository.getSavedItems();
      result.fold(
            (error) => emit(SavedError(error.toString())),
            (items) {
          _items
            ..clear()
            ..addAll(items);
          emit(SavedLoaded(List.from(_items)));
        },
      );
    });

    on<SaveItem>((event, emit) async {
      final result = await repository.saveItem(event.item.id);
      result.fold(
            (error) => emit(SavedError(error.toString())),
            (_) {
          final index = _items.indexWhere((e) => e.id == event.item.id);
          if (index == -1) {
            _items.add(event.item.copyWith(isLiked: true));
          }
          emit(SavedLoaded(List.from(_items)));
        },
      );
    });

    on<UnsaveItem>((event, emit) async {
      final result = await repository.unsaveItem(event.id);
      result.fold(
            (error) => emit(SavedError(error.toString())),
            (_) {
          _items.removeWhere((e) => e.id == event.id);
          emit(SavedLoaded(List.from(_items)));
        },
      );
    });
  }

  List<SavedItem> get currentItems => List.from(_items);
}