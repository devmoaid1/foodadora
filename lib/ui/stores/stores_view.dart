// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:foodadora/app/app.locator.dart';
import 'package:foodadora/ui/stores/widgets/home_graphic.dart';
import 'package:foodadora/ui/stores/stores_viewModel.dart';
import 'package:foodadora/ui/stores/widgets/store_item.dart';

import 'package:stacked/stacked.dart';

import '../../app/utilites/screen_sizes.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StoresViewModel>.reactive(
        viewModelBuilder: () => locator<StoresViewModel>(),
        initialiseSpecialViewModelsOnce: true,
        fireOnModelReadyOnce: true,
        disposeViewModel: false,
        onModelReady: (model) {
          model.getStoresList();
        },
        builder: (context, viewModel, _) {
          if (viewModel.isBusy) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          return RefreshIndicator(
            onRefresh: () async => viewModel.getStoresList(),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  HomeGraphic(),
                  verticalSpaceRegular,
                  viewModel.stores.isEmpty
                      ? const Center(
                          child: Text('No Stores'),
                        )
                      : _buildStoresGrid(context, viewModel),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildStoresGrid(BuildContext context, StoresViewModel viewmodel) {
    return Container(
      width: screenWidth(context) * 0.9,
      height: viewmodel.stores.length * screenHeight(context) / 3,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewmodel.stores.length,
        itemBuilder: (context, index) => viewmodel.stores[index] != null
            ? StoreItem(
                store: viewmodel.stores[index]!,
              )
            : Container(),
      ),
    );
  }
}
