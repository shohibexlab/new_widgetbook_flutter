import 'package:flutter/material.dart';
import 'package:new_widgetbook_flutter/src/by_category.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@WidgetbookTheme.dark()
ThemeData darkTheme() => ThemeData.dark();

ThemeData lightTheme() => ThemeData.light();

class WidgetbookSP extends StatelessWidget {
  const WidgetbookSP({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Widgetbook(
      appInfo: AppInfo(
        name: 'Widget Book Yollet',
      ),
      lightTheme: lightTheme(),
      darkTheme: darkTheme(),
      devices: const [
        Apple.iPhoneX,
        Samsung.s10,
        Samsung.s21ultra,
        Device(
          name: 'Desktop 1080x720',
          resolution: Resolution(
            nativeSize: DeviceSize(
              height: 720.0,
              width: 1080.0,
            ),
            scaleFactor: 1.0,
          ),
          type: DeviceType.desktop,
        ),
      ],
      categories: [
        simplePayCategory()
      ],
    );
  }
}
