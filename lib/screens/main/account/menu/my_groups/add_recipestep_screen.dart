import 'package:flutter/material.dart';

import '../../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../../colors/my_colors.dart';
import '../../../../../helpers/input_field_validators.dart';
import '../../../../../widgets/input_fields/text_input_field.dart';
import '../../../../../classes/recipe_step.dart';

class AddRecipestepScreen extends StatefulWidget {
  const AddRecipestepScreen({
    Key? key,
    required this.addStepCallback,
  }) : super(key: key);

  final Function addStepCallback;

  @override
  State<AddRecipestepScreen> createState() => _AddRecipestepScreenState();
}

class _AddRecipestepScreenState extends State<AddRecipestepScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _stepNameController = TextEditingController();
  final TextEditingController _stepDescriptionController =
      TextEditingController();

  void _onAdd() {
    if (_key.currentState!.validate()) {
      widget.addStepCallback({
        'stepName': _stepNameController.text,
        'stepDescription': _stepDescriptionController.text,
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onActionTapCallback: _onAdd,
        title: 'Add Recipe Step',
        border: const Border(
          bottom: BorderSide(color: Colors.black12),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Add',
                style: TextStyle(
                  color: MyColors.greenColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextInputField(
                    autofocus: true,
                    controller: _stepNameController,
                    keyboardType: TextInputType.text,
                    label: 'Step name*',
                    validatorCallback:
                        InputFieldValidators.recipeStepNameValidator,
                  ),
                  TextInputField(
                    label: 'Step description*',
                    autofocus: false,
                    controller: _stepDescriptionController,
                    keyboardType: TextInputType.multiline,
                    validatorCallback: (String? value) =>
                        InputFieldValidators.checkIfEmpty(
                      value,
                      errorMessage: 'The step description is required',
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Provide the recipe step with a name and description.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
