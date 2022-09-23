import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:another_flushbar/flushbar.dart';

import '../../../../../widgets/app_bar/custom_app_bar_with_image.dart';
import '../../../../../providers/group_provider.dart';
import '../../../../../classes/group.dart';
import '../../../../../colors/my_colors.dart';
import '../../../../../widgets/modals/yes_no_modal.dart';
import '../../../../../helpers/custom_animations.dart';
import './add_member_screen.dart';
import '../../../../../widgets/buttons/custom_elevated_button.dart';
import 'recipes/create_recipe_screen.dart';
import '../../../../../widgets/loading/custom_circular_progress_indicator.dart';
import '../../../recipes/single_recipe_screen.dart';
import '../../../../../classes/recipe.dart';

class SingleUserGroupScreen extends StatefulWidget {
  const SingleUserGroupScreen({
    Key? key,
    required this.groupId,
    required this.name,
    required this.isAdministrator,
  }) : super(key: key);

  final int groupId;
  final String name;
  final bool isAdministrator;

  @override
  State<SingleUserGroupScreen> createState() => _SingleUserGroupScreenState();
}

class _SingleUserGroupScreenState extends State<SingleUserGroupScreen> {
  bool _isLoading = false;

  void _giveAdminPrivilages(String username, int userId, int groupId) {
    showCupertinoDialog(
      context: context,
      builder: (context) => YesNoModal.yesNoModal(
        title: const Text(
          'Administrator Privilages',
        ),
        content: Text(
          'Do you want to give $username administrator privilages?',
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text('Yes'),
            onPressed: () async {
              Navigator.pop(context);
              Map response = await Provider.of<GroupProvider>(
                context,
                listen: false,
              ).giveAdminPrivilages(
                userId,
                groupId,
              );

              if (response['statusCode'] == 400) {
                if (true) {}
                await Flushbar(
                  backgroundColor: Colors.red,
                  title: 'Error',
                  message: 'Something went wrong',
                  duration: const Duration(seconds: 3),
                ).show(context);
              }
            },
          ),
          CupertinoDialogAction(
            child: const Text('No'),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      barrierDismissible: true,
    );
  }

  Future<void> _openRecipes() async {
    setState(() {
      _isLoading = true;
    });
    await Provider.of<GroupProvider>(
      context,
      listen: false,
    ).fetchRecipesForGroup(widget.groupId);
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
    showModalBottomSheet(
      isScrollControlled: true,
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 20 / 100,
        maxHeight: MediaQuery.of(context).size.height * 80 / 100,
        minWidth: MediaQuery.of(context).size.width,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) => Consumer<GroupProvider>(
        builder: (context, groupProvider, child) =>
            groupProvider.recipes.isEmpty
                ? const Center(
                    child: Text(
                      'No recipes available',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  )
                : recipesList(groupProvider.recipes),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 50 / 100,
        ),
        child: CustomAppBarWithImage(
          image: const AssetImage('images/groceries_2_2x.png'),
          title: widget.name,
          actions: widget.isAdministrator
              ? [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          CustomAnimations.pageTransitionRightToLeft(
                            AddGroupMemberScreen(
                              groupId: widget.groupId,
                              groupName: widget.name,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.group_add_rounded),
                    ),
                  ),
                ]
              : [],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20.0,
              ),
              child: Row(
                mainAxisAlignment: widget.isAdministrator
                    ? MainAxisAlignment.spaceEvenly
                    : MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 150,
                    height: 38,
                    child: CustomElevatedButton(
                      borderRadius: 5,
                      content: _isLoading
                          ? const SizedBox(
                              width: 25,
                              height: 25,
                              child: CustomCircularProgressIndicator(),
                            )
                          : const Text(
                              'Recipes',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                      backgroundColor: MyColors.greenColor,
                      onSubmitCallback: _isLoading ? () {} : _openRecipes,
                    ),
                  ),
                  widget.isAdministrator
                      ? SizedBox(
                          width: 150,
                          height: 38,
                          child: CustomElevatedButton(
                            borderRadius: 5,
                            content: const Text(
                              'Create Recipe',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            backgroundColor: MyColors.greenColor,
                            onSubmitCallback: () {
                              Navigator.of(context).push(
                                CustomAnimations.pageTransitionRightToLeft(
                                  CreateRecipeScreen(groupId: widget.groupId),
                                ),
                              );
                            },
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
            Text(
              widget.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Consumer<GroupProvider>(
              builder: (context, groupProvider, child) {
                Group group = groupProvider.groupByName(widget.name)!;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ListView.builder(
                      itemCount: group.members.length,
                      itemBuilder: (context, index) => Padding(
                        key: Key(group.members[index].id.toString()),
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: MyColors.greenColor,
                                    ),
                                    width: 45,
                                    height: 45,
                                    child: Center(
                                      child: Text(
                                        group.members[index].username[0]
                                            .toUpperCase(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        3 /
                                        100,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        group.members[index].username,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.5 /
                                                100,
                                      ),
                                      Text(
                                        group.members[index].email,
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              group.members[index].isAdministrator!
                                  ? const FaIcon(
                                      FontAwesomeIcons.solidChessKing,
                                      color: MyColors.greenColor,
                                    )
                                  : (widget.isAdministrator
                                      ? InkWell(
                                          child: const FaIcon(
                                            FontAwesomeIcons.chessKing,
                                            color: MyColors.greenColor,
                                          ),
                                          onTap: () {
                                            _giveAdminPrivilages(
                                              group.members[index].username,
                                              group.members[index].id,
                                              group.id,
                                            );
                                          },
                                        )
                                      : Container()),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget recipesList(List<Recipe> recipes) {
    Future<void> _onDelete(int recipeId) async {
      Navigator.pop(context);
      Map response = await Provider.of<GroupProvider>(
        context,
        listen: false,
      ).deleteRecipeForGroup(
        widget.groupId,
        recipeId,
      );

      if (response['statusCode'] == 400) {
        if (!mounted) return;
        Navigator.pop(context);
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
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(
            top: 15.0,
            bottom: 15.0,
          ),
          width: MediaQuery.of(context).size.width * 20 / 100,
          height: 4.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: recipes
                  .map(
                    (recipe) => Dismissible(
                      confirmDismiss: (_) {
                        return showCupertinoDialog(
                          context: context,
                          builder: (context) => YesNoModal.yesNoModal(
                            title: const Text(
                              'Delete recipe',
                            ),
                            content: Text(
                              "Are you sure you want to delete '${recipe.name}?'",
                            ),
                            actions: [
                              CupertinoDialogAction(
                                onPressed: () async {
                                  await _onDelete(recipe.id);
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
                      },
                      direction: DismissDirection.endToStart,
                      background: Container(
                        margin: const EdgeInsets.only(
                          left: 5.0,
                          top: 3.0,
                          right: 5.0,
                          bottom: 3.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withAlpha(210),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 16.0),
                            child: Icon(CupertinoIcons.delete),
                          ),
                        ),
                      ),
                      key: Key(recipe.id.toString()),
                      child: Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              CustomAnimations.pageTransitionRightToLeft(
                                SingleRecipeScreen(
                                  id: recipe.id,
                                  name: recipe.name,
                                  description: recipe.description,
                                ),
                              ),
                            );
                          },
                          title: Text(
                            recipe.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.fade,
                          ),
                          subtitle: Text(
                            recipe.description,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
