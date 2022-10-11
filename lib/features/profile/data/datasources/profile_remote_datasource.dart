import 'package:foodadora/core/api/endpoints.dart';
import 'package:foodadora/core/api/firebase_api_provider.dart';
import 'package:foodadora/services/base_service.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../auth/data/models/customer_model.dart';
import '../../../auth/domain/entities/customer.dart';

abstract class ProfileRemoteDataSource {
  Future<Customer> getCurrentCustomer({required String id});
  Future<void> logout();
}

class ProfileRemoteDataSourceImpl extends BaseService
    implements ProfileRemoteDataSource {
  final FirebaseApiProvider firebaseApiProvider;

  ProfileRemoteDataSourceImpl({required this.firebaseApiProvider});

  @override
  Future<Customer> getCurrentCustomer({required String id}) async {
    Customer? customer;

    final response =
        await firebaseApiProvider.getDataByID(customerCollection, "userId", id);

    for (var doc in response) {
      customer = CustomerModel.fromJson(doc.data());
    }

    return customer!;
  }

  @override
  Future<void> logout() async {
    final isGoogleUser =
        await GoogleSignIn().isSignedIn(); // check if google user signed in

    if (isGoogleUser) {
      await GoogleSignIn().signOut();
    }

    await auth.signOut();
  }
}
