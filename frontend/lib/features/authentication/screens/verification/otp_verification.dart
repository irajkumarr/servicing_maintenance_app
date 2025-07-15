import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:frontend/common/widgets/buttons/custom_button.dart';
import 'package:frontend/common/widgets/loaders/full_screen_overlay.dart';
import 'package:frontend/core/routes/routes_constant.dart';
import 'package:frontend/core/utils/constants/colors.dart';
import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:frontend/features/authentication/providers/signup_provider.dart';
import 'package:frontend/features/authentication/providers/timer_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.email});

  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final loginProvider = Provider.of<LoginProvider>(context);
    final timerProvider = Provider.of<ResendTimerProvider>(context);
    final provider = Provider.of<SignupProvider>(context);
    return FullScreenOverlay(
      isLoading: provider.isLoading,
      child: Scaffold(
        backgroundColor: KColors.white,
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              context.goNamed(RoutesConstant.login);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          backgroundColor: KColors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Verification Code",
                    style: Theme.of(
                      context,
                    ).textTheme.headlineSmall!.copyWith(fontSize: 30.sp),
                  ),
                  SizedBox(height: KSizes.xs),
                  Text(
                    "We have sent the verification\ncode to your email address",
                    style: Theme.of(
                      context,
                    ).textTheme.labelLarge!.copyWith(fontSize: 15.sp),
                  ),
                  SizedBox(height: KSizes.spaceBtwSections),
                  Pinput(
                    controller: _otpController,
                    length: 6,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter OTP';
                      } else if (value.length != 6) {
                        return 'OTP must be exactly 6 digits';
                      }

                      return null;
                    },
                    defaultPinTheme: PinTheme(
                      width: 50.w,
                      height: 50.h,
                      textStyle: TextStyle(
                        fontSize: 18.sp,
                        color: const Color.fromRGBO(30, 60, 87, 1),
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: BoxDecoration(
                        color: KColors.white,
                        border:
                            // Border.all(color: KColors.secondary),
                            Border.all(
                              color: const Color.fromRGBO(234, 239, 243, 1),
                            ),
                        borderRadius: BorderRadius.circular(
                          KSizes.borderRadiusMd,
                        ),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      width: 50.w,
                      height: 50.h,
                      textStyle: TextStyle(
                        fontSize: 18.sp,
                        color: KColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: BoxDecoration(
                        color: KColors.white,
                        border: Border.all(color: KColors.primary),
                        borderRadius: BorderRadius.circular(
                          KSizes.borderRadiusMd,
                        ),
                      ),
                    ),
                    submittedPinTheme: PinTheme(
                      width: 50.w,
                      height: 50.h,
                      textStyle: TextStyle(
                        fontSize: 18.sp,
                        color: const Color.fromRGBO(30, 60, 87, 1),
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: BoxDecoration(
                        color: KColors.white,
                        border: Border.all(color: KColors.accent),
                        borderRadius: BorderRadius.circular(
                          KSizes.borderRadiusMd,
                        ),
                      ),
                    ),
                    onCompleted: (value) {
                      // loginProvider.setOtp(value);
                      print(value);
                      // print(loginProvider.otp);
                    },
                  ),
                  SizedBox(height: KSizes.spaceBtwSections),
                  CustomButton(
                    text: "Verify",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await provider.verifyOtp(
                          context,
                          widget.email.trim(),
                          _otpController.text.trim(),
                        );
                      }
                    },
                  ),
                  SizedBox(height: KSizes.defaultSpace),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't get code?",
                        style: Theme.of(
                          context,
                        ).textTheme.labelLarge!.copyWith(fontSize: 15.sp),
                      ),
                      TextButton(
                        onPressed: timerProvider.canResendCode
                            ? () async {
                                // _passwordController.clear();
                                // _confirmPasswordController.clear();
                                // _otpController.clear();
                                // loginProvider.setOtp('');
                                // await loginProvider.resendCode(
                                //     context, widget.email);
                                // timerProvider
                                //     .startTimer(); // Restart timer after resending
                              }
                            : null,
                        child: Text(
                          timerProvider.canResendCode
                              ? "Resend Code"
                              : "Resend in ${timerProvider.formattedTime}s",
                          // style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          //   color: timerProvider.canResendCode
                          //       ? KColors.primary
                          //       : KColors.grey,
                          //   fontWeight: FontWeight.w600,
                          // ),
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(
                                fontSize: 15.sp,
                                color: timerProvider.canResendCode
                                    ? KColors.primary
                                    : KColors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
