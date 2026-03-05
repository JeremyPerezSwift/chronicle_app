import 'package:chronicle_app/core/di/get_it.dart';
import 'package:chronicle_app/core/router/app_router.dart';
import 'package:chronicle_app/core/theme/app_theme.dart';
import 'package:chronicle_app/features/auth/presentation/bloc/user_bloc.dart';
import 'package:chronicle_app/features/auth/presentation/bloc/user_event.dart';
import 'package:chronicle_app/features/auth/presentation/bloc/user_state.dart';
import 'package:chronicle_app/features/auth/presentation/pages/auth_page.dart';
import 'package:chronicle_app/features/create_game/presentation/bloc/create_game_bloc.dart';
import 'package:chronicle_app/features/home/presentation/pages/home_page.dart';
import 'package:chronicle_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setup();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => getIt<UserBloc>(),
      ),
      BlocProvider(
        create: (context) => getIt<CreateGameBloc>(),
      ),
    ],
    child: MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: AppTheme.getTheme(),
      debugShowCheckedModeBanner: false,
      builder: (context, router) {
        return BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state.status == UserStatus.success) {
              AppRouter.router.go(HomePage.route);
            } else if (state.status == UserStatus.error ||
                state.status == UserStatus.logout) {
              print('Redirecting to AuthPage');
              print('Error message: ${state.errorMessage}');
              print(
                  'Firebase currentUser now: ${FirebaseAuth.instance.currentUser?.uid}');

              AppRouter.router.go(AuthPage.route);
            }
          },
          child: router,
        );
      },
    ),
  ));
}
