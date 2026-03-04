import 'dart:developer';

import 'package:chronicle_app/core/theme/app_colors.dart';
import 'package:chronicle_app/core/ui/widgets/default_button.dart';
import 'package:chronicle_app/core/ui/widgets/default_text_field.dart';
import 'package:chronicle_app/features/create_game/presentation/widgets/number_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateGamePage extends StatefulWidget {
  const CreateGamePage({super.key});

  static const String route = '/create_game';

  @override
  State<CreateGamePage> createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {
  String title = '';
  int rounds = 3;
  int roundDuration = 2;
  int votingDuration = 2;
  int maximumParticipants = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.chevron_left),
          ),
          Text(
            'Create game',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
      titleSpacing: 0,
      toolbarHeight: 60,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// Title
          Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
                const SizedBox(height: 10),
                DefaultTextField(
                  hintText: 'Enter story title',
                  onChanged: (value) {
                    setState(() {
                      title = value;
                    });
                  },
                  borderRadius: BorderRadius.circular(12),
                ),
              ],
            ),
          ),

          /// Rounds
          _buildContentNumberPicker(context, 'Rounds', 3, 10, (value) {
            setState(() {
              rounds = value;
            });
          }),

          /// Round duration (minutes)
          _buildContentNumberPicker(context, 'Round duration (minutes)', 2, 10, (value) {
            setState(() {
              roundDuration = value;
            });
          }),

          /// Voting duration (minutes)
          _buildContentNumberPicker(context, 'Voting duration (minutes)', 2, 10, (value) {
            setState(() {
              votingDuration = value;
            });
          }),

          /// Maximum participants
          _buildContentNumberPicker(context, 'Maximum participants', 2, 10, (value) {
            setState(() {
              maximumParticipants = value;
            });
          }),

          /// Creat Button
          Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: DefaultButton(
              text: 'Create',
              onPressed: title.isEmpty ? null : () {},
              backgroundColor: AppColors.secondary,
              textColor: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentNumberPicker(BuildContext context, String title, int from, int to, Function(int) onNumberChanged) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          SizedBox(
            height: 52, // ajuste selon ton design
            child: NumberPicker(
              from: from,
              to: to,
              onNumberChanged: onNumberChanged,
            ),
          ),
        ],
      ),
    );
  }
}
