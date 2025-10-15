import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/address_repository.dart';
import 'address_event.dart';
import 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository repository;

  AddressBloc(this.repository) : super(AddressLoading()) {
    on<LoadAddresses>((event, emit) async {
      emit(AddressLoading());
      final result = await repository.getAddresses();
      result.fold(
            (e) => emit(AddressError(e.toString())),
            (data) => emit(AddressLoaded(data)),
      );
    });

    on<CreateAddressEvent>((event, emit) async {
      final currentState = state;
      if (currentState is AddressLoaded) {
        final result = await repository.createAddress(event.address);
        result.fold(
              (e) => emit(AddressError(e.toString())),
              (newAddress) => emit(
            AddressLoaded(List.from(currentState.addresses)..add(newAddress)),
          ),
        );
      }
    });

    on<UpdateAddressEvent>((event, emit) async {
      final currentState = state;
      if (currentState is AddressLoaded) {
        final result = await repository.patchAddress(event.address);
        result.fold(
              (e) => emit(AddressError(e.toString())),
              (updated) {
            final updatedList = currentState.addresses
                .map((e) => e.id == updated.id ? updated : e)
                .toList();
            emit(AddressLoaded(updatedList));
          },
        );
      }
    });

    on<DeleteAddressEvent>((event, emit) async {
      final currentState = state;
      if (currentState is AddressLoaded) {
        final result = await repository.deleteAddress(event.id);
        result.fold(
              (e) => emit(AddressError(e.toString())),
              (_) {
            final updatedList =
            currentState.addresses.where((e) => e.id != event.id).toList();
            emit(AddressLoaded(updatedList));
          },
        );
      }
    });
  }
}
