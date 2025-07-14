// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:frontend/core/routes/routes_constant.dart';
// import 'package:go_router/go_router.dart';

// import 'package:lottie/lottie.dart';

// import '../../../core/utils/constants/colors.dart';
// import '../../../core/utils/constants/image_strings.dart';
// import '../../../core/utils/constants/sizes.dart';
// import '../../../core/utils/helpers/helper_functions.dart';

// class SuccessScreen extends StatelessWidget {
//   // final String imagePath;
//   // final String title;
//   // final String subTitle;
//   // final VoidCallback onPressed;
//   const SuccessScreen({
//     super.key,
//     // required this.imagePath,
//     // required this.title,
//     // required this.subTitle,
//     // required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: false,
//       child: Scaffold(
//         body: Padding(
//           // padding: KSpacingStyle.paddingWithAppbar() * 2,
//           padding: EdgeInsets.symmetric(
//               horizontal: KSizes.md, vertical: KSizes.spaceBtwSections),
//           child: Column(
//             children: [
//               Lottie.asset(KImages.successfullyRegisterAnimation,
//                   width: KHelperFunctions.screenWidth(context) * 0.6),
//               SizedBox(
//                 height: KSizes.spaceBtwItems,
//               ),
//               Text(
//                 "Payment success",
//                 style: Theme.of(context).textTheme.bodyLarge,
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(
//                 height: KSizes.spaceBtwItems,
//               ),
//               Text(
//                 "Your order was placed successfully.",
//                 style: Theme.of(context).textTheme.titleSmall,
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(
//                 height: KSizes.spaceBtwSections * 3,
//               ),
//               SizedBox(
//                 width: double.infinity - 20.w,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: KColors.primary,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(KSizes.xs),
//                       )),
//                   onPressed: () {
//                     // context.replaceNamed(RoutesConstant.navigationMenu);

//                     // context.read<NavigationProvider>().onTap(4);
//                   },
//                   child: Text(
//                     "See your orders",
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyMedium!
//                         .copyWith(color: KColors.white),
//                   ),
//                 ),
//               ),
//               SizedBox(height: KSizes.spaceBtwItems),
//               SizedBox(
//                 width: double.infinity - 20.w,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                       backgroundColor: KColors.darkGrey,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(KSizes.xs),
//                       )),
//                   onPressed: () {
//                     // context.read<NavigationProvider>().onTap(0);
//                     // context.replaceNamed(RoutesConstant.navigationMenu);
//                   },
//                   child: Text(
//                     "Back to home",
//                     style: Theme.of(context)
//                         .textTheme
//                         .bodyMedium!
//                         .copyWith(color: KColors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
