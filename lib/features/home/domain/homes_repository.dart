import 'package:homefinder/features/home/domain/homes_domain.dart';

abstract class HomesRepository {
  Future<List<HomesDomain>> getAllHomes();
}
