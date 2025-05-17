import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanachat/core/common/widgets/text_form_input.dart';
import 'package:kanachat/core/utils/show_snackbar.dart';
import 'package:kanachat/features/customization/domain/entities/chat_customization_entity.dart';
import 'package:kanachat/features/customization/presentation/bloc/chat_customization_bloc.dart';
import 'package:solar_icons/solar_icons.dart';

class CustomizationScreen extends StatefulWidget {
  const CustomizationScreen({super.key});

  @override
  State<CustomizationScreen> createState() => _CustomizationScreenState();
}

class _CustomizationScreenState extends State<CustomizationScreen> {
  // Form customization
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _traitsController = TextEditingController();
  final TextEditingController _additionalInfoController =
      TextEditingController();

  void _onSave() {
    // Validate form
    if (_formKey.currentState!.validate()) {
      // Get values from controllers
      final name = _nameController.text.trim();
      final occupation = _occupationController.text.trim();
      final traits = _traitsController.text.trim();
      final additionalInfo = _additionalInfoController.text.trim();

      // Save customization using Bloc
      context.read<ChatCustomizationBloc>().add(
        ChatCustomizationUpdated(
          customization: ChatCustomizationEntity(
            name: name,
            occupation: occupation,
            traits: traits,
            additionalInfo: additionalInfo,
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    // Get initial customization data
    context.read<ChatCustomizationBloc>().add(ChatCustomizationRequested());
    super.initState();
  }

  @override
  void dispose() {
    // Dispose controllers
    _nameController.dispose();
    _occupationController.dispose();
    _traitsController.dispose();
    _additionalInfoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customization')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Customize your chat',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 14),
              TextFormInput(
                controller: _nameController,
                maxLines: 1,
                labelText: 'What should KanaChat call you?',
                hintText: 'Enter your name',
              ),
              TextFormInput(
                controller: _occupationController,
                maxLines: 1,
                labelText: 'What do you do?',
                hintText: 'Engineer, student, etc.',
              ),
              TextFormInput(
                controller: _traitsController,
                maxLines: 5,
                labelText: 'What traits should KanaChat have?',
                hintText:
                    'Enter traits separated by commas (e.g. Chatty, Witty, Opinionated)',
              ),
              TextFormInput(
                controller: _additionalInfoController,
                maxLines: 5,
                labelText: 'Anything else KanaChat should know about you?',
                hintText: 'Interests, values, or preferences to keep in mind',
              ),
              BlocConsumer<ChatCustomizationBloc, ChatCustomizationState>(
                listener: (context, state) {
                  if (state is ChatCustomizationLoaded) {
                    // Populate the form with existing customization data
                    final customization = state.customization;
                    _nameController.text = customization.name ?? '';
                    _occupationController.text = customization.occupation ?? '';
                    _traitsController.text = customization.traits ?? '';
                    _additionalInfoController.text =
                        customization.additionalInfo ?? '';
                  }
                  if (state is ChatCustomizationSaved) {
                    showSnackBar(
                      context: context,
                      message: 'Customization saved successfully',
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      textColor: Colors.white,
                    );
                  }
                  if (state is ChatCustomizationError) {
                    showSnackBar(context: context, message: state.message);
                  }
                },
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed:
                        state is ChatCustomizationLoading ? null : _onSave,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 32,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child:
                          state is ChatCustomizationLoading
                              ? Center(
                                child: Icon(SolarIconsBold.menuDots, size: 23)
                                    .animate(
                                      onPlay:
                                          (controller) => controller.repeat(),
                                    )
                                    .fade(duration: 1000.ms),
                              )
                              : const Text(
                                'Save Customization',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
