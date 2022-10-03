import 'package:stacked/stacked.dart';

class AppViewModel extends BaseViewModel {
  bool? _isLoading;
  String? _errorMessage;
  bool? _isErrorState;

  AppViewModel() {
    _isLoading = false;
    _errorMessage = "";
    _isErrorState = false;
  }

  bool get loadingState => _isLoading!;
  bool get isErrorState => _isErrorState!;
  String get errorMessage => _errorMessage!;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setErrorMessage(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void setIsErrorState(bool value) {
    _isErrorState = value;
    notifyListeners();
  }
}
