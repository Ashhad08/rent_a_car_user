import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/vehicle/vehicle_model.dart';
import '../../../domain/implementations/vehicle/vehicle_repository.dart';

part 'vehicles_by_make_event.dart';
part 'vehicles_by_make_state.dart';

class VehiclesByMakeBloc
    extends Bloc<VehiclesByMakeEvent, VehiclesByMakeState> {
  final VehicleRepository _repository;

  VehiclesByMakeBloc(this._repository) : super(VehiclesByMakeLoading()) {
    on<LoadVehiclesByMakeEvent>(_onLoadVehiclesByMakeEvent);
  }

  Future<void> _onLoadVehiclesByMakeEvent(
      LoadVehiclesByMakeEvent event, Emitter<VehiclesByMakeState> emit) async {
    try {
      emit(VehiclesByMakeLoading());
      final vehicles = await _repository.getVehiclesByMake(event.makeName);
      emit(VehiclesByMakeLoaded(vehicles: vehicles));
    } catch (e) {
      emit(VehiclesByMakeError(error: e.toString()));
    }
  }
}
