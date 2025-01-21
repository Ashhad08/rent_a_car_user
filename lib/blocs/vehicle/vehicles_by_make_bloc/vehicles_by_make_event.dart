part of 'vehicles_by_make_bloc.dart';

sealed class VehiclesByMakeEvent extends Equatable {
  const VehiclesByMakeEvent();
}

final class LoadVehiclesByMakeEvent extends VehiclesByMakeEvent {
  final String makeName;

  const LoadVehiclesByMakeEvent({required this.makeName});

  @override
  List<Object> get props => [makeName];
}
