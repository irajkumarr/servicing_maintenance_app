import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';
import '../../common/widgets/alert_box/alert_box.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';
import 'connectivity_provider.dart';

class ConnectivityChecker extends StatelessWidget {
  final Widget child;

  const ConnectivityChecker({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
      builder: (context, connectivityProvider, _) {
        if (connectivityProvider.isChecking) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (connectivityProvider.connectivityResult.contains(
          ConnectivityResult.none,
        )
        //  ==
        //     [ConnectivityResult.none]
        ) {
          // ignore: deprecated_member_use

          // ignore: deprecated_member_use
          return WillPopScope(
            onWillPop: () async {
              return await CustomAlertBox.alertCloseApp(context);
            },
            child: Scaffold(
              backgroundColor: KColors.white,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200.h,
                      width: 200.w,
                      child: Icon(Icons.error),
                    ),
                    const SizedBox(height: KSizes.md),
                    Text(
                      'OOps',
                      style: TextStyle(fontSize: 30.sp, color: Colors.black),
                    ),
                    SizedBox(height: KSizes.sm),
                    Text(
                      'Check your internet connection...',
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: KSizes.md),
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () async {
                        try {
                          await connectivityProvider.checkConnectivity();
                        } catch (e) {}
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: KSizes.md,
                          vertical: KSizes.sm,
                        ),
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Text(
                          "Try Again",
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(color: KColors.primary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return child;
        }
      },
    );
  }
}
