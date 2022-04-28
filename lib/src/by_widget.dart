import 'dart:core';
import 'package:widgetbook/widgetbook.dart';

//Instance
WidgetbookWidget yolletWebWidget(
    {required String name, required List<WidgetbookUseCase> useCases}) {
  return WidgetbookWidget(name: '$name Widget', useCases: useCases);
}
