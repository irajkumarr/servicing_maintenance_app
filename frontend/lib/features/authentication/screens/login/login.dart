import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/common/widgets/texts/label_text.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/core/utils/divider/dotted_divider.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/features/authentication/providers/password_provider.dart';
import 'package:frontend/features/authentication/screens/login/widgets/login_footer.dart';
import 'package:frontend/features/authentication/screens/login/widgets/login_form.dart';
import 'package:frontend/features/authentication/screens/login/widgets/login_header.dart';
import 'package:provider/provider.dart';

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
