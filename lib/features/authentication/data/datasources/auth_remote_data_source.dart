import 'package:sleep_mind/features/authentication/domain/entities/auth_service.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUser?> signInWithGoogle();
  Future<void> signOut();
  Stream<AuthUser?> authStateChanges();
  AuthUser? get currentUser;
}