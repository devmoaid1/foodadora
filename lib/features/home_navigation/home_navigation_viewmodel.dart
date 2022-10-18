import 'package:stacked/stacked.dart';

class HomeNavigationViewModel extends IndexTrackingViewModel {
  void onRefresh() => notifyListeners();
}
