import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

// import '../../core/constants/app_constants.dart';
import '../../services/api_client.dart';
import '../../services/auth_service.dart';
import '../../features/auth/data/auth_repository.dart';
import '../local_storage/local_storage_service.dart';
import '../../features/auth/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Local storage
  sl.registerSingletonAsync<LocalStorageService>(() async {
    final storage = LocalStorageService();
    await storage.init();
    return storage;
  });

  // Dio client with interceptors
  sl.registerSingletonWithDependencies<Dio>(
    () => createDio(sl<LocalStorageService>()),
    dependsOn: [LocalStorageService],
  );

  // Services & repositories
  sl.registerLazySingleton<AuthService>(() => AuthService(sl<Dio>()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepository(
        authService: sl<AuthService>(),
        localStorageService: sl<LocalStorageService>(),
      ));

  // Blocs
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl<AuthRepository>()));

  // Ensure async singletons are ready before use
  await sl.allReady();
}
