import 'package:flutter/material.dart';

class Nav {
  // Make push generic
  static Future<T?> push<T>(BuildContext context, Widget widget) {
    return Navigator.push<T>(
      context,
      MaterialPageRoute(builder: (_) => widget),
    );
  }

  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }
}
