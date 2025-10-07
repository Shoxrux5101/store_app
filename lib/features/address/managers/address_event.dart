import 'package:equatable/equatable.dart';
import '../../../data/models/address_model.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object?> get props => [];
}

class LoadAddresses extends AddressEvent {}

class CreateAddressEvent extends AddressEvent {
  final Address address;

  const CreateAddressEvent(this.address);

  @override
  List<Object?> get props => [address];
}
