import 'package:equatable/equatable.dart';
import '../../../data/models/address_model.dart';

abstract class AddressState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddressLoading extends AddressState {}

class AddressLoaded extends AddressState {
  final List<Address> addresses;
  AddressLoaded(this.addresses);
  @override
  List<Object?> get props => [addresses];
}
class AddressError extends AddressState {
  final String message;
  AddressError(this.message);
  @override
  List<Object?> get props => [message];
}
