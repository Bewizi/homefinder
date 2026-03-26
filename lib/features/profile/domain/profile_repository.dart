import 'package:homefinder/features/profile/domain/profile_domain.dart';

abstract class ProfileRepository {
  Future<UserProfile> getProfile();
  Future<void> updateProfile(UserProfile profile);
}
