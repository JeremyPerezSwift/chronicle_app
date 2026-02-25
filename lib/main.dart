import 'package:chronicle_app/core/di/get_it.dart';
import 'package:chronicle_app/core/router/app_router.dart';
import 'package:chronicle_app/core/theme/app_theme.dart';
import 'package:chronicle_app/features/auth/presentation/bloc/user_bloc.dart';
import 'package:chronicle_app/features/auth/presentation/bloc/user_event.dart';
import 'package:chronicle_app/features/auth/presentation/bloc/user_state.dart';
import 'package:chronicle_app/features/auth/presentation/pages/auth_page.dart';
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

  runApp(BlocProvider(
    create: (context) => getIt<UserBloc>(),
    //create: (context) => getIt<UserBloc>()..add(GetUserEvent()),
    /*create: (context) {
      final bloc = getIt<UserBloc>();

      FirebaseAuth.instance.authStateChanges().first.then((user) {
        if (user != null) {
          bloc.add(GetUserEvent());
        }
      });

      return bloc;
    },*/
    child: MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: AppTheme.getTheme(),
      debugShowCheckedModeBanner: false,
      builder: (context, router) {
        return BlocListener<UserBloc, UserState>(
          listener: (context, state) {
            if (state.status == UserStatus.success) {
              AppRouter.router.go(HomePage.route);
            } else if (state.status == UserStatus.error) {
              AppRouter.router.go(AuthPage.route);
            }
          },
          child: router,
        );
      },
    ),
  ));
}
