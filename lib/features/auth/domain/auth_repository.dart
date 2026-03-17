abstract class AuthRepository {
  Future<void> createAccount({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
  });

  Future<void> login(String email, String password);

  Future<void> logout();
}
