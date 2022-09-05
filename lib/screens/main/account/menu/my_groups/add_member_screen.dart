import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../../colors/my_colors.dart';
import '../../../../../widgets/input_fields/ios_search_field.dart';
import '../../../../../providers/user_provider.dart';
import '../../../../../providers/group_provider.dart';
import '../../../../../widgets/modals/yes_no_modal.dart';

class AddGroupMemberScreen extends StatefulWidget {
  const AddGroupMemberScreen({
    Key? key,
    required this.groupId,
    required this.groupName,
  }) : super(key: key);

  final dynamic groupId;
  final String groupName;

  @override
  State<AddGroupMemberScreen> createState() => _AddGroupMemberScreenState();
}

class _AddGroupMemberScreenState extends State<AddGroupMemberScreen> {
  List _filteredNonmembers = [];
  final TextEditingController _controller = TextEditingController();

  void _onSearchHandler(String text) async {
    await Future.delayed(const Duration(milliseconds: 250));
    if (true) {}
    _filteredNonmembers = await Provider.of<UserProvider>(
      context,
      listen: false,
    ).fetchAllThatDontBelongToGroup(
      widget.groupId,
      text,
    );
    setState(() {});
  }

  Future<void> _inviteToGroup(List newMembers) async {
    Navigator.pop(context);
    Map response = await Provider.of<GroupProvider>(
      context,
      listen: false,
    ).groupInvite(
      widget.groupId,
      newMembers,
    );
    if (true) {}
    Navigator.pop(context);
    if (response['statusCode'] == 400) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Something went wrong',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onActionTapCallback: () {},
        title: 'Add new member',
        border: const Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 8.0,
              bottom: 8.0,
            ),
            child: IosSearchField(
              prefixIcon: const Icon(Icons.search_rounded),
              suffixIcon: const Icon(Icons.clear_rounded),
              controller: _controller,
              onChangeCallback: _onSearchHandler,
            ),
          ),
          _controller.value.text.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Search for an user to add.',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : (_filteredNonmembers.isEmpty
                  ? const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        'No one to add.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: _filteredNonmembers.length,
                        itemBuilder: (context, index) => InkWell(
                          key: Key(index.toString()),
                          onTap: () {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) => YesNoModal.yesNoModal(
                                title: const Text(
                                  'Group Invite',
                                ),
                                content: Text(
                                  "Invite ${_filteredNonmembers[index]['username']} to ${widget.groupName}",
                                ),
                                actions: [
                                  CupertinoDialogAction(
                                    onPressed: () async {
                                      await _inviteToGroup(
                                          [_filteredNonmembers[index]['id']]);
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
                          child: _userProfile(
                            _filteredNonmembers[index]['username'],
                            _filteredNonmembers[index]['email'],
                          ),
                        ),
                      ),
                    )),
        ],
      ),
    );
  }

  Widget _userProfile(
    String username,
    String email,
  ) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffE2E2E2),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: MyColors.greenColor,
              ),
              width: 50,
              height: 50,
              child: Center(
                child: Text(
                  username[0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 3 / 100,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5 / 100,
                ),
                Text(
                  email,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
