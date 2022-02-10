import 'package:dinner_assistant_flutter/core/service/database_service.dart';
import 'package:get_it/get_it.dart';

import 'core/utils/utils.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => Utils());
  locator.registerLazySingleton(() => Database());
}
