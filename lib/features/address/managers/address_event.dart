import 'package:equatable/equatable.dart';
import '../../../data/models/address_model.dart';

abstract class AddressEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadAddresses extends AddressEvent {}

class CreateAddressEvent extends AddressEvent {
  final Address address;
  CreateAddressEvent(this.address);
  @override
  List<Object?> get props => [address];
}

class UpdateAddressEvent extends AddressEvent {
  final Address address;
  UpdateAddressEvent(this.address);
  @override
  List<Object?> get props => [address];
}

class DeleteAddressEvent extends AddressEvent {
  final int id;
  DeleteAddressEvent(this.id);
  @override
  List<Object?> get props => [id];
}
