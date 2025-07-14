import 'package:flutter/material.dart';


import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/helpers/helper_functions.dart';
import '../custom_shapes/container/circular_container.dart';

class ChoiceChipWidget extends StatelessWidget {
  const ChoiceChipWidget(
      {super.key, required this.text, required this.selected, this.onSelected});
  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = KHelperFunctions.getColor(text) != null;
    return ChoiceChip(
      label: isColor ? const SizedBox() : Text(text),
      selected: selected,
      onSelected: onSelected,
      labelStyle: TextStyle(color: selected ? KColors.white : null),
      avatar: isColor
          ? CircularContainer(
              color: KHelperFunctions.getColor(text)!,
              width: 50,
              height: 50,
            )
          : null,
      shape: isColor ? const CircleBorder() : null,
      labelPadding: isColor ? const EdgeInsets.all(0) : null,
      padding: isColor ? const EdgeInsets.all(0) : null,
      backgroundColor: isColor ? KHelperFunctions.getColor(text)! : null,
    );
  }
}
