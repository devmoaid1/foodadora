import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodadora/core/api/endpoints.dart';
import 'package:foodadora/core/api/firebase_api_provider.dart';
import 'package:foodadora/core/api/geo_api_provider.dart';
import 'package:foodadora/features/store_details/data/models/product_model.dart';
import 'package:foodadora/features/stores/data/datasources/location_remote_datasource.dart';
import 'package:foodadora/features/stores/data/models/storemodel.dart';
import 'package:geoflutterfire2/geoflutterfire2.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../services/base_service.dart';
import '../../../store_details/domain/entities/product.dart';
import '../../domain/entites/store.dart';

abstract class StoreRemoteDataSource {
  Stream<List<DocumentSnapshot>> getStoresInPosition(
      {required Position position});

  Future<Store> getStoreById({required String id});

  Future<List<Product>> getStoreProducts({required String id});
}

class StoreRemoteDataSourceImpl extends BaseService
    implements StoreRemoteDataSource {
  final GeoApiProvider geo;
  final FirebaseApiProvider fireStore;
  final LocationRemoteDataSource locationService;

  StoreRemoteDataSourceImpl(
      {required this.locationService,
      required this.geo,
      required this.fireStore});
  @override
  Future<Store> getStoreById({required String id}) async {
    Store? store;
    var fetchedStore = await fireStore.getDataByID(storeCollection, 'id', id);

    for (var element in fetchedStore) {
      store = StoreModel.fromJson(element.data());
    }

    return store!;
  }

  @override
  Future<List<Product>> getStoreProducts({required String id}) async {
    var fetchedProducts = await firestore
        .collection('products')
        .where("storeId", isEqualTo: id)
        .where("isVisible", isEqualTo: true)
        .get();

    return fetchedProducts.docs
        .map((product) => ProductModel.fromJson(product.data()))
        .toList();
  }

  @override
  Stream<List<DocumentSnapshot<Object?>>> getStoresInPosition(
      {required Position position}) {
    GeoFirePoint center = GeoFlutterFire()
        .point(latitude: position.latitude, longitude: position.longitude);
    var collectionReference = firestore.collection(storeCollection);

    const double radius = 5; // radius in km
    const String field = 'pos';
    return geo.getDataInRange(
        collectionReference: collectionReference,
        center: center,
        radius: radius,
        field: field);
  }

  // @override
  // Future<Stream<List<DocumentSnapshot>>?> getStores() async {
  //   final response = await locationService.getUserLocation();
  //   final userLocation = response.userLocation;
  //   if (response.serviceEnabled == true &&
  //           userLocation != null &&
  //           response.permission == LocationPermission.always ||
  //       response.permission == LocationPermission.whileInUse) {
  //     return _getStoresInRange(userLocation!);
  //   }
  //   return null;
  // }

}
