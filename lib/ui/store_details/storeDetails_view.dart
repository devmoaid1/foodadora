// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:foodadora/models/product.dart';
import 'package:foodadora/models/store.dart';
import 'package:foodadora/ui/store_details/storeDetails_viewModel.dart';

import 'package:foodadora/ui/widgets/foodadora_app_bar.dart';
import 'package:foodadora/ui/widgets/product_card.dart';
import 'package:foodadora/ui/widgets/store_circle.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:stacked/stacked.dart';

import '../../app/utilites/expiryWeeks.dart';
import '../../app/utilites/screen_sizes.dart';

class StoreDetailsScreen extends StatelessWidget {
  final Store store;
  const StoreDetailsScreen({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: foodadoraAppBar(context, withBack: true),
      body: ViewModelBuilder<StoreDetailsViewModel>.reactive(
          viewModelBuilder: () => StoreDetailsViewModel(),
          fireOnModelReadyOnce: true,
          onModelReady: (model) =>
              model.getStoreProducts(storeId: store.id.toString()),
          builder: (context, model, _) {
            if (model.loading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return ListView(
                padding: EdgeInsets.symmetric(
                    horizontal: blockSizeHorizontal(context) * 5,
                    vertical: blockSizeVertical(context) * 1),
                shrinkWrap: true,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StoreCircle(
                          imageUrl: store.logoUrl.toString(), onPressed: () {}),
                      SizedBox(
                        height: blockSizeHorizontal(context) * 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            LineIcons.alternateMapMarker,
                            color: Colors.grey,
                            size: blockSizeHorizontal(context) * 15,
                          ),
                          Expanded(
                            child: Text(store.location!['address'].toString(),
                                style: GoogleFonts.raleway(
                                    fontSize: 18, fontWeight: FontWeight.w700)),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: blockSizeVertical(context) * 2,
                  ),
                  GridView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 9,
                      mainAxisExtent:
                          screenHeightPercentage(context, percentage: 0.47),
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                    ),
                    itemCount: model.storeProducts.length,
                    itemBuilder: (context, index) => ProductCard(
                      productImageUrl:
                          model.storeProducts[index].productImages![0],
                      storeImageUrl: store.logoUrl,
                      productName: model.storeProducts[index].productName,
                      productPrice: model.storeProducts[index].productPrice,
                      originalPrice: model.storeProducts[index].originalPrice,
                      expiryWeeks: getExpiryWeeks(
                          date: model.storeProducts[index].expiryDate
                              as DateTime),
                      onButtonPressed: () {},
                      onTapped: () {
                        Product product = Product(
                            productId: model.storeProducts[index].productId,
                            productName: model.storeProducts[index].productName,
                            productImages:
                                model.storeProducts[index].productImages,
                            storeId: model.storeProducts[index].storeId,
                            quantity: model.storeProducts[index].quantity,
                            originalPrice:
                                model.storeProducts[index].originalPrice,
                            productPrice:
                                model.storeProducts[index].productPrice,
                            expiryDate: model.storeProducts[index].expiryDate,
                            description:
                                "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry");

                        model.navigateToProductDetails(
                            product: product, store: store);
                      },
                    ),
                  )
                ]);
          }),
    );
  }
}
