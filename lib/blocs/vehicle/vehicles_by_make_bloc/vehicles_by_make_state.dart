part of 'vehicles_by_make_bloc.dart';

sealed class VehiclesByMakeState extends Equatable {
  const VehiclesByMakeState();
}

final class VehiclesByMakeLoading
    extends VehiclesByMakeState {
  @override
  List<Object> get props => [];
}

final class VehiclesByMakeLoaded
    extends VehiclesByMakeState {
  final List<VehicleModel> _vehicles;

  List<VehicleModel> get vehicles => _vehicles;

  const VehiclesByMakeLoaded({required List<VehicleModel> vehicles})
      : _vehicles = vehicles;

  @override
  List<Object> get props => [_vehicles];
}

final class VehiclesByMakeError
    extends VehiclesByMakeState {
  final String _error;

  String get error => _error;

  const VehiclesByMakeError({required String error}) : _error = error;

  @override
  List<Object> get props => [_error];
}
