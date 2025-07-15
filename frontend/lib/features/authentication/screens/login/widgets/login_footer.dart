import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/texts/label_text.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/divider/dotted_divider.dart';
import 'package:go_router/go_router.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: KSizes.sm,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(KSizes.borderRadiusMd),
          child: Padding(
            padding: EdgeInsets.all(KSizes.xs),
            child: LabelText(title: "Forgot Password?"),
          ),
        ),
        DottedDivider(),
        SizedBox(height: 2.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: KSizes.xs,
          children: [
            Text(
              "Don't have an account?",
              style: Theme.of(
                context,
              ).textTheme.labelLarge!.copyWith(fontSize: 15.sp),
            ),
            //sign up button
            InkWell(
              onTap: () {
                context.pushNamed(RoutesConstant.signup);
              },

              borderRadius: BorderRadius.circular(KSizes.borderRadiusMd),
              child: Padding(
                padding: EdgeInsets.all(KSizes.xs),
                child: Text(
                  "Sign Up",
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
