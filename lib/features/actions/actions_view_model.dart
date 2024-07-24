import 'package:bareekmedia/core/fixtures/theme_codes.dart';
import 'package:bareekmedia/features/base_view_model.dart';

import '../../core/fixtures/language_codes.dart';
import '../../models/settings_model.dart';
import 'actions_repo.dart';

class ActionsViewModel extends BaseViewModel {
  final ActionsRepo _actionsRepo = ActionsRepo();

  SettingsModel settingsModel = const SettingsModel();
  String selectedLanguage = LanguageCodes.english;
  String selectedTheme = ThemeCodes.dark;
  late List<bool> faqsIsExpanded;

  void prepareSettings() {
    setBusy();
    var result = _actionsRepo.loadSettings();
    result.fold(
      (l) {},
      (r) {
        settingsModel = r;
        selectedLanguage = r.local;
        selectedTheme = r.theme;
      },
    );
    setIdle();
  }

  void changeTheme(String theme) {
    _actionsRepo.changeTheme(theme: theme);
    notifyListeners();
  }

  void changeLanguage(String language) {
    _actionsRepo.changeLanguage(language: language);
    notifyListeners();
  }
}
