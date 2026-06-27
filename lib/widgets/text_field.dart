import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';


class CustomeTextField extends StatelessWidget {
  const CustomeTextField({
    super.key,
    required this.title,
    required this.controller,
    required this.focusNode,
  });
  final String title;
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      decoration: InputDecoration(
        hintText: title,
        prefixIcon: Icon(FluentIcons.search_32_filled),
        contentPadding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      ),
    );
  }
}
