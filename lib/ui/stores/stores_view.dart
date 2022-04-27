// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/app/utilites/app_colors.dart';
import 'package:foodadora/ui/stores/stores_viewmodel.dart';

import 'package:foodadora/ui/stores/widgets/home_graphic.dart';

import 'package:foodadora/ui/stores/widgets/store_item.dart';
import 'package:foodadora/ui/widgets/empty_stores_placeholder.dart';
import 'package:foodadora/ui/widgets/pressable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:stacked/stacked.dart';

import '../../app/utilites/screen_sizes.dart';
import '../widgets/noconnection_indicator.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StoresViewModel>.reactive(
        viewModelBuilder: () => storesViewModel,
        initialiseSpecialViewModelsOnce: true,
        fireOnModelReadyOnce: true,
        disposeViewModel: false,
        onModelReady: (model) {
          model.getStoresList();
        },
        builder: (context, viewModel, _) {
          print("stores screen ${viewModel.isConnected}");
          bool isLocationDenied =
              viewModel.locationPermission == LocationPermission.denied ||
                  viewModel.locationPermission ==
                      LocationPermission.deniedForever ||
                  viewModel.serviceEnabled != true;
          if (viewModel.isBusy) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (!viewModel.isConnected) {
            return NoConnection(handleRetry: () => viewModel.getStoresList());
          }
          return RefreshIndicator(
            onRefresh: () async => viewModel.getStoresList(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  if (viewModel.stores.isNotEmpty)
                    HomeGraphic(
                      isError: isLocationDenied,
                    ),
                  verticalSpaceRegular,
                  isLocationDenied
                      ? Column(
                          children: [
                            Center(
                              child: Text(
                                'Please enable location services to see stores near you',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  color: lightTextColor,
                                  fontSize: blockSizeVertical(context) * 2,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                            verticalSpaceSmall,
                            Center(
                              child: Pressable(
                                onPressed: () async {
                                  await viewModel.openLocationSettings();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      Assets.pinLocationIcon,
                                      color: actionColor,
                                    ),
                                    horizontalSpaceSmall,
                                    Text(
                                      'Enable Location',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w500,
                                        color: actionColor,
                                        fontSize:
                                            blockSizeVertical(context) * 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : viewModel.stores.isEmpty
                          ? const EmptyStoresPlaceholder()
                          : _buildStoresGrid(context, viewModel)
                ],
              ),
            ),
          );
        });
  }
}

Widget _buildStoresGrid(BuildContext context, StoresViewModel viewModel) {
  return Container(
    width: screenWidth(context) * 0.9,
    height: viewModel.stores.length * screenHeight(context) / 3,
    child: ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewModel.stores.length,
      itemBuilder: (context, index) => viewModel.stores[index] != null
          ? StoreItem(
              store: viewModel.stores[index]!,
              viewModel: viewModel,
            )
          : Container(),
    ),
  );
}
