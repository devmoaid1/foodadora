// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:foodadora/app/constants/services_instances.dart';
// import 'package:foodadora/models/product.dart';

// import 'package:foodadora/services/base_service.dart';
// import 'package:geoflutterfire2/geoflutterfire2.dart';
// import 'package:geolocator/geolocator.dart';

// import '../features/stores/domain/entites/store.dart';

// class StoreService extends BaseService {
//   final geo = GeoFlutterFire();

//   Future<Stream<List<DocumentSnapshot>>?> getStores() async {
//     try {
//       await locationService.getUserLocation();
//       Position? _userLocation = locationService.userLocation;
//       if (locationService.serviceEnabled == true &&
//               _userLocation != null &&
//               locationService.permission == LocationPermission.always ||
//           locationService.permission == LocationPermission.whileInUse) {
//         return _getStores(_userLocation!);
//       }
//     } catch (err) {
//       logger.e(err.toString());
//     }
//     return null;
//   }

//   Stream<List<DocumentSnapshot>> _getStores(Position position) {
//     GeoFirePoint center =
//         geo.point(latitude: position.latitude, longitude: position.longitude);
//     var collectionReference = firestore.collection('stores');

//     const double radius = 5; // radius in km
//     const String field = 'pos';
//     return geo
//         .collection(collectionRef: collectionReference)
//         .within(center: center, radius: radius, field: field);
//   }

//   Future<Store?> getStoreById(String id) async {
//     Store store = Store();
//     try {
//       var fetchedStore =
//           await firestore.collection('stores').where('id', isEqualTo: id).get();

//       for (var element in fetchedStore.docs) {
//         store = Store.fromJson(element.data());
//       }
//     } catch (err) {
//       logger.e(err.toString());
//     }

//     return store;
//   }

//   Future<List<Product>> getStoreProducts(String storeId) async {
//     try {
//       var fetchedProducts = await firestore
//           .collection('products')
//           .where("storeId", isEqualTo: storeId)
//           .where("isVisible", isEqualTo: true)
//           .get();

//       return fetchedProducts.docs
//           .map((product) => Product.fromJson(product.data()))
//           .toList();
//     } catch (err) {
//       logger.e(err.toString());
//       return [];
//     }
//   }
// }
