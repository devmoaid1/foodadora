// ignore_for_file: unused_import, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/product.dart';
import 'package:foodadora/ui/product_details/product_details_viewmodel.dart';
import 'package:foodadora/ui/utilites/expiryWeeks.dart';
import 'package:foodadora/ui/utilites/screen_sizes.dart';
import 'package:foodadora/ui/widgets/foodadora_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:stacked/stacked.dart';

import 'widgets/Product_image.dart';

class ProductDetailsView extends StatelessWidget {
  final Product product;

  const ProductDetailsView({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ViewModelBuilder<ProductDetailsViewModel>.reactive(
            onModelReady: (model) =>
                model.getStoreImage(id: product.storeId.toString()),
            viewModelBuilder: () => productDetailsViewModel,
            builder: (context, model, _) {
              if (model.loading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductImage(
                        expiry: getExpiryWeeks(
                            date: product.expiryDate as DateTime),
                        productimage: product.productImages![0],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: blockSizeHorizontal(context) * 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.productName.toString(),
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          blockSizeHorizontal(context) * 5),
                                ),
                                Text(
                                  "${product.originalPrice!.toStringAsFixed(2)} RM",
                                  style: GoogleFonts.poppins(
                                      fontSize:
                                          blockSizeHorizontal(context) * 6,
                                      color: const Color(0xffFF0000)),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 3)
                                ],
                              ),
                              child: GestureDetector(
                                onTap: null,
                                child: CircleAvatar(
                                  radius: 40.0,
                                  backgroundColor: Colors.white,
                                  child: Image(
                                    image: NetworkImage(model.storeImage),
                                    fit: BoxFit.contain,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      'assets/images/foodadora_seller.png',
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: blockSizeHorizontal(context) * 3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Description",
                                  style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600)),
                              SizedBox(
                                height: blockSizeVertical(context),
                              ),
                              Container(
                                constraints: BoxConstraints(
                                    maxHeight: screenHeightPercentage(context,
                                        percentage: 0.26)),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  product.description.toString(),
                                  style: TextStyle(
                                    fontFamily: "Poppins",
                                    fontSize: blockSizeHorizontal(context) * 3,
                                    color: const Color(0xffB6B6B6),
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: blockSizeVertical(context) * 3,
                              ),
                              Center(
                                  child: FoodadoraButton(
                                      label: "Add to cart",
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            elevation: 2,
                                            constraints: BoxConstraints(
                                                maxHeight:
                                                    screenHeightPercentage(
                                                        context,
                                                        percentage: 0.4)),
                                            enableDrag: true,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            builder: (context) {
                                              return ViewModelBuilder<
                                                  ProductDetailsViewModel>.nonReactive(
                                                viewModelBuilder: () =>
                                                    productDetailsViewModel,
                                                disposeViewModel: false,
                                                builder: (context, model, _) =>
                                                    UpdateQuantityBottomSheet(
                                                        product: product),
                                              );
                                            });
                                      }))
                            ],
                          ))
                    ]),
              );
            }));
  }
}

class UpdateQuantityBottomSheet
    extends ViewModelWidget<ProductDetailsViewModel> {
  const UpdateQuantityBottomSheet({Key? key, required this.product})
      : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context, ProductDetailsViewModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: blockSizeVertical(context) * 10,
              width: blockSizeHorizontal(context) * 15,
              child: RawMaterialButton(
                onPressed: () {
                  viewModel.decrementQuantity();
                },
                elevation: 0,
                fillColor: const Color(0xfff9f9f9),
                child: Padding(
                  padding: EdgeInsets.all(blockSizeHorizontal(context)),
                  child: Icon(
                    LineIcons.minus,
                    color: const Color(0xffa6a6a6),
                    size: blockSizeHorizontal(context) * 4,
                  ),
                ),
                shape: const CircleBorder(),
              ),
            ),
            Text(
              viewModel.quantity.toString(),
              style: GoogleFonts.poppins(
                  fontSize: blockSizeHorizontal(context) * 7),
            ),
            Container(
              height: blockSizeVertical(context) * 10,
              width: blockSizeHorizontal(context) * 15,
              child: RawMaterialButton(
                onPressed: () {
                  viewModel.incrementQunatity(
                      productQuantity: product.quantity as int);
                },
                elevation: 0,
                fillColor: const Color(0xfff9f9f9),
                child: Padding(
                  padding: EdgeInsets.all(blockSizeHorizontal(context)),
                  child: Icon(
                    LineIcons.plus,
                    color: const Color(0xffa6a6a6),
                    size: blockSizeHorizontal(context) * 6,
                  ),
                ),
                shape: const CircleBorder(),
              ),
            ),
            SizedBox(
              width: blockSizeHorizontal(context) * 1,
            ),
            Container(
                width: blockSizeHorizontal(context) * 24,
                child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      "${product.quantity} items left",
                      style: GoogleFonts.poppins(
                          fontSize: blockSizeHorizontal(context) * 18),
                    )))
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: blockSizeHorizontal(context) * 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: screenWidthPercentage(context, percentage: 0.4),
                child: FoodadoraButton(
                  label: "Cancel",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: Colors.white,
                  borderColor: Colors.black,
                  labelColor: Colors.black,
                ),
              ),
              Container(
                width: screenWidthPercentage(context, percentage: 0.4),
                child: FoodadoraButton(
                  label: "Done",
                  onPressed: () {
                    viewModel.addToCart(
                        product: product, quatity: viewModel.quantity);
                  },
                  color: const Color(0xFF08A5D2),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
