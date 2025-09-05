import 'package:sleep_mind/app/domain/entities/models/auth_service.dart';

import '../repositories/auth_repository.dart';

class AuthStateChanges {
  final AuthRepository repo;
  AuthStateChanges(this.repo);
  
  Stream<AuthUser?> call() => repo.authStateChanges();
}