import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants/colors.dart';
import '../constants/image_strings.dart';
import '../constants/sizes.dart';

class KAlerts {
  static alertBox(
    BuildContext context,
    String title,
    String subTitle,
    VoidCallback? onPressed,
  ) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: SvgPicture.asset(KImages.logo2, width: 100, height: 100),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: KSizes.fontSizeLg + 4,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  subTitle,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: KColors.textGrey,
                    fontWeight: FontWeight.w500,
                    fontSize: KSizes.fontSizeSm,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: KColors.primary,
                      padding: EdgeInsets.zero,
                    ),
                    child: const Text('NO'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: KColors.error,
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: onPressed,
                    child: const Text('YES'),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
