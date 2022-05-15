// ignore_for_file: sized_box_for_whitespace, use_key_in_widget_constructors, avoid_function_literals_in_foreach_calls

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/app/utilites/format_price.dart';
import 'package:foodadora/models/product.dart';
import 'package:foodadora/services/cart_Service.dart';
import 'package:foodadora/ui/cart/cart_viewmodel.dart';

import 'package:foodadora/ui/widgets/empty_indicator.dart';
import 'package:foodadora/ui/widgets/foodadora_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:stacked/stacked.dart';

import '../../app/utilites/app_colors.dart';
import '../../app/utilites/enums.dart';
import '../../app/utilites/screen_sizes.dart';
import '../../services/connectivity_service.dart';
import '../widgets/noconnection_indicator.dart';
import 'widgets/cart_text_row.dart';

// ignore: must_be_immutable
class CartScreen extends StatelessWidget {
  List<Product> orderProducts = [];
  double total = 0;
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

              if (model.isEmpty ||
                  context.watch<CartService>().cartLength == 0) {
                return const EmptyIndicator(widgetType: WidgetType.cart);
              }

              if (!context.watch<ConnectivityService>().isConnected) {
                return const NoConnection();
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
                            horizontal: blockSizeHorizontal(context) * 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Shopping Cart',
                              style: GoogleFonts.poppins(
                                  color: textColor,
                                  fontSize: blockSizeHorizontal(context) * 7),
                            ),
                            Text(
                              model.storeName,
                              style: GoogleFonts.poppins(
                                  color: actionColor,
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

                              orderProducts = List.from(products);

                              return Column(
                                  children: buildCartItems(
                                      products: products, viewModel: model));
                            }
                            return Container();
                          }),
                      verticalSpaceRegular,
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        color: Colors.white,
                        child: Padding(
                          padding:
                              EdgeInsets.all(blockSizeHorizontal(context) * 4),
                          child: StreamBuilder<double>(
                              stream: model.subtotalController,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  total = snapshot.data!.toDouble();
                                  return Column(
                                    children: [
                                      CartTextRow(
                                        title: 'Subtotal:',
                                        price: snapshot.data!.toDouble(),
                                      ),
                                      SizedBox(
                                          height:
                                              blockSizeVertical(context) * 2),
                                      const CartTextRow(
                                        title: 'Taxes:',
                                      ),
                                      SizedBox(
                                          height: blockSizeVertical(context)),
                                      const DottedLine(
                                        dashColor: Color(0xffCFCFCF),
                                      ),
                                      SizedBox(
                                          height: blockSizeVertical(context)),
                                      CartTextRow(
                                        title: 'Total:',
                                        price: snapshot.data!.toDouble(),
                                      ),
                                    ],
                                  );
                                }
                                return Container();
                              }),
                        ),
                      ),
                      verticalSpaceRegular,
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(
                              bottom: blockSizeVertical(context) * 2),
                          width: screenWidth(context),
                          child: FoodadoraButton(
                            label: 'Checkout',
                            color: actionColor,
                            onPressed: () {
                              model.placeOrder(
                                  orderProducts: orderProducts, total: total);
                            },
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
                    product.imageUrl!,
                    fit: BoxFit.contain,
                    loadingBuilder: (context, child, loadingProgress) =>
                        loadingProgress == null
                            ? child
                            : const CircularProgressIndicator.adaptive(),
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
                    formatPrice(product.productPrice),
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
