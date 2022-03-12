// ignore_for_file: sized_box_for_whitespace, use_key_in_widget_constructors, avoid_function_literals_in_foreach_calls

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/models/product.dart';
import 'package:foodadora/ui/cart/cart_viewmodel.dart';
import 'package:foodadora/ui/utilites/screen_sizes.dart';
import 'package:foodadora/ui/widgets/foodadora_button.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:line_icons/line_icons.dart';
import 'package:stacked/stacked.dart';
import 'widgets/cart_text_row.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: blockSizeVertical(context) * 10,
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
              height: blockSizeVertical(context) * 8.5,
            ),
          ),
          elevation: 0,
        ),
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
                return Center(
                  child: Text(
                    "Your Cart is empty",
                    style: GoogleFonts.poppins(
                        fontSize: blockSizeHorizontal(context) * 5,
                        fontWeight: FontWeight.w600),
                  ),
                );
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: blockSizeHorizontal(context) * 5,
                      vertical: blockSizeVertical(context) * 3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Shopping Cart',
                        style: TextStyle(
                            fontSize: blockSizeHorizontal(context) * 8),
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
                      SizedBox(height: blockSizeVertical(context)),
                      Card(
                        color: const Color(0xffF4F4F4),
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
                            label: 'Confirm Order',
                            onPressed: () {},
                            color: const Color(0xff08A8DB),
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
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) {
        viewModel.deleteCartItem(product: product);
        viewModel.resetTotal();
        viewModel.getTotal();
      },
      child: Card(
          elevation: 4,
          margin: EdgeInsets.symmetric(vertical: blockSizeVertical(context)),
          child: Padding(
            padding: EdgeInsets.all(blockSizeHorizontal(context) * 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: blockSizeVertical(context) * 18,
                  width: blockSizeHorizontal(context) * 20,
                  child: Image.network(
                    product.productImages![0],
                    fit: BoxFit.contain,
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
                                fontWeight: FontWeight.w600,
                                fontSize: blockSizeHorizontal(context) * 7)),
                      ),
                    ),
                    SizedBox(
                      height: blockSizeVertical(context),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: blockSizeVertical(context) * 5,
                          width: blockSizeHorizontal(context) * 12,
                          child: RawMaterialButton(
                            onPressed: () {
                              viewModel.decrementQuantity(product: product);
                              viewModel.getTotal();
                            },
                            elevation: 0,
                            fillColor: const Color(0xfff9f9f9),
                            child: Padding(
                              padding:
                                  EdgeInsets.all(blockSizeHorizontal(context)),
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
                          product.quantity.toString(),
                          style: GoogleFonts.poppins(
                              fontSize: blockSizeHorizontal(context) * 5),
                        ),
                        Container(
                          height: blockSizeVertical(context) * 5,
                          width: blockSizeHorizontal(context) * 13,
                          child: RawMaterialButton(
                            onPressed: () {
                              viewModel.incrementQuantity(
                                  product: product, stock: productStock);
                              viewModel.getTotal();
                            },
                            elevation: 0,
                            fillColor: const Color(0xfff9f9f9),
                            child: Padding(
                              padding:
                                  EdgeInsets.all(blockSizeHorizontal(context)),
                              child: Icon(
                                LineIcons.plus,
                                color: const Color(0xffa6a6a6),
                                size: blockSizeHorizontal(context) * 4,
                              ),
                            ),
                            shape: const CircleBorder(),
                          ),
                        ),
                        SizedBox(
                          width: blockSizeHorizontal(context) * 1,
                        ),
                        Container(
                            width: blockSizeHorizontal(context) * 18,
                            child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  "$productStock items left",
                                  style: GoogleFonts.poppins(
                                      fontSize:
                                          blockSizeHorizontal(context) * 14),
                                )))
                      ],
                    ),
                    SizedBox(
                      height: blockSizeVertical(context),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          'https://upload.wikimedia.org/wikipedia/en/thumb/b/b0/Tesco_Logo.svg/800px-Tesco_Logo.svg.png',
                          width: blockSizeHorizontal(context) * 20,
                        ),
                        SizedBox(
                          width: blockSizeHorizontal(context) * 5,
                        ),
                        Text(
                          'RM ${product.originalPrice!.toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(
                            fontSize: blockSizeHorizontal(context) * 5,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          )),
    );
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
