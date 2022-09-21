import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

import '../../../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../../../colors/my_colors.dart';
import '../../../../../../widgets/input_fields/text_input_field.dart';
import '../../../../../../helpers/input_field_validators.dart';
import '../../../../../../widgets/buttons/custom_elevated_button.dart';
import 'add_recipestep_screen.dart';
import '../../../../../../helpers/custom_animations.dart';
import '../../../../../../providers/group_provider.dart';
import '../../../../../../widgets/list_element/deletable_grey_element.dart';

class CreateRecipeScreen extends StatefulWidget {
  const CreateRecipeScreen({
    Key? key,
    required this.groupId,
  }) : super(key: key);

  final int groupId;

  @override
  State<CreateRecipeScreen> createState() => _CreateRecipeScreenState();
}

class _CreateRecipeScreenState extends State<CreateRecipeScreen> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<Map<String, dynamic>> _steps = [];

  void _onAddStep(Map<String, dynamic> recipeStep) {
    setState(() {
      _steps.add(recipeStep);
    });
  }

  void _onDeleteStep(Map<String, dynamic> recipeStep) {
    setState(() {
      _steps.removeAt(
        _steps.indexWhere(
          (step) =>
              step['stepName'] == recipeStep['name'] &&
              step['stepDescription'] == recipeStep['description'],
        ),
      );
    });
  }

  void _onReoderStep(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final row = _steps.removeAt(oldIndex);
      _steps.insert(newIndex, row);
    });
  }

  Future<void> _onFormSubmit() async {
    if (_key.currentState!.validate()) {
      Map response = await Provider.of<GroupProvider>(
        context,
        listen: false,
      ).addRecipe(
        widget.groupId,
        _nameController.text,
        _descriptionController.text.isNotEmpty
            ? _descriptionController.text
            : '<No description provided>',
        _steps
            .mapIndexed((index, step) => {
                  'name': step['stepName'],
                  'description': step['stepDescription'],
                  'ingredients': step['ingredients'],
                  'order': index + 1,
                })
            .toList(),
      );

      if (response['statusCode'] == 400) {
        // 400 - validation error
        if (!mounted) return;
        String errorBody = '';
        try {
          response['body']['error'].forEach((key, value) {
            errorBody = '${errorBody + value[0]}\n';
          });
        } catch (_) {
          errorBody = response['body']['error'];
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              errorBody,
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }

      if (response['statusCode'] == 200) {
        if (!mounted) return;
        // 200 - OK
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onActionTapCallback: _onFormSubmit,
        title: 'Create Recipe',
        border: const Border(
          bottom: BorderSide(color: Colors.black12),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Done',
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
      body: SingleChildScrollView(
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
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    label: 'Name*',
                    validatorCallback: InputFieldValidators.recipeNameValidator,
                  ),
                  TextInputField(
                    autofocus: false,
                    controller: _descriptionController,
                    keyboardType: TextInputType.text,
                    label: 'Description',
                    validatorCallback: (_) {
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomElevatedButton(
                    borderRadius: 5,
                    content: const Text(
                      '+ Add step',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: MyColors.greenColor,
                    onSubmitCallback: () {
                      Navigator.of(context).push(
                        CustomAnimations.pageTransitionRightToLeft(
                          AddRecipestepScreen(addStepCallback: _onAddStep),
                        ),
                      );
                    },
                  ),
                  ReorderableListView(
                    padding: EdgeInsets.only(
                      top: _steps.isNotEmpty ? 10.0 : 0.0,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    buildDefaultDragHandles: false,
                    shrinkWrap: true,
                    onReorder: _onReoderStep,
                    children: _steps
                        .mapIndexed(
                          (index, recipeStep) => ReorderableDragStartListener(
                            index: index,
                            key: Key((index + 1).toString()),
                            child: DeletableGreyElement(
                              thisIndex: index,
                              name: recipeStep['stepName']!,
                              description: recipeStep['stepDescription']!,
                              onDelete: _onDeleteStep,
                              elementType: 'recipe step',
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const Text(
              'Provide the recipe with a name and description, and add some preparation steps.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
