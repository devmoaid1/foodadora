// ignore_for_file: file_names, unnecessary_null_comparison

import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/app/utilites/custom_modals.dart';
import 'package:foodadora/core/usecases/use_cases.dart';
import 'package:foodadora/features/profile/domain/usecases/get_current_customer_usecase.dart';
import 'package:foodadora/features/profile/domain/usecases/logout_usecase.dart';

import 'package:stacked/stacked.dart';

import '../../../auth/domain/entities/customer.dart';

class ProfileViewModel extends BaseViewModel {
  final GetCurrentCustomerUseCase getCurrentCustomerUseCase;
  final LogoutUseCase logoutUseCase;

  ProfileViewModel(
      {required this.getCurrentCustomerUseCase, required this.logoutUseCase});

  Customer? get customerProfile => profileService.currentCustomer;

  bool get isLoggedOn => profileService.isLoggedOn;

  void getCurrentCustomer() async {
    setBusy(true);

    final userId = authService.auth.currentUser?.uid;

    if (userId != null) {
      final response =
          await getCurrentCustomerUseCase(GetCurrentCustomerParams(id: userId));

      response.fold((failure) {
        logger.e(failure.message);
        dialogService.showCustomDialog(
          variant: DialogType.basic,
          title: "error",
          description: failure.message,
        );
      }, (customer) {
        logger.i("customer: ${customer.name}");
        profileService.setIsLoggedOn(true);
        profileService.setCurrentCustomer(customer);
        profileService.setCustomerName(customer.name!);
        setBusy(false);
      });
    } else {
      profileService.setIsLoggedOn(false);
      setBusy(false);
    }
  }

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
