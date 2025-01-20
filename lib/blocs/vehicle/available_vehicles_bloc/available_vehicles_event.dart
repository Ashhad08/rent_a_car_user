part of 'available_vehicles_bloc.dart';

sealed class AvailableVehiclesEvent extends Equatable {
  const AvailableVehiclesEvent();
}

final class LoadAvailableVehiclesEvent
    extends AvailableVehiclesEvent {
  @override
  List<Object> get props => [];
}
