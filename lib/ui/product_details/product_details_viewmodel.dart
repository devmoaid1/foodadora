import 'package:foodadora/app/constants/services_instances.dart';
import 'package:stacked/stacked.dart';

class ProductDetailsViewModel extends BaseViewModel {
  String _storeImage = "";

  String get storeImage => _storeImage;
  bool _isLoading = false;

  bool get loading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void getStoreImage({required String id}) async {
    setLoading(true);
    setBusy(true);
    try {
      var store = await storeService.getStoreById(id);

      _storeImage = store!.logoUrl.toString();
      setBusy(false);
      setLoading(false);
    } catch (err) {
      setBusy(false);
      setLoading(false);
      logger.e(err.toString());
    }
  }
}
