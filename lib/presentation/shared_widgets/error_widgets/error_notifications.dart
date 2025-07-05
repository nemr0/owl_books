import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:toastification/toastification.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/service_locator/service_locator.dart';

/// A singleton service for displaying error toast notifications in the app.
///
/// Provides methods to show server and network error toasts using the
/// [toastification] package. Ensures only one toast is shown at a time.
@lazySingleton
class ErrorNotification{
  /// Returns the singleton instance of [ErrorNotification].
  static ErrorNotification get instance => ServiceLocator.get<ErrorNotification>();

  /// Tracks whether a toast is currently being shown.
  bool _showing = false;

  /// Shows a toast notification for server errors.
  ///
  /// Displays a toast with a "Server Error!" message and prevents
  /// multiple toasts from stacking.
  showServerErrorToast(BuildContext context) async {
    if(_showing) return;
    _showing = true;
    final toast = toastification.show(context: context,
        title: const Text('Server Error!'),
        description: const Text('Could not connect fetch data from the server'),
        icon: const Icon(CupertinoIcons.at_circle),
        type: ToastificationType.error,
        showIcon: true,
        style: ToastificationStyle.flatColored,
        backgroundColor: context.colorScheme.secondary,
        borderSide: BorderSide(color: context.colorScheme.onSecondary)
    );
    await Future.delayed(const Duration(seconds: 4));
    toastification.dismiss(toast);
    _showing = false;
  }

  /// Shows a toast notification for network errors.
  ///
  /// Displays a toast with a "Network Error!" message and prevents
  /// multiple toasts from stacking.
  showNetworkErrorToast(BuildContext context) async {
    if(_showing) return;
    _showing = true;
    final toast = toastification.show(context: context,
        title: const Text('Network Error!'),
        description: const Text('Could not connect to the network'),
        icon: const Icon(CupertinoIcons.wifi_exclamationmark),
        type: ToastificationType.error,
        showIcon: true,
        style: ToastificationStyle.flatColored,
        backgroundColor: context.colorScheme.secondary,
        borderSide: BorderSide(color: context.colorScheme.onSecondary)
    );
    await Future.delayed(const Duration(seconds: 4));
    toastification.dismiss(toast);
    _showing = false;
  }
}