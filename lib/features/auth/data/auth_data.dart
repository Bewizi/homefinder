import 'package:homefinder/core/data/supabase_api.dart';
import 'package:homefinder/features/auth/domain/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> createAccount({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
  }) async {
    try {
      // 1. Sign up the user in Supabase Auth
      final response = await supaBase.auth.signUp(
        email: email,
        password: password,
        data: {
          'full_name': fullName,
          'phone_number': phoneNumber,
        },
      );

      final userId = response.user?.id;

      if (userId != null) {
        await supaBase.from('profile').insert({
          'id': userId,
          'full_name': fullName,
          'phone_number': phoneNumber,
          'email': email,
        });
      }
    } on AuthException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  @override
  Future<void> login(String email, String password) async {
    try {
      final res = await supaBase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final session = res.session;
      final user = res.user;
      if (session != null || user != null) {
        print('Invalid User');
      }
    } catch (e) {
      throw Exception('Error Logging In: $e');
    }
  }

  @override
  Future<void> logout() async {
    await supaBase.auth.signOut();
  }
}
