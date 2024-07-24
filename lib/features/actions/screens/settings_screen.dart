import 'package:bareekmedia/features/actions/actions_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/localization/resources.dart';
import '../../../../core/fixtures/language_codes.dart';
import '../../../../core/fixtures/theme_codes.dart';

class SettingsScreen extends StatelessWidget {
  static const String name = "/SettingsScreen";

  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var locale = Resources.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(locale.get('actions.settingsHeader')),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Consumer<ActionsViewModel>(
          builder: (context, model, _) {
            return Column(
              children: [
                _SettingsRow(
                  title: locale.get('actions.appLanguage'),
                  child: DropdownButton<String>(
                    hint: Text(
                      locale.get(
                          'fixtures.languageCodes.${model.selectedLanguage}'),
                    ),
                    value: model.selectedLanguage,
                    items: List.generate(
                      LanguageCodes.values.length,
                      (index) => DropdownMenuItem<String>(
                        value: LanguageCodes.values[index],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            locale.get(
                                'fixtures.languageCodes.${LanguageCodes.values[index]}'),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      model.selectedLanguage = value ?? "";
                      model.changeLanguage(model.selectedLanguage);
                    },
                  ),
                ),
                _SettingsRow(
                  title: locale.get('actions.appTheme'),
                  child: DropdownButton<String>(
                    hint: Text(
                      locale.get('fixtures.ThemeCodes.${model.selectedTheme}'),
                    ),
                    value: model.selectedTheme,
                    items: List.generate(
                      ThemeCodes.values.length,
                      (index) => DropdownMenuItem<String>(
                        value: ThemeCodes.values[index],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Text(
                            locale.get(
                                'fixtures.ThemeCodes.${ThemeCodes.values[index]}'),
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      model.selectedTheme = value ?? "";
                      model.changeTheme(model.selectedTheme);
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    Key? key,
    required this.title,
    required this.child,
  }) : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          title,
        )),
        child,
      ],
    );
  }
}
