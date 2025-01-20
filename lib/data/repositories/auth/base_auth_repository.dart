import '../../../configurations/backend_configs.dart';
import '../../../domain/services/image_services.dart';
import '../../../network/network_repository.dart';
import '../../models/response/response_model.dart';

abstract class BaseAuthRepository {
  final BackendConfigs _backendConfigs;
  final ImageServices _imageServices;

  ImageServices get imageServices => _imageServices;

  BackendConfigs get backendConfigs => _backendConfigs;
  final NetworkRepository _networkRepository;

  BaseAuthRepository(
      {required BackendConfigs backendConfigs,
      required ImageServices imageServices,
      required NetworkRepository networkRepository})
      : _backendConfigs = backendConfigs,
        _imageServices = imageServices,
        _networkRepository = networkRepository;

  NetworkRepository get networkRepository => _networkRepository;

  Future<ResponseModel> login(
      {required String email, required String password});

  Future<ResponseModel> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    String? imagePath,
  });
}
