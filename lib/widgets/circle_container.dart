import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class CircleContainer extends StatelessWidget {
  const CircleContainer({super.key, this.child, this.h, this.w, this.color});
  final Widget? child;
  final double? h;
  final double? w;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: w ?? 50.w,
      height: h ?? 50.h,
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? (color ?? theme.cardColor)
            : const Color.fromARGB(255, 21, 21, 22),
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: child,
    );
  }
}
