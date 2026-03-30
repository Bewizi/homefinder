import 'package:homefinder/core/data/supabase_api.dart';
import 'package:homefinder/features/profile/domain/profile_domain.dart';
import 'package:homefinder/features/profile/domain/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  @override
  Future<UserProfile> getProfile() async {
    try {
      final user = supaBase.auth.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      final data = await supaBase
          .from('profile')
          .select()
          .eq('id', user.id)
          .single();

      return UserProfile.fromJson(data);
    } catch (e) {
      throw Exception('Error fetching profile: $e');
    }
  }

  @override
  Future<void> updateProfile(UserProfile profile) async {
    try {
      await supaBase
          .from('profile')
          .update(profile.toJson())
          .eq('id', profile.id);
    } catch (e) {
      throw Exception('Error updating profile: $e');
    }
  }
}
