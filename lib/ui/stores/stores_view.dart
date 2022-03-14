// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/ui/stores/stores_viewModel.dart';
import 'package:foodadora/ui/utilites/screen_sizes.dart';
import 'package:foodadora/ui/widgets/store_circle.dart';
import 'package:line_icons/line_icons.dart';
import 'package:stacked/stacked.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: Icon(
              LineIcons.angleLeft,
              color: Theme.of(context).primaryColor,
              size: blockSizeHorizontal(context) * 8,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Padding(
          padding: EdgeInsets.all(blockSizeHorizontal(context)),
          child: Image.asset(
            'assets/images/sublogo.png',
            height: blockSizeVertical(context) * 7,
          ),
        ),
        elevation: 0,
      ),
      body: ViewModelBuilder<StoresViewModel>.reactive(
          viewModelBuilder: () => storesViewModel,
          onModelReady: (model) => model.getStoresList(),
          builder: (context, viewModel, _) {
            if (viewModel.loading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: blockSizeHorizontal(context) * 5,
                    vertical: blockSizeVertical(context) * 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stores',
                      style:
                          TextStyle(fontSize: blockSizeHorizontal(context) * 8),
                    ),
                    SizedBox(height: blockSizeVertical(context) * 3),
                    viewModel.stores.isEmpty
                        ? const Center(
                            child: Text('No Stores'),
                          )
                        : _buildStoresGrid(context, viewModel),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget _buildStoresGrid(BuildContext context, StoresViewModel viewmodel) {
    return Container(
      width: screenWidth(context) * 0.9,
      height: blockSizeVertical(context) * 90,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.8,
            crossAxisCount: 3,
            mainAxisSpacing: screenWidth(context) * 0.1),
        itemCount: viewmodel.stores.length,
        itemBuilder: (context, index) => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: StoreCircle(
                imageUrl: viewmodel.stores[index].logoUrl.toString(),
                onPressed: () {
                  viewmodel.navigateToStoreDetails(
                      store: viewmodel.stores[index]);
                },
              ),
            ),
            SizedBox(height: blockSizeVertical(context)),
            Text(
              viewmodel.stores[index].storeName.toString(),
              style: TextStyle(fontSize: blockSizeHorizontal(context) * 5),
            ),
          ],
        ),
      ),
    );
  }
}
