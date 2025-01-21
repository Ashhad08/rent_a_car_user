import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/vehicle/vehicle_model.dart';
import '../../../domain/implementations/vehicle/vehicle_repository.dart';

part 'vehicles_by_type_event.dart';
part 'vehicles_by_type_state.dart';

class VehiclesByTypeBloc
    extends Bloc<VehiclesByTypeEvent, VehiclesByTypeState> {
  final VehicleRepository _repository;

  VehiclesByTypeBloc(this._repository) : super(VehiclesByTypeLoading()) {
    on<LoadVehiclesByTypeEvent>(_onLoadVehiclesByTypeEvent);
  }

  Future<void> _onLoadVehiclesByTypeEvent(
      LoadVehiclesByTypeEvent event, Emitter<VehiclesByTypeState> emit) async {
    try {
      emit(VehiclesByTypeLoading());
      final vehicles = await _repository.getVehiclesByType(event.typeId);
      emit(VehiclesByTypeLoaded(vehicles: vehicles));
    } catch (e) {
      emit(VehiclesByTypeError(error: e.toString()));
    }
  }
}
