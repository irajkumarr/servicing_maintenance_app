import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:go_router/go_router.dart';

class Appbar extends StatelessWidget {
  const Appbar({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: KColors.primary,

      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          context.pop();
        },
        tooltip: "Back",
        icon: Icon(Icons.arrow_back_rounded, color: KColors.white),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontSize: 23.sp,
          color: KColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
