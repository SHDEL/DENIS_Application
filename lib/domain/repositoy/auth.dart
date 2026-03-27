abstract class AuthRepository {
  Future<Map<String, dynamic>> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<void> signOut();
}