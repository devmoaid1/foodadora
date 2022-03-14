// ignore_for_file: unused_import, sized_box_for_whitespace

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/product.dart';
import 'package:foodadora/ui/product_details/product_details_viewmodel.dart';
import 'package:foodadora/ui/utilites/app_colors.dart';
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
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: blockSizeVertical(context) * 10,
          backgroundColor: scaffoldColor,
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
              height: blockSizeVertical(context) * 8.5,
            ),
          ),
          elevation: 0,
        ),
        body: ViewModelBuilder<ProductDetailsViewModel>.reactive(
            disposeViewModel: false,
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              product.productName.toString(),
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: blockSizeHorizontal(context) * 4),
                            ),
                            SizedBox(
                              width: blockSizeHorizontal(context) * 2,
                            ),
                            SvgPicture.asset(
                              Assets.storeicon,
                              height: 20,
                            ),
                            SizedBox(
                              width: blockSizeHorizontal(context) * 2,
                            ),
                            Text(
                              "Tesco store",
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff0054A4),
                                  fontSize: blockSizeHorizontal(context) * 4),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: blockSizeVertical(context) * 2,
                      ),
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
                                  color: const Color(0xff5C5C5F)),
                            ),
                            SizedBox(
                              width: blockSizeHorizontal(context) * 12,
                            ),
                            SvgPicture.asset(
                              Assets.pinLocationIcon,
                              height: 20,
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    "2.6",
                                    style: GoogleFonts.poppins(
                                        fontSize:
                                            blockSizeHorizontal(context) * 4,
                                        color: const Color(0xff5C5C5F)),
                                  ),
                                  Text(
                                    "KM away",
                                    style: GoogleFonts.poppins(
                                        fontSize:
                                            blockSizeHorizontal(context) * 4,
                                        color: const Color(0xff5C5C5F)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: blockSizeVertical(context) * 4,
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
                                      color: const Color(0xff5C5C5F),
                                      fontWeight: FontWeight.w500)),
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
                                  style: GoogleFonts.poppins(
                                    fontSize: blockSizeHorizontal(context) * 3,
                                    color: const Color(0xff5C5C5F),
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: blockSizeVertical(context) * 3,
                              ),

                              model.isAddToCart
                                  ?

                                  // quantity container
                                  UpdateQuantityCard(product: product)
                                  : GestureDetector(
                                      onTap: () => model.setIsAddToCart(true),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xff0095DA),
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        height: screenHeightPercentage(context,
                                            percentage: 0.08),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Add To Cart",
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: blockSizeHorizontal(
                                                          context) *
                                                      5),
                                            ),
                                            SizedBox(
                                              width:
                                                  blockSizeHorizontal(context) *
                                                      2,
                                            ),
                                            SvgPicture.asset(
                                              Assets.shoppingicon,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),

                              // Center(
                              //     child: FoodadoraButton(
                              //         label: "Add to cart",
                              //         onPressed: () {
                              //           showModalBottomSheet(
                              //               context: context,
                              //               elevation: 2,
                              //               constraints: BoxConstraints(
                              //                   maxHeight:
                              //                       screenHeightPercentage(
                              //                           context,
                              //                           percentage: 0.4)),
                              //               enableDrag: true,
                              //               shape: RoundedRectangleBorder(
                              //                 borderRadius:
                              //                     BorderRadius.circular(10.0),
                              //               ),
                              //               builder: (context) {
                              //                 return ViewModelBuilder<
                              //                     ProductDetailsViewModel>.nonReactive(
                              //                   viewModelBuilder: () =>
                              //                       productDetailsViewModel,
                              //                   disposeViewModel: false,
                              //                   builder: (context, model, _) =>
                              //                       UpdateQuantityBottomSheet(
                              //                           product: product),
                              //                 );
                              //               });
                              //         }))
                            ],
                          ))
                    ]),
              );
            }));
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
            GestureDetector(
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xff0095DA),
                    borderRadius: BorderRadius.circular(8)),
                height: screenHeightPercentage(context, percentage: 0.08),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Continue Shopping",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: blockSizeHorizontal(context) * 5),
                    ),
                    SizedBox(
                      width: blockSizeHorizontal(context) * 2,
                    ),
                    SvgPicture.asset(
                      Assets.wareHouseicon,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
