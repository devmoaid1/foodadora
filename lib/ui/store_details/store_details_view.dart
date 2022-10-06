// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:foodadora/app/utilites/app_colors.dart';
import 'package:foodadora/app/utilites/launch_map.dart';
import 'package:foodadora/ui/store_details/widgets/product_item.dart';
import 'package:foodadora/ui/widgets/pressable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import 'package:foodadora/ui/store_details/store_details_viewmodel.dart';
import 'package:foodadora/ui/widgets/foodadora_app_bar.dart';

import '../../app/utilites/screen_sizes.dart';
import '../../features/stores/domain/entites/store.dart';
import '../../services/connectivity_service.dart';
import '../widgets/noconnection_indicator.dart';

class StoreDetailsScreen extends StatelessWidget {
  final Store store;
  final String distance;
  const StoreDetailsScreen({
    Key? key,
    required this.store,
    required this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: foodadoraAppBar(context, withBack: true),
      body: ViewModelBuilder<StoreDetailsViewModel>.reactive(
          viewModelBuilder: () => Get.find<StoreDetailsViewModel>(),
          fireOnModelReadyOnce: true,
          onModelReady: (model) =>
              model.getStoreProducts(storeId: store.id.toString()),
          builder: (context, model, _) {
            if (model.loading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }

            if (!context.watch<ConnectivityService>().isConnected) {
              return NoConnection(
                handleRetry: () =>
                    model.getStoreProducts(storeId: store.id.toString()),
              );
            }
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                  horizontal: 12, vertical: blockSizeVertical(context) * 1),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            constraints: BoxConstraints(
                                minWidth: blockSizeHorizontal(context) * 15,
                                maxWidth: blockSizeHorizontal(context) * 25),
                            child: FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child: Text(
                                " ${store.storeName?.toUpperCase() ?? ""}",
                                style: GoogleFonts.poppins(
                                    color: textColor,
                                    fontSize:
                                        blockSizeHorizontal(context) * 5.5),
                              ),
                            ),
                          ),
                          horizontalSpaceMedium,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: badgeColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      Assets.pinLocationIcon,
                                      width: blockSizeHorizontal(context) * 4,
                                      color: textColor,
                                    ),
                                    Text(
                                      distance,
                                      style: GoogleFonts.poppins(
                                          color: textColor,
                                          fontSize:
                                              blockSizeHorizontal(context) * 3),
                                    ),
                                  ],
                                ),
                              ),
                              horizontalSpaceSmall,
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: badgeColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  store.category!.capitalize.toString(),
                                  style: GoogleFonts.poppins(
                                      color: textColor,
                                      fontSize:
                                          blockSizeHorizontal(context) * 3),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      verticalSpaceRegular,
                      Card(
                        elevation: .5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: Colors.white,
                        child: Padding(
                          padding:
                              EdgeInsets.all(blockSizeVertical(context) * 1.5),
                          child: SizedBox(
                            width: blockSizeHorizontal(context) * 120,
                            height: blockSizeVertical(context) * 12,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                store.imageUrl.toString(),
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child,
                                        loadingProgress) =>
                                    loadingProgress == null
                                        ? child
                                        : const CircularProgressIndicator
                                            .adaptive(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpaceRegular,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        Assets.pinLocationIcon,
                        width: blockSizeHorizontal(context) * 6,
                        color: textColor,
                      ),
                      Expanded(
                        flex: 2,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            store.address ?? " - ",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: GoogleFonts.poppins(
                                color: textColor,
                                fontSize: blockSizeHorizontal(context) * 4),
                          ),
                        ),
                      ),
                      horizontalSpaceSmall,
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Pressable(
                            onPressed: () async => await launchMap(
                                store.pos?["geopoint"] as GeoPoint),
                            child: Row(
                              children: [
                                Text(
                                  "View On Map ",
                                  style: GoogleFonts.poppins(
                                      color: actionColor,
                                      fontSize:
                                          blockSizeHorizontal(context) * 3,
                                      fontWeight: FontWeight.w500),
                                ),
                                SvgPicture.asset(
                                  Assets.arrowRightIcon,
                                  width: blockSizeHorizontal(context) * 4,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpaceRegular,
                  GridView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 9,
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      childAspectRatio: 0.9,
                      mainAxisExtent: screenHeight(context) * 0.25,
                    ),
                    itemCount: model.storeProducts.length,
                    itemBuilder: (context, index) => ProductItem(
                      product: model.storeProducts[index],
                      onPressed: () => model.navigateToProductDetails(
                          product: model.storeProducts[index], store: store),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
