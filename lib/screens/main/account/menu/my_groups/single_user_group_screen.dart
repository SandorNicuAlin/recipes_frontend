import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/app_bar/custom_app_bar_with_image.dart';
import '../../../../../providers/group_provider.dart';
import '../../../../../classes/group.dart';
import '../../../../../colors/my_colors.dart';

class SingleUserGroupScreen extends StatelessWidget {
  const SingleUserGroupScreen({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 60 / 100,
        ),
        child: CustomAppBarWithImage(
          image: const AssetImage('images/groceries_2_2x.png'),
          title: name,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
        ),
        child: Center(
          child: Column(
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Consumer<GroupProvider>(
                builder: (context, groupProvider, child) {
                  Group group = groupProvider.groupByName(name)!;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListView.builder(
                        itemCount: group.members.length,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
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
                                width:
                                    MediaQuery.of(context).size.width * 3 / 100,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    group.members[index].username,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
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
                        ),
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
