// ignore_for_file: sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/services/connectivity_service.dart';

import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import 'package:stacked/stacked.dart';

import '../../../../app/utilites/screen_sizes.dart';

import '../../../../core/widgets/empty_stores_placeholder.dart';
import '../../../../core/widgets/location_disabled_placeholder.dart';
import '../../../../core/widgets/noconnection_indicator.dart';
import '../viewmodels/stores_viewModel.dart';
import '../widgets/home_graphic.dart';
import '../widgets/store_item.dart';

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
          bool isLocationDenied =
              viewModel.locationPermission == LocationPermission.denied ||
                  viewModel.locationPermission ==
                      LocationPermission.deniedForever ||
                  viewModel.serviceEnabled != true;
          if (viewModel.isBusy) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (!context.watch<ConnectivityService>().isConnected) {
            return NoConnection(handleRetry: () => viewModel.getStoresList());
          }
          return RefreshIndicator(
            onRefresh: () async => viewModel.getStoresList(),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  if (viewModel.stores.isNotEmpty || isLocationDenied)
                    HomeGraphic(
                      isError: isLocationDenied,
                    ),
                  verticalSpaceRegular,
                  isLocationDenied
                      ? LocationDisabledPlaceholder(
                          openLocationSettings: () async =>
                              await viewModel.openLocationSettings(),
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
    child: ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: viewModel.stores.length,
      itemBuilder: (context, index) => viewModel.stores[index] != null
          ? StoreItem(
              store: viewModel.stores[index]!,
              viewModel: viewModel,
            )
          : Container(),
      separatorBuilder: (context, index) => verticalSpaceRegular,
    ),
  );
}
