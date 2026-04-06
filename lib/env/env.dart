import 'package:envied/envied.dart';

part 'env.g.dart';

// @Envied(path: '.env', obfuscate: true) // obfuscate: true คือการเข้ารหัสให้แกะยาก
@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: 'JWT_TOKEN')
  static const String jwtToken = _Env.jwtToken;
}