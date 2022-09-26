import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/recipe_provider.dart';
import '../../../providers/group_provider.dart';
import 'package:recipes_frontend/classes/group.dart';
import '../../../widgets/cards/custom_card_2.dart';
import '../../../colors/my_colors.dart';
import '../../../widgets/loading/custom_circular_progress_indicator.dart';
import '../../../widgets/input_fields/ios_search_field.dart';
import '../../../classes/recipe.dart';
import '../../../helpers/custom_animations.dart';
import './single_recipe_screen.dart';

class RecipesScreen extends StatefulWidget {
  const RecipesScreen({Key? key}) : super(key: key);

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool _firstTime = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    if (_firstTime) {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<GroupProvider>(
        context,
        listen: false,
      ).fetchAllForUser();
      if (!mounted) return;
      List<Group> groups = Provider.of<GroupProvider>(
        context,
        listen: false,
      ).groups_by_user;
      List groupsId = groups.map((group) => group.id).toList();
      if (!mounted) return;
      await Provider.of<RecipeProvider>(
        context,
        listen: false,
      ).getAvailableForGroups(groupsId);
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      _firstTime = false;
    }
    super.didChangeDependencies();
  }

  void _onSearchHandler(String value) {
    Provider.of<RecipeProvider>(
      context,
      listen: false,
    ).filterByText(value);
  }

  Future<void> _onPageRefresh() async {
    await Provider.of<GroupProvider>(
      context,
      listen: false,
    ).fetchAllForUser();
    if (!mounted) return;
    List<Group> groups = Provider.of<GroupProvider>(
      context,
      listen: false,
    ).groups_by_user;
    List groupsId = groups.map((group) => group.id).toList();
    if (!mounted) return;
    await Provider.of<RecipeProvider>(
      context,
      listen: false,
    ).getAvailableForGroups(groupsId);
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    List<Recipe> recipes = Provider.of<RecipeProvider>(context).filteredRecipes;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: Text(
              'Available Recipes',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _isLoading
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: IosSearchField(
                          onChangeCallback: _onSearchHandler,
                          controller: _searchController,
                          prefixIcon: const Icon(Icons.search_rounded),
                          suffixIcon: const Icon(Icons.clear_rounded),
                        ),
                      ),
                const SizedBox(height: 5),
                _isLoading
                    ? const Center(
                        child: CustomCircularProgressIndicator(
                          color: MyColors.greenColor,
                        ),
                      )
                    : Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            bottom:
                                MediaQuery.of(context).size.height * 10.3 / 100,
                          ),
                          child: RefreshIndicator(
                            onRefresh: _onPageRefresh,
                            color: MyColors.greenColor,
                            child: recipes.isEmpty
                                ? GridView(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 1,
                                    ),
                                    children: const [
                                      Center(
                                        child: Text(
                                          'No recipes available',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      )
                                    ],
                                  )
                                : GridView.builder(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                    ),
                                    itemCount: recipes.length,
                                    itemBuilder: (context, index) => InkWell(
                                      key: Key(recipes[index].id.toString()),
                                      borderRadius: BorderRadius.circular(40),
                                      onTap: () {
                                        Navigator.of(context).push(
                                          CustomAnimations
                                              .pageTransitionRightToLeft(
                                            SingleRecipeScreen(
                                              id: recipes[index].id,
                                              name: recipes[index].name,
                                              description:
                                                  recipes[index].description,
                                              fromAvailableRecipeScreen: true,
                                            ),
                                          ),
                                        );
                                      },
                                      child: CustomCardTwo(
                                        color: MyColors.greenColor,
                                        image: Image.asset(
                                          'images/frashfruits&vegetable.png',
                                        ).image,
                                        text: recipes[index].name,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
