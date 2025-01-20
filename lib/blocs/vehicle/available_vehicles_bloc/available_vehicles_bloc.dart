import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/vehicle/vehicle_model.dart';
import '../../../domain/implementations/vehicle/vehicle_repository.dart';

part 'available_vehicles_event.dart';
part 'available_vehicles_state.dart';

class AvailableVehiclesBloc
    extends Bloc<AvailableVehiclesEvent, AvailableVehiclesState> {
  final VehicleRepository _repository;

  AvailableVehiclesBloc(this._repository) : super(AvailableVehiclesLoading()) {
    on<LoadAvailableVehiclesEvent>(_onLoadAvailableVehiclesEvent);
  }

  Future<void> _onLoadAvailableVehiclesEvent(LoadAvailableVehiclesEvent event,
      Emitter<AvailableVehiclesState> emit) async {
    try {
      emit(AvailableVehiclesLoading());
      final vehicles = await _repository.getAvailableVehicles();
      emit(AvailableVehiclesLoaded(vehicles: vehicles));
    } catch (e) {
      emit(AvailableVehiclesError(error: e.toString()));
    }
  }
}
