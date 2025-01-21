import 'package:flutter/material.dart';

import '../../../data/models/response/response_model.dart';
import '../../../data/models/vehicle/vehicle_model.dart';
import '../../../data/repositories/vehicle/base_vehicle_repository.dart';

class VehicleRepository extends BaseVehicleRepository {
  VehicleRepository(
      {required super.backendConfigs,
      required super.networkRepository,
      required super.imageServices});

  @override
  Future<List<VehicleModel>> getAvailableVehicles() async {
    try {
      final res = await super.networkRepository.get(
              uri: super.backendConfigs.buildUri(segments: [
            super.backendConfigs.vehicle,
            super.backendConfigs.availableVehicle,
          ]));
      return ResponseModel<List<VehicleModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<VehicleModel>.from(
                    data!.map((e) => VehicleModel.fromJson(e))),
          ).data ??
          [];
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      rethrow;
    }
  }

  @override
  Future<List<VehicleModel>> getVehiclesByMake(String makeName) async {
    try {
      final res = await super.networkRepository.post(
          uri: super.backendConfigs.buildUri(segments: [
            super.backendConfigs.vehicle,
            super.backendConfigs.byMake,
          ]),
          data: {"makeName": makeName});
      return ResponseModel<List<VehicleModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<VehicleModel>.from(
                    data!.map((e) => VehicleModel.fromJson(e))),
          ).data ??
          [];
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      rethrow;
    }
  }

  @override
  Future<List<VehicleModel>> getVehiclesByType(String typeId) async {
    try {
      final res = await super.networkRepository.post(
          uri: super.backendConfigs.buildUri(segments: [
            super.backendConfigs.vehicle,
            super.backendConfigs.byType,
          ]),
          data: {"typeID": typeId});
      return ResponseModel<List<VehicleModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<VehicleModel>.from(
                    data!.map((e) => VehicleModel.fromJson(e))),
          ).data ??
          [];
    } catch (e, stackTrace) {
      debugPrint(stackTrace.toString());
      rethrow;
    }
  }
}
