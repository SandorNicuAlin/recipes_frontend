import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipes_frontend/classes/recipe.dart';

import '../../../widgets/app_bar/custom_app_bar_with_image.dart';
import '../../../widgets/accordion/custom_accordion.dart';
import '../../../providers/recipe_step_provider.dart';

class SingleRecipeScreen extends StatefulWidget {
  const SingleRecipeScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
  }) : super(key: key);

  final int id;
  final String name;
  final String description;

  @override
  State<SingleRecipeScreen> createState() => _SingleRecipeScreenState();
}

class _SingleRecipeScreenState extends State<SingleRecipeScreen> {
  bool _firstTime = true;

  @override
  void didChangeDependencies() async {
    if (_firstTime) {
      await Provider.of<RecipeStepProvider>(
        context,
        listen: false,
      ).fetchAllForRecipe(widget.id);
      _firstTime = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 40 / 100,
        ),
        child: CustomAppBarWithImage(
          image: const AssetImage('images/groceries.png'),
          title: widget.name,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 15),
              CustomAccordion(
                title: const Text(
                  'Details',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: Text(
                  widget.description,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                ' Steps',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Consumer<RecipeStepProvider>(
                builder: (context, recipeStepProvider, child) => Column(
                  children: [
                    ...recipeStepProvider.recipeSteps
                        .map(
                          (recipe) => Text(recipe.name),
                        )
                        .toList()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
