import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../widgets/app_bar/custom_app_bar.dart';
import '../../../widgets/accordion/custom_accordion.dart';
import '../../../providers/recipe_step_provider.dart';
import '../../../widgets/loading/text_placeholder.dart';
import '../../../widgets/buttons/custom_elevated_button.dart';
import '../../../colors/my_colors.dart';
import '../../../widgets/modals/yes_no_modal.dart';
import '../../../providers/product_stock_provider.dart';
import '../home_screen.dart';

class SingleRecipeScreen extends StatefulWidget {
  const SingleRecipeScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.fromAvailableRecipeScreen,
  }) : super(key: key);

  final int id;
  final String name;
  final String description;
  final bool fromAvailableRecipeScreen;

  @override
  State<SingleRecipeScreen> createState() => _SingleRecipeScreenState();
}

class _SingleRecipeScreenState extends State<SingleRecipeScreen> {
  bool _firstTime = true;
  bool _isLoading = false;
  late NavigatorState _navigator;

  @override
  void didChangeDependencies() async {
    _navigator = Navigator.of(context);
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

  void _onDoneCooking() {
    showCupertinoDialog(
      context: context,
      builder: (context) => YesNoModal.yesNoModal(
        title: Text(
          widget.name,
        ),
        content: const Text(
          "We will remove the products required for this recipe from your stock. Continue?",
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () async {
              Navigator.pop(context);
              Map response = await Provider.of<ProductStockProvider>(
                context,
                listen: false,
              ).updateStockAfterCooking(widget.id);

              if (response['statusCode'] == 400) {
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      response['body']['error'],
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
              if (true) {}
              _navigator.pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) => const HomeScreen(),
                ),
                (Route<dynamic> route) => false,
              );
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Recipe steps',
      ),
      floatingActionButton: widget.fromAvailableRecipeScreen
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 90 / 100,
              height: 50,
              child: CustomElevatedButton(
                borderRadius: 15,
                backgroundColor: MyColors.greenColor,
                content: const Text(
                  'Cooked it!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                onSubmitCallback: _onDoneCooking,
              ),
            )
          : null,
      floatingActionButtonLocation: widget.fromAvailableRecipeScreen
          ? FloatingActionButtonLocation.centerFloat
          : null,
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
                'Ingredients',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Consumer<RecipeStepProvider>(
              builder: (context, recipeStepProvider, child) => _isLoading
                  ? Column(
                      children: [
                        loadingTextIngredients(w: 80),
                        loadingTextIngredients(w: 100),
                        loadingTextIngredients(w: 80),
                        loadingTextIngredients(w: 100),
                        loadingTextIngredients(w: 100),
                        loadingTextIngredients(w: 80),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: recipeStepProvider.ingredients.isEmpty
                          ? const Text(
                              'No ingredients required',
                              style: TextStyle(color: Colors.black87),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: recipeStepProvider.ingredients
                                  .map(
                                    (ingredient) => Row(
                                      children: [
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                            minWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                20 /
                                                100,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                '${ingredient.quantity} ',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              Text(
                                                '${ingredient.um.replaceAll('buc.', 'x')} ',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          ingredient.name,
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                    ),
            ),
            const SizedBox(height: 12),
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
                        _loadingTextSteps(),
                        _loadingTextSteps(),
                        _loadingTextSteps(),
                        _loadingTextSteps(),
                        _loadingTextSteps(),
                        _loadingTextSteps(),
                      ],
                    )
                  : Column(
                      children: [
                        ...recipeStepProvider.recipeSteps
                            .map(
                              (recipeStep) => Container(
                                key: Key(recipeStep.id.toString()),
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
            ),
            widget.fromAvailableRecipeScreen
                ? const SizedBox(
                    height: 70,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget loadingTextIngredients({required double w}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 20 / 100,
                ),
                child: Row(
                  children: const [
                    TextPlaceholder(
                      width: 40,
                      height: 15,
                    )
                  ],
                ),
              ),
              TextPlaceholder(
                width: w,
                height: 15,
              )
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _loadingTextSteps() {
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
