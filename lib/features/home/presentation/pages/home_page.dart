import 'package:chronicle_app/core/theme/app_colors.dart';
import 'package:chronicle_app/core/ui/widgets/circle_user_avatar.dart';
import 'package:chronicle_app/features/auth/presentation/bloc/user_bloc.dart';
import 'package:chronicle_app/features/auth/presentation/bloc/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          final userModel = state.userModel;

          return Row(
            children: [
              CircleUserAvatar(
                  width: 50, height: 50, url: userModel?.photoUrl ?? ''),
              SizedBox(width: 10),
              Text(
                userModel?.name ?? '',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          );
        },
      ),
    );
  }
}
