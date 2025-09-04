import 'package:sleep_mind/app/domain/entities/models/auth_service.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  AuthRepositoryImpl(this.remote);

  @override
  Future<AuthUser?> signInWithGoogle() => remote.signInWithGoogle();

  @override
  Future<void> signOut() => remote.signOut();

  @override
  Stream<AuthUser?> authStateChanges() => remote.authStateChanges();

  @override
  AuthUser? get currentUser => remote.currentUser;
}