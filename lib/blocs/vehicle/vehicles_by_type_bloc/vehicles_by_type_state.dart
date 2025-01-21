part of 'vehicles_by_type_bloc.dart';

sealed class VehiclesByTypeState extends Equatable {
  const VehiclesByTypeState();
}

final class VehiclesByTypeLoading
    extends VehiclesByTypeState {
  @override
  List<Object> get props => [];
}

final class VehiclesByTypeLoaded
    extends VehiclesByTypeState {
  final List<VehicleModel> _vehicles;

  List<VehicleModel> get vehicles => _vehicles;

  const VehiclesByTypeLoaded({required List<VehicleModel> vehicles})
      : _vehicles = vehicles;

  @override
  List<Object> get props => [_vehicles];
}

final class VehiclesByTypeError
    extends VehiclesByTypeState {
  final String _error;

  String get error => _error;

  const VehiclesByTypeError({required String error}) : _error = error;

  @override
  List<Object> get props => [_error];
}
