import 'package:chronicle_app/features/auth/presentation/bloc/user_bloc.dart';
import 'package:chronicle_app/features/auth/presentation/bloc/user_event.dart';
import 'package:chronicle_app/features/auth/presentation/pages/auth_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  static const String route = '/splash';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    // 1) Attendre que Firebase restaure la session
    final user = await FirebaseAuth.instance.authStateChanges().first;

    if (!mounted) return;

    // 2) Déclencher après le 1er frame pour éviter "bloqué sur splash"
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (user == null) {
        context.go(AuthPage.route);
      } else {
        // user existe -> demander le profile au backend
        context.read<UserBloc>().add(GetUserEvent());
        // la navigation vers Home se fera via ton BlocListener dans main
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

/*import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static const String route = '/splash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Chronicle',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
    );
  }
}*/
