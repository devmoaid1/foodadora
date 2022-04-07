import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/ui/select_language/language_code_name_map.dart';
import 'package:stacked/stacked.dart';

class SelectLanguageViewModel extends BaseViewModel {
  String getLanguageName(String code) => languageCodeNameMap[code]!;

  void changeLocale() {
    homeNavigationViewModel.notifyListeners();
    notifyListeners();
    navigationService.back();
  }
}
