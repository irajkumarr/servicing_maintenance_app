import 'package:flutter/material.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/authentication/screens/login/widgets/login_footer.dart';
import 'package:frontend/features/authentication/screens/login/widgets/login_form.dart';
import 'package:frontend/features/authentication/screens/login/widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: KSizes.md,
            vertical: KSizes.spaceBtwSections * 4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //logo and title
              LoginHeader(),
              SizedBox(height: KSizes.defaultSpace),
              //login form
              LoginForm(),

              SizedBox(height: KSizes.defaultSpace),
              //login footer
              LoginFooter(),
            ],
          ),
        ),
      ),
    );
  }
}
