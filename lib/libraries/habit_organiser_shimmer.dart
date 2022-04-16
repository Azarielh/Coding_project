import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HabitOrganizerShimmer extends StatelessWidget {
  final Widget child;
  final Duration? duration;

  const HabitOrganizerShimmer({Key? key, required this.child, this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        period: duration ?? const Duration(seconds: 3),
        baseColor: Colors.redAccent,
        enabled: false,
        highlightColor: Colors.yellow,
        child: child);
  }
}
