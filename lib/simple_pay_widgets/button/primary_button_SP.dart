import 'dart:math';

import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:new_widgetbook_flutter/base/theme_color.dart';
import 'package:new_widgetbook_flutter/widgets/spaced_column.dart';
import 'package:new_widgetbook_flutter/widgets/spaced_row.dart';

class PrimaryButtonSP extends StatelessWidget {
  double? height;
  double? width;
  Color? color;
  HeroIcons? icon;
  String? text;
  double? price;
  IconAlignment? iconAlignment;
  PrimaryButtonType? buttonType;
  bool loading;
  VoidCallback? onPressed;

  PrimaryButtonSP(
      {Key? key,
      this.height = 98,
      this.width = 656,
      this.text = '',
      this.price,
      this.loading = false,
      this.onPressed,
      this.buttonType = PrimaryButtonType.Main,
      this.icon,
      this.iconAlignment,
      this.color = ThemeColors.orange500})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    OutlinedBorder shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    );
    Color borderColor = color!;
    List<Widget> children = [
      Text(
        text!,
        style: TextStyle(color: getTextColor()),
      ),
      if (price != null)
        Text(
          '  ${price!.toStringAsFixed(0)} ₸',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: getTextColor(),
          ),
        )
    ];
    Color disableColor = ThemeColors.transparent;
    if (buttonType == PrimaryButtonType.Disabled) {
      disableColor = ThemeColors.gray500.withOpacity(0.5);
    }
    if (buttonType == PrimaryButtonType.Ghost) {
      color = ThemeColors.transparent;
    }
    Widget primary() {
      if (buttonType == PrimaryButtonType.Ghost) {
        return OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: shape,
              primary: ThemeColors.coolgray300,
              fixedSize: Size(width!, height!),
            ),
            onPressed: getOnPressed,
            child: getChild(children));
      } else {
        return ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(
              disableColor,
              BlendMode.multiply,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(width!, height!),
                padding: const EdgeInsets.symmetric(vertical: 23),
                primary: color,
                shape: shape,
              ),
              onPressed: getOnPressed,
              child: getChild(children),
            ),
          ),
        );
      }
    }

    return primary();
  }

  VoidCallback? getOnPressed() {
    if (buttonType == PrimaryButtonType.Disabled) {
      return null;
    } else if (loading) {
      return null;
    } else {
      return onPressed;
    }
  }

  Color? getTextColor() {
    if (buttonType == PrimaryButtonType.Main) {
      return ThemeColors.white;
    } else if (buttonType == PrimaryButtonType.Secondary) {
      return ThemeColors.orange500;
    } else if (buttonType == PrimaryButtonType.Ghost) {
      return ThemeColors.coolgray500;
    } else {
      return ThemeColors.white;
    }
  }

  Widget getChild(List<Widget> children) {
    if (icon != null) {
      if (iconAlignment == IconAlignment.right) {
        children.insert(
          children.length,
          HeroIcon(icon!),
        );
      } else {
        children.insert(0, HeroIcon(icon!));
      }
    }
    if (loading) {
      children.add(LoadingWidget());
    }
    return SpacedRow(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Widget getIcon() {
    return HeroIcon(icon!);
  }
}

Widget primaryButtonSPStory() {
  return SpacedColumn(
    verticalSpace: 10,
    children: [
      PrimaryButtonSP(
        height: 70,
        text: 'Primary button SP L',
        onPressed: () {},
      ),
      PrimaryButtonSP(
        height: 70,
        text: 'Primary button SP L',
        icon: HeroIcons.shoppingCart,
        iconAlignment: IconAlignment.right,
        onPressed: () {},
      ),
      PrimaryButtonSP(
        height: 70,
        text: 'Primary button SP L',
        icon: HeroIcons.shoppingCart,
        iconAlignment: IconAlignment.left,
        onPressed: () {},
      ),
      PrimaryButtonSP(
        height: 70,
        text: 'Primary button SP L disabled',
        iconAlignment: IconAlignment.left,
        color: ThemeColors.orange500,
        buttonType: PrimaryButtonType.Disabled,
        onPressed: () {},
      ),
      PrimaryButtonSP(
        height: 70,
        loading: true,
      ),
      PrimaryButtonSP(
        height: 70,
        text: 'Secondary button',
        color: ThemeColors.orange200,
        price: 10000,
        buttonType: PrimaryButtonType.Secondary,
      ),
      PrimaryButtonSP(
        height: 70,
        text: 'Ghost button SP',
        buttonType: PrimaryButtonType.Ghost,
      ),
    ],
  );
}

enum IconAlignment {
  left,
  right,
}
enum PrimaryButtonType { Main, Secondary, Ghost, Disabled, Link, Extra, Sale }

class LoadingWidget extends StatefulWidget {
  Color iconColor;
  double iconSize;

  LoadingWidget({this.iconColor = ThemeColors.white, this.iconSize = 56});

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform.rotate(
        angle: _controller.value * 2 * pi,
        child: child,
      ),
      child: const HeroIcon(
        HeroIcons.loading,
        color: ThemeColors.white,
      ),
    );
  }
}
