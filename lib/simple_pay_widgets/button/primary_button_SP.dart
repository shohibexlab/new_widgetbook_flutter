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
  IconAlignment? iconAlignment;
  bool disable;
  bool loading;
  VoidCallback? onPressed;

  PrimaryButtonSP(
      {Key? key,
      this.height = 98,
      this.width = 656,
      this.text = '',
      this.loading = false,
      this.onPressed,
      this.icon,
      this.iconAlignment,
      this.disable = false,
      this.color = ThemeColors.orange500})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [Text(text!)];
    Color disableColor = ThemeColors.transparent;
    if (disable) {
      disableColor = ThemeColors.gray500.withOpacity(0.5);
    }
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
            primary: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          onPressed: getOnPressed,
          child: getChild(children),
        ),
      ),
    );
  }

  VoidCallback? getOnPressed() {
    if (disable) {
      return null;
    } else if (loading) {
      return null;
    } else {
      return onPressed;
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 23),
      child: SpacedRow(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: children,
      ),
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
        // width: 250,
        text: 'Primary button SP L',
        onPressed: () {},
      ),
      PrimaryButtonSP(
        height: 70,
        // width: 250,
        text: 'Primary button SP L',
        icon: HeroIcons.shoppingCart,
        iconAlignment: IconAlignment.right,
        onPressed: () {},
      ),
      PrimaryButtonSP(
        height: 70,
        // width: 250,
        text: 'Primary button SP L',
        icon: HeroIcons.shoppingCart,
        iconAlignment: IconAlignment.left,
        onPressed: () {},
      ),
      PrimaryButtonSP(
        height: 70,
        // width: 250,
        text: 'Primary button SP L disabled',
        iconAlignment: IconAlignment.left,
        disable: true,
        color: ThemeColors.orange500,
        onPressed: () {},
      ),
      PrimaryButtonSP(
        height: 70,
        loading: true,
      )
    ],
  );
}

enum IconAlignment {
  left,
  right,
}

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
      AnimationController(vsync: this, duration: Duration(seconds: 2))
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
      child: HeroIcon(
        HeroIcons.loading,
        color: ThemeColors.white,
      ),
    );
  }
}
