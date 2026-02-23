import 'package:chronicle_app/core/di/get_it.dart';
import 'package:chronicle_app/core/router/app_router.dart';
import 'package:chronicle_app/core/theme/app_theme.dart';
import 'package:chronicle_app/features/auth/presentation/bloc/user_bloc.dart';
import 'package:chronicle_app/firebase_options.dart';
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
    child: MaterialApp.router(
      routerConfig: AppRouter.router,
      theme: AppTheme.getTheme(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}