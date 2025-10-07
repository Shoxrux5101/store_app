import 'package:flutter_bloc/flutter_bloc.dart';
import 'address_event.dart';
import 'address_state.dart';
import '../../../data/repository/address_repository.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressRepository repository;

  AddressBloc(this.repository) : super(AddressInitial()) {
    on<LoadAddresses>((event, emit) async {
      emit(AddressLoading());
      final result = await repository.getAddresses();
      result.fold(
            (error) => emit(AddressError(error.toString())),
            (addresses) => emit(AddressLoaded(addresses)),
      );
    });

    on<CreateAddressEvent>((event, emit) async {
      if (state is AddressLoaded) {
        final currentState = state as AddressLoaded;
        emit(AddressLoading());
        final result = await repository.createAddress(event.address);
        result.fold(
              (error) => emit(AddressError(error.toString())),
              (newAddress) {
            final updated = List.of(currentState.addresses)..add(newAddress);
            emit(AddressLoaded(updated));
          },
        );
      }
    });
  }
}
