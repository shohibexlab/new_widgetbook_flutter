import 'dart:core';
import 'package:new_widgetbook_flutter/simple_pay_widgets/button/primary_button_SP.dart';
import 'package:new_widgetbook_flutter/src/by_usecase.dart';
import 'package:new_widgetbook_flutter/src/by_widget.dart';
import 'package:widgetbook/widgetbook.dart';

WidgetbookCategory simplePayCategory() {
  return WidgetbookCategory(name: 'Simple Pay Category', widgets: [
    yolletWebWidget(name: 'Button SP', useCases: [
      yolletWebUsecase(
          name: 'Primary button SP', widget: primaryButtonSPStory())
    ]),
  ]);
}
