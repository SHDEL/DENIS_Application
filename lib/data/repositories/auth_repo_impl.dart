import 'package:denis/data/service/auth_firebase_service.dart';
import 'package:denis/dataconnect_generated/generated.dart';
import 'package:denis/domain/repositoy/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';

class AuthRepoImpl extends AuthRepository{

  final AuthFirebaseService _authService = AuthFirebaseServiceImpl();
  ExampleConnector get _connector => ExampleConnector.instance;

  AuthRepoImpl();

  @override
  Future<String> signIn(String email, String password) async{
    try {
      UserCredential credential = await _authService.signIn(email, password);
      String uid = credential.user!.uid;
      // await _connector.getUserByEmail(email: email, password: password).execute();
      return uid;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<String> signUp(String email, String password) async {
    try {
      UserCredential credential = await _authService.signUp(email, password);
      String uid = credential.user!.uid;

      await _connector.createUser(
        id: uid,
        email: email,
        username: email.split('@')[0],
        role: "USER"
      ).execute();
      print('User created with UID: $uid');
      return uid;
    } catch (e) {
      rethrow;
    }
  }
 
}