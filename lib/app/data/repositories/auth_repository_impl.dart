import 'package:sleep_mind/app/domain/entities/models/auth_service.dart';

import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_data_source.dart';
import '../datasources/remote/user_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remote;
  final UserRemoteDataSource userRemote;

  AuthRepositoryImpl(this.remote, this.userRemote);

  @override
  Future<AuthUser?> signInWithGoogle() async {
    print('🔐 Iniciando proceso de login con Google...');
    final user = await remote.signInWithGoogle();
    if (user != null) {
      print('✅ Login exitoso, usuario: ${user.name}');
      // Sincronizar con la API después del login exitoso
      print('📡 Iniciando sincronización con API...');
      await syncUserToApi(user);
    } else {
      print('❌ Login falló - usuario es null');
    }
    return user;
  }

  @override
  Future<void> signOut() => remote.signOut();

  @override
  Stream<AuthUser?> authStateChanges() => remote.authStateChanges();

  @override
  AuthUser? get currentUser => remote.currentUser;


  Future<void> syncUserToApi(AuthUser user) => userRemote.syncUserData(user);
}