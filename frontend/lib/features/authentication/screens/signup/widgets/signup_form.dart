import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/common/widgets/texts/label_text.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/core/utils/validators/validation.dart';
import 'package:frontend/data/models/user_request.dart';
import 'package:frontend/features/authentication/providers/password_provider.dart';
import 'package:frontend/features/authentication/providers/signup_provider.dart';
import 'package:frontend/features/authentication/providers/timer_provider.dart';
import 'package:provider/provider.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _signupKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneNumberController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signupProvider = context.read<SignupProvider>();
    return Container(
      padding: EdgeInsets.all(KSizes.md),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(KSizes.borderRadiusLg),
        border: BoxBorder.all(color: KColors.grey),
      ),
      child: Form(
        key: _signupKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //full Name
            LabelText(title: "Full Name"),
            TextFormField(
              controller: _fullNameController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: "Enter your full name"),
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(fontSize: KSizes.fontSizeSm),
              validator: (value) =>
                  KValidator.validateEmptyText("Full Name", value),
            ),

            SizedBox(height: KSizes.defaultSpace),
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
            //phone number
            LabelText(title: "Phone Number"),
            TextFormField(
              controller: _phoneNumberController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(hintText: "Enter your phone number"),
              style: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(fontSize: KSizes.fontSizeSm),
              validator: (value) => KValidator.validatePhoneNumber(value),
            ),

            SizedBox(height: KSizes.defaultSpace),
            //password
            LabelText(title: "Password"),
            Consumer<PasswordProvider>(
              builder: (context, value, child) {
                return TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  obscureText: value.signupPasswordVisible,
                  decoration: InputDecoration(
                    hintText: "Create a password",

                    suffixIcon: IconButton(
                      color: KColors.black,

                      onPressed: () {
                        value.toggleSignupPasswordVisibility();
                      },
                      icon: Icon(
                        value.signupPasswordVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 19.sp,
                      ),
                    ),
                  ),

                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontSize: KSizes.fontSizeSm),
                  validator: (value) => KValidator.validatePassword(value),
                );
              },
            ),
            SizedBox(height: KSizes.defaultSpace),
            //confirm password
            LabelText(title: "Confirm Password"),
            Consumer<PasswordProvider>(
              builder: (context, value, child) {
                return TextFormField(
                  controller: _confirmPasswordController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  obscureText: value.signupConfirmPasswordVisible,
                  decoration: InputDecoration(
                    hintText: "Confirm your password",

                    suffixIcon: IconButton(
                      color: KColors.black,

                      onPressed: () {
                        value.toggleSignupConfirmPasswordVisibility();
                      },
                      icon: Icon(
                        value.signupConfirmPasswordVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 19.sp,
                      ),
                    ),
                  ),

                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge!.copyWith(fontSize: KSizes.fontSizeSm),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please confirm your password";
                    }
                    if (value != _passwordController.text) {
                      return "Password don't match";
                    }
                    return null;
                  },
                );
              },
            ),
            SizedBox(height: KSizes.defaultSpace),
            //login button
            CustomButton(
              text: "Create Account",
              onPressed: () async {
                if (_signupKey.currentState!.validate()) {
                  UserRequest model = UserRequest(
                    fullName: _fullNameController.text.trim(),
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                    phoneNumber: _phoneNumberController.text.trim(),
                  );
                  String data = userRequestToJson(model);
                  String email = model.email;
                  await signupProvider.register(context, data, email);
                  context.read<ResendTimerProvider>().startTimer();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
