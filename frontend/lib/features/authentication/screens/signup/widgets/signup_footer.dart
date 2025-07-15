import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:go_router/go_router.dart';

class SignupFooter extends StatelessWidget {
  const SignupFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: KSizes.xs,
      children: [
        Text(
          "Already have an account?",
          style: Theme.of(
            context,
          ).textTheme.labelLarge!.copyWith(fontSize: 15.sp),
        ),
        //sign in button
        InkWell(
          onTap: () {
            context.goNamed(RoutesConstant.login);
          },

          borderRadius: BorderRadius.circular(KSizes.borderRadiusMd),
          child: Padding(
            padding: EdgeInsets.all(KSizes.xs),
            child: Text(
              "Sign In",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
