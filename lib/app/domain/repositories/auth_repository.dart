import 'package:sleep_mind/app/domain/entities/models/auth_service.dart';


abstract class AuthRepository {
  Future<AuthUser?> signInWithGoogle();
  Future<void> signOut();
  Stream<AuthUser?> authStateChanges();
  AuthUser? get currentUser;
}