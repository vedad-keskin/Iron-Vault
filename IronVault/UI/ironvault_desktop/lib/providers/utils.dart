import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

String formatNumber(dynamic) {
  var f = NumberFormat('###,00');
  if (dynamic == null) {
    return "";
  }
  return f.format(dynamic);
}


Image imageFromString(String input) {
  return Image.memory(base64Decode(input));
}