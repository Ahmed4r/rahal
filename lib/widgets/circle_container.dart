import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class CircleContainer extends StatelessWidget {
  const CircleContainer({super.key, this.child, this.h, this.w});
  final Widget? child;
  final double? h;
  final double? w;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: w ?? 50.w,
      height: h ?? 50.h,
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: child,
    );
  }
}
