// ignore_for_file: file_names, unnecessary_null_comparison

import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/app/utilites/custom_modals.dart';
import 'package:foodadora/core/usecases/use_cases.dart';
import 'package:foodadora/features/profile/domain/usecases/logout_usecase.dart';

import 'package:stacked/stacked.dart';

class ProfileViewModel extends BaseViewModel {
  final LogoutUseCase logoutUseCase;

  ProfileViewModel({required this.logoutUseCase});

  void signOut() async {
    setBusy(true);

    final response = await logoutUseCase(NoParams());

    response.fold((failure) {
      logger.e(failure.message);
      dialogService.showCustomDialog(
        variant: DialogType.basic,
        title: "error",
        description: failure.message,
      );
    }, (r) {
      setBusy(false);
      homeNavigationViewModel.notifyListeners();
      navigationService.back();
    });
  }
}
