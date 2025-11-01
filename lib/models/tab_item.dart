import 'package:flutter/material.dart';

class TabItem {
  final String label;
  final String title;
  final Icon icon;
  final Widget widget;

  const TabItem({
    required this.label,
    required this.title,
    required this.icon,
    required this.widget
  });
}