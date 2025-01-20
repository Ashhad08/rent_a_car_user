import '../../../data/models/master_data/vehicle_feature_model.dart';
import '../../../data/models/master_data/vehicle_make_model.dart';
import '../../../data/models/master_data/vehicle_model_model.dart';
import '../../../data/models/master_data/vehicle_type_model.dart';
import '../../../data/models/response/response_model.dart';
import '../../../data/repositories/master_data/base_master_data_repository.dart';

class MasterDataRepository extends BaseMasterDataRepository {
  MasterDataRepository(
      {required super.backendConfigs, required super.networkRepository});

  @override
  Future<List<VehicleFeatureModel>> getVehicleAllFeatures() async {
    try {
      final res = await super.networkRepository.get(
              uri: super.backendConfigs.buildUri(segments: [
            super.backendConfigs.vehicle,
            super.backendConfigs.vehicleAllFeatures
          ]));
      return ResponseModel<List<VehicleFeatureModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<VehicleFeatureModel>.from(
                    data!.map((e) => VehicleFeatureModel.fromJson(e))),
          ).data ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<VehicleMakeModel>> getVehicleAllMakes() async {
    try {
      final res = await super.networkRepository.get(
              uri: super.backendConfigs.buildUri(segments: [
            super.backendConfigs.vehicle,
            super.backendConfigs.vehicleAllMakes
          ]));
      return ResponseModel<List<VehicleMakeModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<VehicleMakeModel>.from(
                    data!.map((e) => VehicleMakeModel.fromJson(e))),
          ).data ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<VehicleTypeModel>> getVehicleAllTypes() async {
    try {
      final res = await super.networkRepository.get(
              uri: super.backendConfigs.buildUri(segments: [
            super.backendConfigs.vehicle,
            super.backendConfigs.vehicleAllTypes
          ]));
      return ResponseModel<List<VehicleTypeModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<VehicleTypeModel>.from(
                    data!.map((e) => VehicleTypeModel.fromJson(e))),
          ).data ??
          [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<VehicleModelModel>> getVehicleModels() async {
    try {
      final res = await super.networkRepository.get(
            uri: super.backendConfigs.buildUri(
              segments: [
                super.backendConfigs.vehicle,
                super.backendConfigs.vehicleAllModels
              ],
            ),
          );
      return ResponseModel<List<VehicleModelModel>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<VehicleModelModel>.from(
                    data!.map((e) => VehicleModelModel.fromJson(e))),
          ).data ??
          [];
    } catch (e) {
      rethrow;
    }
  }
}
