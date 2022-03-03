import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:foodadora/ui/utilites/screen_sizes.dart';
import 'package:foodadora/ui/widgets/foodadora_button.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:line_icons/line_icons.dart';
import 'widgets/cart_text_row.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: blockSizeHorizontal(context) * 5,
            vertical: blockSizeVertical(context) * 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shopping Cart',
              style: TextStyle(fontSize: blockSizeHorizontal(context) * 8),
            ),
            SizedBox(height: blockSizeVertical(context) * 2),
            const CartItem(),
            const CartItem(),
            const CartItem(),
            const CartItem(),
            SizedBox(height: blockSizeVertical(context)),
            Card(
              color: const Color(0xffF4F4F4),
              child: Padding(
                padding: EdgeInsets.all(blockSizeHorizontal(context) * 4),
                child: Column(
                  children: [
                    const CartTextRow(
                      title: 'Subtotal:',
                      price: 100.2,
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
                    const CartTextRow(
                      title: 'Total:',
                      price: 100.3,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: blockSizeVertical(context) * 2),
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: blockSizeVertical(context) * 2),
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
    ));
  }
}

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: blockSizeVertical(context)),
        child: Padding(
          padding: EdgeInsets.all(blockSizeHorizontal(context) * 3),
          child: Row(
            children: [
              Container(
                height: blockSizeVertical(context) * 15,
                width: blockSizeHorizontal(context) * 25,
                child: Image.network(
                  'https://digitalcontent.api.tesco.com/v2/media/ghs/6dcf4456-8882-4919-93fa-870340498754/snapshotimagehandler_155907538.jpeg?h=540&w=540',
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
                      child: Text('Basmati Rice With Bachamel',
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: blockSizeHorizontal(context) * 7)),
                    ),
                  ),
                  Row(
                    children: [
                      RawMaterialButton(
                        onPressed: () {},
                        elevation: 0,
                        fillColor: const Color(0xfff9f9f9),
                        child: Padding(
                          padding: EdgeInsets.all(blockSizeHorizontal(context)),
                          child: Icon(
                            LineIcons.minus,
                            color: const Color(0xffa6a6a6),
                            size: blockSizeHorizontal(context) * 6,
                          ),
                        ),
                        shape: const CircleBorder(),
                      ),
                      Text(
                        '1',
                        style: GoogleFonts.poppins(
                            fontSize: blockSizeHorizontal(context) * 5),
                      ),
                      RawMaterialButton(
                        onPressed: () {},
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
                        shape: CircleBorder(),
                      ),
                    ],
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
                        'RM 11.00',
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
        ));
  }
}
