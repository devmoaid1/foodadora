import 'package:foodadora/app/constants/services_instances.dart';

import 'package:stacked/stacked.dart';

import 'language_code_name_map.dart';

class SelectLanguageViewModel extends BaseViewModel {
  String getLanguageName(String code) => languageCodeNameMap[code]!;

  void changeLocale() {
    homeNavigationViewModel.notifyListeners();
    notifyListeners();
    navigationService.back();
  }
}
