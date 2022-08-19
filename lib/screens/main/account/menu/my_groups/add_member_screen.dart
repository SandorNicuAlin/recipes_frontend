import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../../colors/my_colors.dart';
import '../../../../../widgets/input_fields/ios_search_field.dart';
import '../../../../../providers/user_provider.dart';
import '../../../../../widgets/loading/custom_circular_progress_indicator.dart';

class AddGroupMemberScreen extends StatefulWidget {
  const AddGroupMemberScreen({
    Key? key,
    required this.groupId,
  }) : super(key: key);

  final dynamic groupId;

  @override
  State<AddGroupMemberScreen> createState() => _AddGroupMemberScreenState();
}

class _AddGroupMemberScreenState extends State<AddGroupMemberScreen> {
  bool _firstTime = true;
  bool _isLoading = false;
  List _membersToAdd = [];
  List _allMembers = [];

  @override
  void didChangeDependencies() async {
    if (_firstTime) {
      setState(() {
        _isLoading = true;
      });
      _allMembers = await Provider.of<UserProvider>(context)
          .fetchAllThatDontBelongToGroup(widget.groupId);
      setState(() {
        _isLoading = false;
      });
      _firstTime = false;
    }
    super.didChangeDependencies();
  }

  void _onUserSelectedHandler(int userId) {
    setState(() {
      _allMembers.removeWhere((user) => user['id'] == userId);
      _membersToAdd.add(_allMembers.where((user) => user['id'] == userId));
    });
  }

  void _onUserUnselectedHandler(int userId) {
    setState(() {
      _membersToAdd.removeWhere((user) => user['id'] == userId);
      _allMembers.add(_membersToAdd.where((user) => user['id'] == userId));
    });
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
      body: _isLoading
          ? const Center(
              child: CustomCircularProgressIndicator(
                color: MyColors.greenColor,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: IosSearchField(
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Selected',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: _membersToAdd.isEmpty
                        ? []
                        : [
                            ..._membersToAdd
                                .map(
                                  (user) => InkWell(
                                    onTap: () {
                                      _onUserUnselectedHandler(user['id']);
                                    },
                                    child: userProfile(
                                      user['username'],
                                      user['email'],
                                    ),
                                  ),
                                )
                                .toList()
                          ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _allMembers.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        _onUserSelectedHandler(_allMembers[index]['id']);
                      },
                      child: userProfile(
                        _allMembers[index]['username'],
                        _allMembers[index]['email'],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget userProfile(
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
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 5 / 100,
          vertical: MediaQuery.of(context).size.height * 3 / 100,
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
                      fontWeight: FontWeight.bold, fontSize: 20),
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
