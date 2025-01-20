part of 'available_vehicles_bloc.dart';

sealed class AvailableVehiclesState extends Equatable {
  const AvailableVehiclesState();
}

final class AvailableVehiclesLoading
    extends AvailableVehiclesState {
  @override
  List<Object> get props => [];
}

final class AvailableVehiclesLoaded
    extends AvailableVehiclesState {
  final List<VehicleModel> _vehicles;

  List<VehicleModel> get vehicles => _vehicles;

  const AvailableVehiclesLoaded({required List<VehicleModel> vehicles})
      : _vehicles = vehicles;

  @override
  List<Object> get props => [_vehicles];
}

final class AvailableVehiclesError
    extends AvailableVehiclesState {
  final String _error;

  String get error => _error;

  const AvailableVehiclesError({required String error}) : _error = error;

  @override
  List<Object> get props => [_error];
}
