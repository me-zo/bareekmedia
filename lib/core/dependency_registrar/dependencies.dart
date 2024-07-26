import 'package:bareekmedia/app/settings_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:bareekmedia/app/configuration.dart';
import 'package:bareekmedia/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:bareekmedia/core/cache/session_cache_manager.dart';

final sl = GetIt.instance;

Future<void> initDependencies(Build build) async {
  var sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<SettingsNotifier>(() => SettingsNotifier());

  cacheDependencies(sl);

  switch (build) {
    case Build.DEVELOP:
      sl.registerSingleton<Configuration>(
        Configuration(
          baseUrl: "/////////////////",
          variant: build,
          defaultErrorMessage: "core.fixtures.unknownError",
        ),
      );
      break;
    case Build.RELEASE:
      sl.registerSingleton<Configuration>(
        Configuration(
          baseUrl: "/////////////////",
          variant: build,
          defaultErrorMessage: "core.fixtures.unknownError",
        ),
      );
      break;
  }
}

void cacheDependencies(GetIt locator) {
  locator.registerLazySingleton<SessionCacheManager<MovieListModel>>(
      () => SessionCacheManager<MovieListModel>());
}
