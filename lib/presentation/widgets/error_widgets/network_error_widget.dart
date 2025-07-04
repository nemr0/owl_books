import 'package:flutter/cupertino.dart';

import '../../../core/extensions/context_extension.dart';

class NetworkErrorWidget extends StatelessWidget {
  const NetworkErrorWidget({super.key, required this.onRefresh});
  final VoidCallback onRefresh;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: [
        const Icon(CupertinoIcons.wifi_exclamationmark,size: 40,),
        const SizedBox(height: 10),
        Text(
          'Network Error!',
          style: context.textTheme.headlineMedium?.copyWith(
            color: context.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          'Could not connect to the network',
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 10),
        CupertinoButton.filled(onPressed: onRefresh, child: const Text('Refresh')),
      ],
    );
  }
}
