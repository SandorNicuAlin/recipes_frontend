import 'package:flutter/material.dart';

class TextPlaceholder extends StatefulWidget {
  const TextPlaceholder({
    Key? key,
    this.height = 20,
    this.width = 200,
  }) : super(key: key);
  final double height;
  final double width;

  @override
  State<TextPlaceholder> createState() => _TextPlaceholderState();
}

class _TextPlaceholderState extends State<TextPlaceholder>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation? gradientPosition;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(parent: _controller!, curve: Curves.linear),
    )..addListener(() {
        setState(() {});
      });
    _controller!.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(gradientPosition!.value, 0),
          end: const Alignment(-1, 0),
          colors: const [Colors.black12, Colors.black26, Colors.black12],
        ),
      ),
    );
  }
}
