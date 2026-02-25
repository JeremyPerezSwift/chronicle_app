import 'package:chronicle_app/core/api/api_client.dart';
import 'package:chronicle_app/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:chronicle_app/features/auth/data/datasource/user_remote_datasource.dart';
import 'package:chronicle_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:chronicle_app/features/auth/data/repository/user_repository_impl.dart';
import 'package:chronicle_app/features/auth/domain/repository/auth_repository.dart';
import 'package:chronicle_app/features/auth/domain/repository/user_repository.dart';
import 'package:chronicle_app/features/auth/presentation/bloc/user_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setup() {
  registerApiClient();
  registerDatasource();
  registerRepository();
  registerBloc();
}

void registerApiClient() {
  getIt.registerSingleton(ApiClient());
}

void registerDatasource() {
  var dio = getIt<ApiClient>().getDio();
  var dioWithTokenInterceptor =
      getIt<ApiClient>().getDio(tokenInterceptor: true);

  getIt.registerSingleton(AuthRemoteDatasource(dio: dio));
  getIt.registerSingleton(UserRemoteDatasource(dio: dioWithTokenInterceptor));
}

void registerRepository() {
  getIt.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      authRemoteDatasource: getIt(),
    ),
  );
  getIt.registerSingleton<UserRepository>(
    UserRepositoryImpl(
      userRemoteDatasource: getIt(),
    ),
  );
}

void registerBloc() {
  getIt.registerFactory(
    () => UserBloc(
      authRepository: getIt(),
      userRepository: getIt(),
    ),
  );
}
