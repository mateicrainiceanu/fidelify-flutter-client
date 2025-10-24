import 'package:toastification/toastification.dart';
import 'package:flutter/material.dart';

enum ToastType {
  success,
  error,
  warning,
  info,
}

class Toast {
  static const _defaultAutoCloseDuration = const Duration(seconds: 5);
  static const _defaultToastType = ToastType.info;

  static void show(
      String message, {
        String? description,
        ToastType type = _defaultToastType,
        Duration autoCloseDuration = _defaultAutoCloseDuration,
      }) {
    toastification.show(
      title: Text(message),
      type: _mapToToastificationType(type),
      autoCloseDuration: autoCloseDuration,
    );
  }

  /// Private converter from our custom type → ToastificationType
  static ToastificationType _mapToToastificationType(ToastType type) {
    switch (type) {
      case ToastType.success:
        return ToastificationType.success;
      case ToastType.error:
        return ToastificationType.error;
      case ToastType.warning:
        return ToastificationType.warning;
      default:
        return ToastificationType.info;
    }
  }
}