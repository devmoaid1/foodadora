// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/app/utilites/app_colors.dart';
import 'package:foodadora/ui/stores/stores_viewmodel.dart';

import 'package:foodadora/ui/stores/widgets/home_graphic.dart';

import 'package:foodadora/ui/stores/widgets/store_item.dart';
import 'package:foodadora/ui/widgets/pressable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:stacked/stacked.dart';

import '../../app/utilites/screen_sizes.dart';

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
          print("stores screen ${viewModel.connectivityResult}");
          bool isLocationDenied =
              viewModel.locationPermission == LocationPermission.denied ||
                  viewModel.locationPermission ==
                      LocationPermission.deniedForever ||
                  viewModel.serviceEnabled != true;
          if (viewModel.isBusy) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          return RefreshIndicator(
            onRefresh: () async => viewModel.getStoresList(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  HomeGraphic(
                    isError: isLocationDenied,
                  ),
                  verticalSpaceRegular,
                  viewModel.stores.isEmpty
                      ? isLocationDenied
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                          : Center(
                              child: viewModel.connectivityResult ==
                                      ConnectivityResult.wifi
                                  ? Text(
                                      'No stores found near you',
                                      style: GoogleFonts.poppins(
                                        color: lightTextColor,
                                        fontSize:
                                            blockSizeVertical(context) * 2.5,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    )
                                  : Text(
                                      'No connection',
                                      style: GoogleFonts.poppins(
                                        color: lightTextColor,
                                        fontSize:
                                            blockSizeVertical(context) * 2.5,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ))
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
              viewModel: viewModel as StoresViewModel,
            )
          : Container(),
    ),
  );
}
