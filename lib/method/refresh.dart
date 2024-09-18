import 'package:flutter/material.dart';

refreshs(BuildContext context, Widget widget) {
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
    return widget;
  }));
}
