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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
              const SizedBox(height: 10),
              DefaultTextField(
                hintText: 'Enter story title',
                borderRadius: BorderRadius.circular(12),
              ),
              const SizedBox(height: 10),
              Text('Rounds', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500)),
            ],
          ),
        ),

        // ✅ donne une hauteur
        SizedBox(
          height: 52, // ajuste selon ton design
          child: NumberPicker(
            from: 3,
            to: 10,
            onNumberChanged: (value) {},
          ),
        ),
      ],
    );
  }
}
