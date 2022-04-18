import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProgBar extends StatefulWidget {
  final Function onComplete;

  const ProgBar({Key? key, required this.onComplete}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ProgBarState();
}

class ProgBarState extends State<ProgBar> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation animation = Tween(begin: 0, end: 1).animate(_controller);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete();
      }
    });
    _controller.forward();
    _controller.reset();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      onVisibilityChanged: (visibilityInfo) {
        int visible = visibilityInfo.visibleFraction.toInt();
        if (visible == 1) {
          _controller.forward();
        } else if (mounted) {
          _controller.stop();
          _controller.reset();
        }
      },
      key: UniqueKey(),
      child: AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            return LinearProgressIndicator(
              value: _controller.value,
              color: Colors.green,
            );
          }),
    );
  }
}
