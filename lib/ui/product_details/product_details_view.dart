import 'package:flutter/material.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:foodadora/models/product.dart';
import 'package:foodadora/ui/product_details/product_details_viewmodel.dart';
import 'package:foodadora/ui/utilites/expiryWeeks.dart';
import 'package:foodadora/ui/utilites/screen_sizes.dart';
import 'package:foodadora/ui/widgets/foodadora_button.dart';
import 'package:google_fonts/google_fonts.dart';
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
            viewModelBuilder: () => ProductDetailsViewModel(),
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
                              Container(
                                child: Text("Description",
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                              ),
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
                                        product.quantity = 1;
                                        model.addToCart(product: product);
                                      }))
                            ],
                          ))
                    ]),
              );
            }));
  }
}
