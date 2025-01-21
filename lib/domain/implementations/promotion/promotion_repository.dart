import '../../../data/models/promotion/promotion_model.dart';
import '../../../data/models/response/response_model.dart';
import '../../../data/repositories/promotion/base_promotion_repository.dart';

class PromotionRepository extends BasePromotionRepository {
  PromotionRepository({
    required super.backendConfigs,
    required super.networkRepository,
  });

  @override
  Future<List<PromotionInfo>> getAllPromotions() async {
    try {
      final res = await super.networkRepository.get(
            uri: super.backendConfigs.buildUri(
              segments: [
                super.backendConfigs.promotion,
              ],
            ),
          );
      return ResponseModel<List<PromotionInfo>>.fromJson(
            res,
            (data) => data == null
                ? []
                : List<PromotionInfo>.from(
                    data!.map((e) => PromotionInfo.fromJson(e))),
          ).data ??
          [];
    } catch (e) {
      rethrow;
    }
  }
}
