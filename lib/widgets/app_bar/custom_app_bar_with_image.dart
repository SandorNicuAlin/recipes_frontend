import 'package:flutter/material.dart';

class CustomAppBarWithImage extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppBarWithImage({
    Key? key,
    required this.title,
    this.border,
    required this.image,
    this.actions,
  })  : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  final String title;
  final ShapeBorder? border;
  final ImageProvider<Object> image;
  final List<Widget>? actions;

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Hero(
          tag: 'group:$title',
          child: Image(
            fit: BoxFit.fill,
            image: image,
          ),
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
      shape: border ?? const Border(),
      actions: actions,
    );
  }
}
