import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/store.dart';
import 'package:stacked/stacked.dart';

class StoresViewModel extends BaseViewModel {
  List<Store> _stores = [];
  bool _isLoading = false;

  bool get loading => _isLoading;
  List<Store> get stores => _stores;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void getStoresList() async {
    setBusy(true);
    setLoading(true);
    try {
      _stores = await storeService.getStores();
      setBusy(false);
      setLoading(false);
    } catch (err) {
      setLoading(false);
      logger.e(err.toString());
    }
  }
}
