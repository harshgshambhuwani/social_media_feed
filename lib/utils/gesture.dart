import 'package:flutter/material.dart';

class SwipeBackPage extends StatefulWidget {
  final Widget child;
  const SwipeBackPage({super.key, required this.child});

  @override
  SwipeBackPageState createState() => SwipeBackPageState();
}

class SwipeBackPageState extends State<SwipeBackPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1, 0),
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleSwipe(DragEndDetails details) {
    if (details.primaryVelocity! > 0 && _animationController.isDismissed) {
      Navigator.pop(context);
    } else if (details.primaryVelocity! < 0 && _animationController.isCompleted) {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: _handleSwipe,
      child: SlideTransition(
        position: _animation,
        child: widget.child,
      ),
    );
  }
}