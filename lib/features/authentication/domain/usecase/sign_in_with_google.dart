import 'package:sleep_mind/features/authentication/domain/entities/auth_service.dart';

import '../repositories/auth_repository.dart';

class SignInWithGoogle {
  final AuthRepository repo;
  SignInWithGoogle(this.repo);

  Future<AuthUser?> call() => repo.signInWithGoogle();
}