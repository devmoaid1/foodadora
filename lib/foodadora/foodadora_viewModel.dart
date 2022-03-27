// ignore_for_file: file_names

import 'package:stacked/stacked.dart';

import '../app/constants/services_instances.dart';

class FoodadoraViewModel extends BaseViewModel {
  void getCurrentCustomer() {
    profileService.getCurrentCustomer();
  }
}
