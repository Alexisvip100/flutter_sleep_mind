import 'package:get_it/get_it.dart';
import 'package:sleep_mind/app/data/datasources/remote/auth_remote_data_source_impl.dart';
import 'package:sleep_mind/app/data/repositories/auth_repository_impl.dart';
import 'package:sleep_mind/app/domain/repositories/auth_repository.dart';
import 'package:sleep_mind/app/data/datasources/remote/auth_remote_data_source.dart' as ds;
import 'package:sleep_mind/app/domain/usecases/auth_state_changes.dart';
import 'package:sleep_mind/app/domain/usecases/sign_in_with_google.dart';
import 'package:sleep_mind/app/domain/usecases/sign_out.dart';
import 'package:sleep_mind/core/google_sign_in_adapter.dart';
import 'package:sleep_mind/core/firebase_auth_adapter.dart';

final sl = GetIt.instance;

Future<void> initDI() async {
  // External ports/adapters
  sl.registerLazySingleton(() => FirebaseAuthPort());
  sl.registerLazySingleton(() => GoogleAuthAdapter(sl()));

  // Data source
  sl.registerLazySingleton<ds.AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => SignInWithGoogle(sl()));
  sl.registerLazySingleton(() => SignOut(sl()));
  sl.registerLazySingleton(() => AuthStateChanges(sl()));
}
