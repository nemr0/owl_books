import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:toastification/toastification.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/service_locator/service_locator.dart';

@lazySingleton
class ErrorNotification{
  static ErrorNotification get instance => ServiceLocator.get<ErrorNotification>();
  bool _showing = false;
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