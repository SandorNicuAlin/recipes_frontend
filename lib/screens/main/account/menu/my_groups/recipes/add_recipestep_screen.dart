import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../../../colors/my_colors.dart';
import '../../../../../../helpers/input_field_validators.dart';
import '../../../../../../widgets/input_fields/text_input_field.dart';
import '../../../../../../widgets/buttons/custom_elevated_button.dart';
import '../../../../../../helpers/custom_animations.dart';
import './add_ingredient_screen.dart';
import '../../../../../../widgets/list_element/deletable_grey_element.dart';
import '../../../../../../widgets/modals/yes_no_modal.dart';

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
  final List<Map<String, String>> _ingredients = [];

  void _onAdd() {
    if (_key.currentState!.validate()) {
      widget.addStepCallback({
        'stepName': _stepNameController.text,
        'stepDescription': _stepDescriptionController.text,
        'ingredients': _ingredients,
      });
      Navigator.pop(context);
    }
  }

  void _onGetIngredient(Map<String, String> ingredient) {
    setState(() {
      _ingredients.add(ingredient);
    });
  }

  void _onDeleteIngredient(Map<String, String> ingredient) {
    setState(() {
      _ingredients.removeAt(
        _ingredients.indexWhere(
          (step) =>
              step['name'] == ingredient['name'] &&
              step['quantity'] == ingredient['description'],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onGobackCallback: (() {
          if (_stepNameController.text == '' &&
              _stepDescriptionController.text == '' &&
              _ingredients.isEmpty) {
            Navigator.pop(context);
            return;
          }
          showCupertinoDialog(
            context: context,
            builder: (context) => YesNoModal.yesNoModal(
              title: const Text(
                'Confirm discard changes',
              ),
              content: const Text(
                "Are you sure you want to discard all changes?",
              ),
              actions: [
                CupertinoDialogAction(
                  onPressed: () async {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: const Text('Yes'),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('No'),
                )
              ],
            ),
            barrierDismissible: true,
          );
        }),
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
                  const SizedBox(height: 10),
                  CustomElevatedButton(
                    borderRadius: 5,
                    content: const Text(
                      '+ Add ingredient',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    backgroundColor: MyColors.greenColor,
                    onSubmitCallback: () {
                      Navigator.of(context).push(
                        CustomAnimations.pageTransitionRightToLeft(
                          AddIngredientScreen(
                            addIngredientCallback: _onGetIngredient,
                          ),
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                      top: _ingredients.isNotEmpty ? 10.0 : 0.0,
                    ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _ingredients.length,
                    itemBuilder: (context, index) => DeletableGreyElement(
                      key: Key((index + 1).toString()),
                      thisIndex: index,
                      name: _ingredients[index]['name']!,
                      description: _ingredients[index]['quantity']!,
                      onDelete: _onDeleteIngredient,
                      elementType: 'ingredient',
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
