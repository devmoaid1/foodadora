// ignore_for_file: unused_import, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/product.dart';
import 'package:foodadora/ui/product_details/product_details_viewmodel.dart';
import 'package:foodadora/ui/widgets/foodadora_app_bar.dart';

import 'package:foodadora/ui/widgets/foodadora_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:stacked/stacked.dart';

import '../../app/utilites/app_colors.dart';
import '../../app/utilites/get_expiry_weeks.dart';
import '../../app/utilites/screen_sizes.dart';
import '../../models/store.dart';
import 'widgets/Product_image.dart';

class ProductDetailsView extends StatelessWidget {
  final Product product;
  final Store store;

  const ProductDetailsView(
      {Key? key, required this.product, required this.store})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: foodadoraAppBar(context, withBack: true),
      body: ViewModelBuilder<ProductDetailsViewModel>.reactive(
          disposeViewModel: false,
          onModelReady: (model) => model.init(),
          viewModelBuilder: () => productDetailsViewModel,
          builder: (context, model, _) {
            if (model.loading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductImage(
                  expiry: getExpiryWeeks(date: product.expiryDate as DateTime),
                  productimage: product.imageUrl,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: blockSizeHorizontal(context) * 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        product.productName.toString(),
                        style: GoogleFonts.poppins(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: blockSizeHorizontal(context) * 5),
                      ),
                      SizedBox(
                        width: blockSizeHorizontal(context) * 2,
                      ),
                      SvgPicture.asset(
                        Assets.storeicon,
                        width: blockSizeHorizontal(context) * 5,
                        color: darkBlueColor,
                      ),
                      horizontalSpaceSmall,
                      Text(
                        store.storeName ?? "",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: darkBlueColor,
                            fontSize: blockSizeHorizontal(context) * 4),
                      ),
                    ],
                  ),
                ),
                verticalSpaceRegular,
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: blockSizeHorizontal(context) * 4),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Assets.priceIcon,
                        height: 20,
                      ),
                      SizedBox(
                        width: blockSizeHorizontal(context) * 2,
                      ),
                      Text(
                        "${product.productPrice!.toStringAsFixed(2)} RM",
                        style: GoogleFonts.poppins(
                            fontSize: blockSizeHorizontal(context) * 4,
                            color: const Color(0xffFF0000)),
                      ),
                      SizedBox(
                        width: blockSizeHorizontal(context),
                      ),
                      Text(
                        "${product.originalPrice!.toStringAsFixed(2)} RM",
                        style: GoogleFonts.poppins(
                            fontSize: blockSizeHorizontal(context) * 4,
                            decoration: TextDecoration.lineThrough,
                            color: textColor),
                      ),
                      SizedBox(
                        width: blockSizeHorizontal(context) * 12,
                      ),
                      SvgPicture.asset(
                        Assets.pinLocationIcon,
                        height: 20,
                      ),
                      Row(
                        children: [
                          Text(
                            "2.6",
                            style: GoogleFonts.poppins(
                                fontSize: blockSizeHorizontal(context) * 4,
                                color: textColor),
                          ),
                          Text(
                            "KM away",
                            style: GoogleFonts.poppins(
                                fontSize: blockSizeHorizontal(context) * 4,
                                color: textColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                verticalSpaceRegular,
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: blockSizeHorizontal(context) * 3),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Description",
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: textColor,
                                  fontWeight: FontWeight.w500)),
                          verticalSpaceSmall,
                          (product.description != null &&
                                  product.description.toString().isNotEmpty)
                              ? Text(
                                  product.description.toString(),
                                  style: GoogleFonts.poppins(
                                    fontSize: blockSizeHorizontal(context) * 3,
                                    color: textColor,
                                  ),
                                  textAlign: TextAlign.justify,
                                )
                              : verticalSpaceLarge,
                        ],
                      ),
                    ),
                  ),
                ),
                model.isAddToCart
                    ?
                    // quantity container
                    UpdateQuantityCard(product: product)
                    : Padding(
                        padding: const EdgeInsets.all(12),
                        child: FoodadoraButton(
                          label: 'Add to Cart',
                          onPressed: () => model.setIsAddToCart(true),
                          iconPath: Assets.shoppingicon,
                        ),
                      )
              ],
            );
          }),
    );
  }
}

class UpdateQuantityCard extends ViewModelWidget<ProductDetailsViewModel> {
  const UpdateQuantityCard({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context, ProductDetailsViewModel viewModel) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: blockSizeHorizontal(context) * 2),
      child: Container(
        color: const Color(0xffEEEEEE),
        padding: EdgeInsets.symmetric(
            horizontal: blockSizeHorizontal(context) * 2,
            vertical: blockSizeVertical(context) * 2),
        child: Column(
          children: [
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                height: screenHeightPercentage(context, percentage: 0.08),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    viewModel.quantity == 1
                        ? GestureDetector(
                            onTap: () {
                              viewModel.setIsAddToCart(false);
                            },
                            child: SvgPicture.asset(
                              Assets.trashIcon,
                              height: 30,
                            ))
                        : GestureDetector(
                            onTap: () {
                              viewModel.decrementQuantity();
                            },
                            child: SvgPicture.asset(
                              Assets.minusicon,
                              height: 30,
                            )),
                    SizedBox(
                      width: blockSizeHorizontal(context) * 4,
                    ),
                    Text(
                      viewModel.quantity.toString(),
                      style: GoogleFonts.poppins(
                          fontSize: blockSizeHorizontal(context) * 6),
                    ),
                    SizedBox(
                      width: blockSizeHorizontal(context) * 4,
                    ),
                    GestureDetector(
                        onTap: () {
                          viewModel.incrementQunatity(
                              productQuantity: product.quantity as int);
                        },
                        child: SvgPicture.asset(
                          Assets.plusicon,
                          height: 30,
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: blockSizeVertical(context) * 2,
            ),
            FoodadoraButton(
              label: 'Continue Shopping',
              onPressed: () => viewModel.addToCart(
                  product: product, quatity: viewModel.quantity),
              iconPath: Assets.wareHouseicon,
            )
          ],
        ),
      ),
    );
  }
}
