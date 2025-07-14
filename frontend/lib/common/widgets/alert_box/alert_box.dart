import 'package:frontend/core/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/device/device_utility.dart';

class CustomAlertBox {
  //login alert
  static Future<void> loginAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return SizedBox(
          width: KDeviceUtils.getScreenWidth(context),
          child: AlertDialog(
            backgroundColor: KColors.white,
            insetPadding: EdgeInsets.symmetric(horizontal: 30.w),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(KSizes.xs),
            ),
            title: Text(
              "Login Alert",
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.copyWith(fontSize: 18.sp),
              textAlign: TextAlign.left,
            ),
            // content: const Text("You need to login to add items to the cart."),
            content: Text(
              "Please log in to add items to your cart and continue shopping.",
              style: Theme.of(context).textTheme.titleSmall,
            ),

            actions: <Widget>[
              TextButton(
                child: Text(
                  "CANCEL",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: KColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  "LOGIN",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: KColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {
                  // Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("/login");
                },
              ),
            ],
          ),
        );
      },
    );
  }

  //alert close app

  // static Future<bool> alertCloseApp(BuildContext context) async {
  //   return await showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return PopScope(
  //         canPop: false,
  //         child: SizedBox(
  //           // width: 400.w,
  //           width: KDeviceUtils.getScreenWidth(context),
  //           child: AlertDialog(
  //             insetPadding: EdgeInsets.symmetric(horizontal: 30.w),
  //             backgroundColor: KColors.white,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(KSizes.xs),
  //             ),
  //             // title: Text(
  //             //   'Exit?',
  //             //   style: Theme.of(context)
  //             //       .textTheme
  //             //       .headlineSmall!
  //             //       .copyWith(fontSize: 18.sp),
  //             //   textAlign: TextAlign.left,
  //             // ),
  //             content: SizedBox(
  //                 // width: 400.w,
  //                 width: KDeviceUtils.getScreenWidth(context),
  //                 child: Text(
  //                   'Do you want to exit?',
  //                   style: Theme.of(context).textTheme.titleSmall,
  //                   textAlign: TextAlign.center,
  //                 )),
  //             actions: [
  //               Expanded(
  //                 child: TextButton(
  //                   style: ElevatedButton.styleFrom(
  //                     backgroundColor: KColors.secondaryBackground,
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(KSizes.xs),
  //                     ),
  //                   ),
  //                   child: Text(
  //                     "CANCEL",
  //                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
  //                           color: KColors.primary,
  //                           fontWeight: FontWeight.w500,
  //                         ),
  //                   ),
  //                   onPressed: () {
  //                     Navigator.of(context).pop(false);
  //                   },
  //                 ),
  //               ),
  //               Expanded(
  //                 child: TextButton(
  //                   style: ElevatedButton.styleFrom(
  //                     shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(KSizes.xs),
  //                     ),
  //                     backgroundColor: KColors.primary,
  //                   ),
  //                   child: Text(
  //                     "YES",
  //                     style: Theme.of(context).textTheme.bodyMedium!.copyWith(
  //                           color: KColors.white,
  //                           fontWeight: FontWeight.w500,
  //                         ),
  //                   ),
  //                   onPressed: () {
  //                     // Navigator.of(context).pop();

  //                     SystemNavigator.pop();
  //                   },
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  static Future<bool> alertCloseApp(BuildContext context) async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return PopScope(
          // canPop: false,
          child: SizedBox(
            width: KDeviceUtils.getScreenWidth(context),
            child: Dialog(
              insetPadding: EdgeInsets.symmetric(horizontal: KSizes.md),
              backgroundColor: KColors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(KSizes.sm),
              ),
              child: Container(
                width: KDeviceUtils.getScreenWidth(context),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 25,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Exit?',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: KColors.black,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: KSizes.xs),
                    Text(
                      "Are you sure you want to close the app?",
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall!.copyWith(color: KColors.darkGrey),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: KSizes.xs),
                    Divider(color: KColors.grey),
                    SizedBox(height: KSizes.sm),
                    Row(
                      spacing: KSizes.md,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: KSizes.md - 2,
                              ),
                              backgroundColor: KColors.secondaryBackground,
                            ),
                            child: Text(
                              "No",
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(
                                    color: KColors.darkerGrey,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: KSizes.md - 2,
                              ),
                              backgroundColor: KColors.primary,
                            ),
                            child: Text(
                              "Yes",
                              style: Theme.of(context).textTheme.titleSmall!
                                  .copyWith(
                                    color: KColors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            onPressed: () {
                              // Navigator.of(context).pop();

                              SystemNavigator.pop();
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = SizedBox(
      width: 110,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          side: BorderSide.none,
          backgroundColor: Colors.transparent,
          foregroundColor: KColors.black,
        ),
        onPressed: () => Navigator.pop(context),
        child: const Text("Cancel"),
      ),
    );
    Widget confirmButton = SizedBox(
      width: 110,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: KColors.primary,
          foregroundColor: Colors.white,
        ),
        onPressed: () {},
        child: const Text("Confirm"),
      ),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      title: const Center(child: Text("Logout")),
      content: const SizedBox(
        width: 400,
        child: Text("Are you sure you want to logout?"),
      ),
      actions: [cancelButton, confirmButton],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<void> showAlert(
    BuildContext context,
    String subTitle,
    VoidCallback onPressed,
  ) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: 400.w,
          child: AlertDialog(
            backgroundColor: KColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(KSizes.xs),
            ),
            // title: Text(title),
            content: SizedBox(
              width: 400.w,
              child: Text(
                subTitle,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  "CANCEL",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: KColors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  "OK",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(color: KColors.primary),
                ),
                onPressed: () {
                  // Navigator.of(context).pop();

                  onPressed();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // static Future<void> showUpdatePasswordAlert(
  //   BuildContext context,
  // ) {
  //   final TextEditingController oldPasswordController = TextEditingController();
  //   final TextEditingController newPasswordController = TextEditingController();
  //   final TextEditingController confirmPasswordController =
  //       TextEditingController();
  //   final profileProvider =
  //       Provider.of<ProfileProvider>(context, listen: false);
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SizedBox(
  //           width: 400.w,
  //           child: Dialog(
  //             backgroundColor: KColors.white,
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(KSizes.xs),
  //             ),
  //             child: Stack(
  //               children: [
  //                 Padding(
  //                   padding: const EdgeInsets.all(20),
  //                   child: Column(
  //                     mainAxisSize: MainAxisSize.min,
  //                     children: [
  //                       const SizedBox(height: 10), // Space for the icon
  //                       const Text(
  //                         'Update Password',
  //                         style: TextStyle(
  //                           fontWeight: FontWeight.bold,
  //                           fontSize: 18,
  //                         ),
  //                       ),
  //                       const SizedBox(height: 20),
  //                       Form(
  //                         child: Column(
  //                           children: [
  //                             Consumer<PasswordProvider>(
  //                                 builder: (context, value, child) {
  //                               return TextFormField(
  //                                 controller: oldPasswordController,
  //                                 textInputAction: TextInputAction.next,
  //                                 style: Theme.of(context)
  //                                     .textTheme
  //                                     .bodyLarge!
  //                                     .copyWith(fontSize: KSizes.fontSizeSm),
  //                                 validator: (value) =>
  //                                     KValidator.validateEmptyText(
  //                                         "Old Password", value),
  //                                 obscureText: value.oldPasswordVisible,
  //                                 decoration: InputDecoration(
  //                                   labelText: "Old Password",
  //                                   suffixIcon: IconButton(
  //                                     onPressed: () {
  //                                       value.toggleOldPasswordVisibility();
  //                                     },
  //                                     icon: Icon(value.oldPasswordVisible
  //                                         ? Iconsax.eye_slash
  //                                         : Iconsax.eye),
  //                                   ),
  //                                 ),
  //                               );
  //                             }),
  //                             SizedBox(height: KSizes.spaceBtwSections),
  //                             //new password
  //                             Consumer<PasswordProvider>(
  //                                 builder: (context, value, child) {
  //                               return TextFormField(
  //                                 controller: newPasswordController,
  //                                 textInputAction: TextInputAction.next,
  //                                 style: Theme.of(context)
  //                                     .textTheme
  //                                     .bodyLarge!
  //                                     .copyWith(fontSize: KSizes.fontSizeSm),
  //                                 validator: (value) {
  //                                   if (value == null || value.isEmpty) {
  //                                     return 'Please enter your new password';
  //                                   }
  //                                   if (value == newPasswordController.text) {
  //                                     return 'New password cannot be the same as old password';
  //                                   }
  //                                   return null;
  //                                 },
  //                                 obscureText: value.newPasswordVisible,
  //                                 decoration: InputDecoration(
  //                                   labelText: "New Password",
  //                                   suffixIcon: IconButton(
  //                                       onPressed: () {
  //                                         value.toggleNewPasswordVisibility();
  //                                       },
  //                                       icon: Icon(value.newPasswordVisible
  //                                           ? Iconsax.eye_slash
  //                                           : Iconsax.eye)),
  //                                 ),
  //                               );
  //                             }),
  //                             SizedBox(height: KSizes.spaceBtwSections),
  //                             //confirm new password
  //                             Consumer<PasswordProvider>(
  //                                 builder: (context, value, child) {
  //                               return TextFormField(
  //                                 controller: confirmPasswordController,
  //                                 textInputAction: TextInputAction.done,
  //                                 style: Theme.of(context)
  //                                     .textTheme
  //                                     .bodyLarge!
  //                                     .copyWith(fontSize: KSizes.fontSizeSm),
  //                                 validator: (value) {
  //                                   if (value == null || value.isEmpty) {
  //                                     return 'Please confirm your new password';
  //                                   }
  //                                   if (value != newPasswordController.text) {
  //                                     return 'Passwords do not match';
  //                                   }
  //                                   return null;
  //                                 },
  //                                 obscureText: value.confirmPasswordVisible,
  //                                 decoration: InputDecoration(
  //                                   labelText: "Confirm Password",
  //                                   suffixIcon: IconButton(
  //                                       onPressed: () {
  //                                         value
  //                                             .toggleConfirmPasswordVisibility();
  //                                       },
  //                                       icon: Icon(value.confirmPasswordVisible
  //                                           ? Iconsax.eye_slash
  //                                           : Iconsax.eye)),
  //                                 ),
  //                               );
  //                             }),
  //                             const SizedBox(height: 20),
  //                             ElevatedButton(
  //                               onPressed: () async {
  //                                 await profileProvider.changePassword(
  //                                     context,
  //                                     oldPasswordController.text,
  //                                     newPasswordController.text);
  //                               },
  //                               style: ElevatedButton.styleFrom(
  //                                 shape: RoundedRectangleBorder(
  //                                   borderRadius: BorderRadius.circular(10),
  //                                 ),
  //                                 minimumSize: const Size(double.infinity, 50),
  //                               ),
  //                               child: profileProvider.isLoading
  //                                   ? KIndicator.circularIndicator()
  //                                   : const Text('Update'),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //                 // Cross (close) icon
  //                 Positioned(
  //                   right: 10,
  //                   top: 10,
  //                   child: GestureDetector(
  //                     onTap: () {
  //                       Navigator.of(context).pop(); // Close the dialog
  //                     },
  //                     child: const Icon(
  //                       Icons.close,
  //                       color: Colors.grey,
  //                       size: 24,
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ));
  //     },
  //   );
  // }
}
