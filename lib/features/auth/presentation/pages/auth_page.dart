import 'package:chronicle_app/core/theme/app_colors.dart';
import 'package:chronicle_app/core/ui/widgets/default_button.dart';
import 'package:chronicle_app/features/auth/presentation/bloc/user_bloc.dart';
import 'package:chronicle_app/features/auth/presentation/bloc/user_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../bloc/user_state.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  static const String route = '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<UserBloc, UserState>(
          builder: (context, state) {
            return Column(
              children: [
                Text(
                  "Chronicle",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Spacer(),
                SvgPicture.asset('assets/images/login_image.svg'),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Collaborate with friends to craft unique stories",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Spacer(flex: 2),
                DefaultButton(
                  text: "Login with Google",
                  textColor: AppColors.textColor,
                  backgroundColor: AppColors.secondary,
                  onPressed: () {
                    context.read<UserBloc>().add(LoginWithGoogleEvent());
                  },
                ),
              ],
            );
          },
          listener: (context, state) {
            if (state.status == UserStatus.error) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage ?? "")));
            }
          },
        ),
      ),
    );
  }
}
