import '../../../data/models/auth/login_model.dart';
import '../../../data/models/response/response_model.dart';
import '../../../data/repositories/auth/base_auth_repository.dart';
import '../../services/session_manager.dart';

class AuthRepository extends BaseAuthRepository {
  AuthRepository(
      {required super.backendConfigs,
      required super.networkRepository,
      required super.imageServices});

  @override
  Future<ResponseModel> login(
      {required String email, required String password}) async {
    try {
      final res = await super.networkRepository.post(
        uri: super.backendConfigs.buildUri(
          segments: [
            super.backendConfigs.customer,
            super.backendConfigs.login,
          ],
        ),
        data: {
          'email': email,
          'password': password,
        },
      );

      final model = ResponseModel<LoginModel>.fromJson(
        res,
        (data) => LoginModel.fromJson(data),
      );
      if (model.data != null) {
        await SessionManager().setLoggedIn(model.data!);
        return model;
      } else {
        throw 'user info not found';
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ResponseModel> signUp(
      {required String email,
      required String password,
      required String fullName,
      required String phoneNumber,
      String? imagePath}) async {
    try {
      String? image;
      if (imagePath != null) {
        image = (await super.imageServices.uploadImages([imagePath])).first;
      }
      final res = await super.networkRepository.post(
        uri: super.backendConfigs.buildUri(
          segments: [
            super.backendConfigs.customer,
            super.backendConfigs.signUp,
          ],
        ),
        data: {
          'email': email,
          'password': password,
          'name': fullName,
        },
      );
      return ResponseModel.fromJson(
        res,
        (data) => null,
      );
    } catch (e) {
      rethrow;
    }
  }
}
