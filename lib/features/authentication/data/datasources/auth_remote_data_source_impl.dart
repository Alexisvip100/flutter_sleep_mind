import 'package:sleep_mind/features/authentication/domain/entities/auth_service.dart';
import 'package:sleep_mind/features/authentication/external%20/google_sign_in_adapter.dart';

import '../datasources/auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final GoogleAuthAdapter adapter;
  AuthRemoteDataSourceImpl(this.adapter);

  @override
  Future<AuthUser?> signInWithGoogle() => adapter.signIn();

  @override
  Future<void> signOut() => adapter.signOut();

  @override
  Stream<AuthUser?> authStateChanges() => adapter.authStateChanges();

  @override
  AuthUser? get currentUser => adapter.currentUser;
}