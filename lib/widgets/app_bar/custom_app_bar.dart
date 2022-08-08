import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    required this.context,
    required this.title,
    this.actions,
    this.onActionTapCallback,
    this.border,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  final BuildContext context;
  final String title;
  final List<Widget>? actions;
  final Function? onActionTapCallback;
  final ShapeBorder? border;

  @override
  final Size preferredSize;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isLoading = false;

  void _onActionTap() async {
    setState(() {
      _isLoading = true;
    });

    await widget.onActionTapCallback!();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: _isLoading
          ? [
              const Padding(
                padding: EdgeInsets.only(right: 28.0),
                child: CupertinoActivityIndicator(
                  radius: 8,
                ),
              ),
            ]
          : [
              InkWell(
                onTap: _onActionTap,
                child: Row(
                  children: [...widget.actions ?? []],
                ),
              ),
            ],
      title: Text(
        widget.title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.white10,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      foregroundColor: Colors.black,
      shape: widget.border ?? const Border(),
    );
  }
}
