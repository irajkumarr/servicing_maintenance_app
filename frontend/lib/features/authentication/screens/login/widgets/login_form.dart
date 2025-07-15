import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/common/widgets/texts/label_text.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/image_strings.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/device/device_utility.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/features/authentication/providers/password_provider.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _loginKey = GlobalKey<FormState>();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(KSizes.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(KSizes.borderRadiusLg),
        border: BoxBorder.all(color: KColors.grey),
      ),
      child: Form(
        key: _loginKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //email
            LabelText(title: "Email"),
            TextFormField(
              controller: _emailController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(hintText: "Enter your email"),
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(fontSize: KSizes.fontSizeSm),
              validator: (value) => KValidator.validateEmail(value),
            ),
            SizedBox(height: KSizes.defaultSpace),
            //password
            LabelText(title: "Password"),
            Consumer<PasswordProvider>(
              builder: (context, value, child) {
                return TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: value.loginPasswordVisible,
                  decoration: InputDecoration(
                    hintText: "Enter your password",

                    suffixIcon: IconButton(
                      color: KColors.black,

                      onPressed: () {
                        value.toggleLoginPasswordVisibility();
                      },
                      icon: Icon(
                        value.loginPasswordVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 19.sp,
                      ),
                    ),
                  ),

                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontSize: KSizes.fontSizeSm),
                  validator: (value) =>
                      KValidator.validateEmptyText("Password", value),
                );
              },
            ),
            SizedBox(height: KSizes.defaultSpace),
            //login button
            CustomButton(
              text: "Sign In",
              onPressed: () {
                if (_loginKey.currentState!.validate()) {
                  print(_emailController.text.trim());
                  print(_passwordController.text.trim());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
