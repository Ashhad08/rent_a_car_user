part of 'vehicles_by_type_bloc.dart';

sealed class VehiclesByTypeEvent extends Equatable {
  const VehiclesByTypeEvent();
}

final class LoadVehiclesByTypeEvent extends VehiclesByTypeEvent {
  final String typeId;

  const LoadVehiclesByTypeEvent({required this.typeId});

  @override
  List<Object> get props => [typeId];
}
