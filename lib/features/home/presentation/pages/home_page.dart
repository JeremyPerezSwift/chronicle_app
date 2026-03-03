import 'package:chronicle_app/core/theme/app_colors.dart';
import 'package:chronicle_app/core/ui/widgets/circle_user_avatar.dart';
import 'package:chronicle_app/core/ui/widgets/default_button.dart';
import 'package:chronicle_app/core/ui/widgets/default_text_field.dart';
import 'package:chronicle_app/features/auth/presentation/bloc/user_bloc.dart';
import 'package:chronicle_app/features/auth/presentation/bloc/user_event.dart';
import 'package:chronicle_app/features/auth/presentation/bloc/user_state.dart';
import 'package:chronicle_app/features/create_game/presentation/page/create_game_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String route = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildJoinGameSection(context),
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
      actions: [
        IconButton(
          onPressed: () {
            onLogoutPressed(context);
          },
          icon: Icon(Icons.logout),
        ),
      ],
    );
  }

  Widget _buildJoinGameSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          // Join Code
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'Join via code',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          DefaultTextField(
            hintText: 'Enter game code',
            activeIcon: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_circle_right_outlined,
                size: 30,
              ),
            ),
          ),

          // Or
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'or',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),

          // Create new game
          DefaultButton(
            text: 'Create new game',
            onPressed: () {
              context.go(CreateGamePage.route);
            },
            backgroundColor: AppColors.secondary,
            textColor: AppColors.textColor,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
          ),
        ],
      ),
    );
  }

  void onLogoutPressed(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop();
                },
                child: Text('No'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<UserBloc>().add(LogoutEvent());
                },
                child: Text('Yes'),
              ),
            ],
          );
        });
  }
}
