// ignore_for_file: sized_box_for_whitespace, use_key_in_widget_constructors, avoid_function_literals_in_foreach_calls

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/product.dart';
import 'package:foodadora/ui/cart/cart_viewmodel.dart';

import 'package:foodadora/ui/widgets/empty_indicator.dart';
import 'package:foodadora/ui/widgets/foodadora_button.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:stacked/stacked.dart';

import '../../app/utilites/app_colors.dart';
import '../../app/utilites/enums.dart';
import '../../app/utilites/screen_sizes.dart';
import 'widgets/cart_text_row.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ViewModelBuilder<CartViewModel>.reactive(
            disposeViewModel: false,
            fireOnModelReadyOnce: false,
            onModelReady: (model) => model.fetchCartItems(),
            viewModelBuilder: () => cartViewModel,
            builder: (context, model, _) {
              if (model.loading) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }

              if (model.isEmpty) {
                return const EmptyIndicator(widgetType: WidgetType.cart);
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: blockSizeHorizontal(context) * 1,
                      vertical: blockSizeVertical(context) * 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: blockSizeHorizontal(context) * 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Shopping Cart',
                              style: GoogleFonts.poppins(
                                  fontSize: blockSizeHorizontal(context) * 7),
                            ),
                            Text(
                              'Tesco Store',
                              style: GoogleFonts.poppins(
                                  color: lightBlueColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: blockSizeHorizontal(context) * 4),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: blockSizeVertical(context) * 2),
                      StreamBuilder<List<Product>>(
                          stream: model.items,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var products = snapshot.data as List<Product>;

                              return Column(
                                  children: buildCartItems(
                                      products: products, viewModel: model));
                            }
                            return Container();
                          }),
                      SizedBox(height: blockSizeVertical(context) * 5),
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: Colors.white,
                        child: Padding(
                          padding:
                              EdgeInsets.all(blockSizeHorizontal(context) * 4),
                          child: Column(
                            children: [
                              CartTextRow(
                                title: 'Subtotal:',
                                price: model.total,
                              ),
                              SizedBox(height: blockSizeVertical(context) * 2),
                              const CartTextRow(
                                title: 'Taxes:',
                              ),
                              SizedBox(height: blockSizeVertical(context)),
                              const DottedLine(
                                dashColor: Color(0xffCFCFCF),
                              ),
                              SizedBox(height: blockSizeVertical(context)),
                              CartTextRow(
                                title: 'Total:',
                                price: model.total,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: blockSizeVertical(context) * 2),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: blockSizeVertical(context) * 2),
                          width: screenWidth(context),
                          child: FoodadoraButton(
                            label: 'Confirm',
                            onPressed: () {},
                            color: lightBlueColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}

class CartItem extends ViewModelWidget<CartViewModel> {
  final Product product;
  final int productStock;
  const CartItem({Key? key, required this.product, this.productStock = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context, CartViewModel viewModel) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 3,
        margin: EdgeInsets.symmetric(vertical: blockSizeVertical(context)),
        child: Padding(
          padding: EdgeInsets.all(blockSizeHorizontal(context) * 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: blockSizeVertical(context) * 15,
                width: blockSizeHorizontal(context) * 28,
                child: Center(
                  child: Image.network(
                    product.productImages![0],
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: blockSizeHorizontal(context) * 45),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(product.productName.toString(),
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w400,
                              fontSize: blockSizeHorizontal(context) * 5)),
                    ),
                  ),
                  Text(
                    '${product.productPrice!.toStringAsFixed(2)} RM',
                    style: GoogleFonts.poppins(
                      fontSize: blockSizeHorizontal(context) * 5,
                    ),
                  ),
                  SizedBox(
                    height: blockSizeVertical(context) * 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: screenWidthPercentage(context, percentage: 0.2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            product.quantity == 1
                                ? GestureDetector(
                                    onTap: () {
                                      viewModel.deleteCartItem(
                                          product: product);
                                    },
                                    child: SvgPicture.asset(Assets.trashIcon))
                                : GestureDetector(
                                    onTap: () {
                                      viewModel.decrementQuantity(
                                          product: product);
                                      viewModel.getTotal();
                                    },
                                    child: SvgPicture.asset(Assets.minusicon)),
                            Text(
                              product.quantity.toString(),
                              style: GoogleFonts.poppins(
                                  fontSize: blockSizeHorizontal(context) * 5),
                            ),
                            GestureDetector(
                                onTap: () {
                                  viewModel.incrementQuantity(
                                      product: product, stock: productStock);
                                  viewModel.getTotal();
                                },
                                child: SvgPicture.asset(Assets.plusicon)),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: blockSizeHorizontal(context) * 5,
                      ),
                      Container(
                          width: blockSizeHorizontal(context) * 20,
                          child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                "$productStock items left",
                                style: GoogleFonts.poppins(
                                    fontSize:
                                        blockSizeHorizontal(context) * 18),
                              )))
                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}

List<Widget> buildCartItems(
    {required List<Product> products, required CartViewModel viewModel}) {
  List<Widget> cartCards = [];

  cartCards.clear();
  viewModel.originalProducts.forEach((originalProduct) {
    products.forEach((element) {
      if (originalProduct.productId == element.productId) {
        cartCards.add(CartItem(
          product: element,
          productStock: originalProduct.quantity as int,
        ));
      }
    });
  });

  return cartCards;
}
