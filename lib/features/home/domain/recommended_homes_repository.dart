import 'package:homefinder/features/home/domain/recommended_homes_domain.dart';

abstract class RecommendedHomesRepository {
  Future<List<RecommendedHomesDomain>> getAllRecommendedHomes();
}
