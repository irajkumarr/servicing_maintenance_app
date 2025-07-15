import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/authentication/screens/signup/widgets/signup_footer.dart';
import 'package:frontend/features/authentication/screens/signup/widgets/signup_form.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create Account",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "Join us today",
              style: Theme.of(
                context,
              ).textTheme.labelLarge!.copyWith(fontSize: 15.sp),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: KSizes.md,
              vertical: KSizes.spaceBtwSections,
            ),
            child: Column(
              children: [
                //sign up form
                SignupForm(),
                SizedBox(height: KSizes.defaultSpace),
                //signup footer
                SignupFooter(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
