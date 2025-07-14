import 'package:flutter/material.dart';

import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/helpers/helper_functions.dart';


class FormDivider extends StatelessWidget {
  final String text;
  const FormDivider({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final dark = KHelperFunctions.isDarkMode(context);
    return Row(
      children: [
        Flexible(
          child: Divider(
            color: dark ? KColors.darkGrey : KColors.grey,
            thickness: 0.5,
            indent: 60,
            endIndent: 5,
          ),
        ),
        Text(
         "text",
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Flexible(
          child: Divider(
            color: dark ? KColors.darkGrey : KColors.grey,
            thickness: 0.5,
            indent: 5,
            endIndent: 60,
          ),
        ),
      ],
    );
  }
}
