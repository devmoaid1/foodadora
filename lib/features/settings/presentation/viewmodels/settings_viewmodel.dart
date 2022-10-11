import 'package:foodadora/app/app.router.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/app/utilites/app_colors.dart';

import 'package:stacked/stacked.dart';

import '../../../auth/domain/entities/customer.dart';

class SettingsViewModel extends BaseViewModel {
  Customer? get customerProfile => profileService.currentCustomer;

  String get customerName => profileService.customerName;
  String get customerAccountType => profileService.customerAccountType;

  void navigateToAuth() => navigationService.navigateTo(Routes.loginView);

  void navigateToProfile() {
    navigationService.navigateTo(Routes.profileScreen,
        arguments: ProfileScreenArguments(
            name: customerProfile!.name ?? "",
            phone: customerProfile!.phoneNumber ?? "",
            image: getProfileIcon(),
            color: getProfileIcon() == Assets.emailIcon ? textColor : null));
  }

  String getProfileIcon() {
    switch (customerAccountType) {
      case "google.com":
        return Assets.googleIcon;
      case "password":
      case "email":
      default:
        return Assets.emailIcon;
    }
  }

  void navigateToLanguage() {
    navigationService
        .navigateTo(Routes.selectLanguageView)!
        .then((value) => notifyListeners());
  }
}
