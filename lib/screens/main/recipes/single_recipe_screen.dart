import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/accordion/custom_accordion.dart';
import '../../../providers/recipe_step_provider.dart';
import '../../../widgets/loading/text_placeholder.dart';

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
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_firstTime) {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<RecipeStepProvider>(
        context,
        listen: false,
      ).fetchAllForRecipe(widget.id);
      setState(() {
        _isLoading = false;
      });
      _firstTime = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Recipe steps',
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 10.0,
              ),
              child: Center(
                child: Text(
                  widget.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CustomAccordion(
                title: const Text(
                  'Details',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: Text(
                  widget.description,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 15),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Steps',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Consumer<RecipeStepProvider>(
              builder: (context, recipeStepProvider, child) => _isLoading
                  ? Column(
                      children: [
                        _loadingText(),
                        _loadingText(),
                        _loadingText(),
                        _loadingText(),
                        _loadingText(),
                        _loadingText(),
                      ],
                    )
                  : Column(
                      children: [
                        ...recipeStepProvider.recipeSteps
                            .map(
                              (recipeStep) => Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Colors.black12,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8.0,
                                        left: 22.0,
                                        right: 8.0,
                                        bottom: 8.0,
                                      ),
                                      child: Text(
                                        recipeStep.order.toString(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    // TODO - afisare text dinamic (recipeStep.description)
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8.0,
                                          right: 22.0,
                                          bottom: 8.0,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              recipeStep.name,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 3),
                                            Text(
                                              recipeStep.description,
                                              // 'Adds snns siiwef wenfsdnfa wefwef sdfs sdfd d sfasfewf d afawergerrg dsgadfsdfw w w df sdfsdfsds asda dasdasd fdafds fsfsdf Adds snns siiwef wenfsdnfa wefwef sdfs sdfd d sfasfewf d afawergerrg dsgadfsdfw w w df sdfsdfsds asda dasdasd fdafds fsfsdf',
                                              style: const TextStyle(
                                                fontSize: 15,
                                              ),
                                              textAlign: TextAlign.justify,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList()
                      ],
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget _loadingText() {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black12,
          ),
        ),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: TextPlaceholder(
              width: 20,
              height: 15,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                right: 16,
                bottom: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  TextPlaceholder(
                    width: 200,
                    height: 15,
                  ),
                  SizedBox(height: 10),
                  TextPlaceholder(
                    width: 600,
                    height: 15,
                  ),
                  SizedBox(height: 10),
                  TextPlaceholder(
                    width: 600,
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
