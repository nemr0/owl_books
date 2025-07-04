import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'service_locator.config.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies() => getIt.init();

class ServiceLocator {
  /// Initializes the service locator with the provided environment and filter.
  /// This method is typically called at the start of the application.
  static void setup() => configureDependencies();

  /// Gets a singleton instance of type [T] with an optional instance name.
  static T get<T extends Object>({String? instanceName}) =>
      getIt.get(type: T, instanceName: instanceName);
}
