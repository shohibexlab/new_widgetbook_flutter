import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:new_widgetbook_flutter/base/theme_color.dart';
import 'package:new_widgetbook_flutter/widgets/spaced_column.dart';
import 'package:new_widgetbook_flutter/widgets/spaced_row.dart';

class ButtonIconSp extends StatelessWidget {
  double? height;
  double? width;
  String text;
  String lowerText;
  double? price;
  final HeroIcons icon;
  ButtonIconType buttonIconType;

  ButtonIconSp({
    Key? key,
    this.text = '',
    this.width = 656,
    this.lowerText = '',
    this.price,
    this.height = 110,
    required this.icon,
    this.buttonIconType = ButtonIconType.ButtonIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double padding = buttonIconType == ButtonIconType.ButtonText ? 16 : 35;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(width!, height!),
        padding: EdgeInsets.symmetric(horizontal: padding, vertical: 25),
        primary: ThemeColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: getOnPressed,
      child: getChild(),
    );
  }

  getOnPressed() {
    return () {};
  }

  getChild() {
    if (buttonIconType == ButtonIconType.ButtonText) {
      return SpacedRow(
          horizontalSpace: 24,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: ThemeColors.amber300,
              ),
              child: HeroIcon(icon),
            ),
            SpacedColumn(children: [
              Text(text, style: const TextStyle(color: ThemeColors.black)),
              Text(
                lowerText,
                style: const TextStyle(color: ThemeColors.coolgray300),
              ),
            ]),
            const Expanded(child: const SizedBox()),
            Text(
              '${price?.toStringAsFixed(0)} ₸',
              style: const TextStyle(color: ThemeColors.coolgray500),
            )
          ]);
    } else {
      return SpacedRow(
          horizontalSpace: 34,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            HeroIcon(
              icon,
              color: ThemeColors.black,
            ),
            Text(text, style: const TextStyle(color: ThemeColors.black)),
          ]);
    }
  }
}

buttonIconSPStory() {
  return SpacedColumn(verticalSpace: 10, children: [
    ButtonIconSp(
      height: 70,
      icon: HeroIcons.bookOpen,
      text: 'Саша',
    ),
    ButtonIconSp(
      height: 72,
      icon: HeroIcons.cake,
      buttonIconType: ButtonIconType.ButtonText,
      text: 'Button',
      lowerText: '10 sales',
      price: 100000,
    )
  ]);
}

enum ButtonIconType { ButtonIcon, ButtonIcon2, ButtonText }
