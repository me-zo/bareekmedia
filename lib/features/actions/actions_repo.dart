import 'package:bareekmedia/features/base_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../core/dependency_registrar/dependencies.dart';
import '../../app/settings_notifier.dart';
import '../../models/settings_model.dart';

class ActionsRepo extends BaseRepo {
  final SettingsNotifier _settingsNotifier = sl();

  Either<FailureModel, SettingsModel> loadSettings() => Right(
        SettingsModel(
          local: _settingsNotifier.getLocale.languageCode,
          theme: _settingsNotifier.getThemeName,
        ),
      );

  Either<FailureModel, void> changeLanguage({required String language}) {
    _settingsNotifier.setLocale(language);
    return const Right(null);
  }

  Either<FailureModel, void> changeTheme({required String theme}) {
    _settingsNotifier.setTheme(theme);
    return const Right(null);
  }
}
