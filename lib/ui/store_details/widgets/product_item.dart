import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:foodadora/app/utilites/app_colors.dart';
import 'package:foodadora/app/utilites/screen_sizes.dart';

import 'package:foodadora/models/product.dart';
import 'package:foodadora/ui/widgets/pressable.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final Function() onPressed;
  const ProductItem({
    Key? key,
    required this.product,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: .5,
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: Pressable(
        borderRadius: BorderRadius.circular(10),
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.all(blockSizeVertical(context) * 1.5),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              width: blockSizeHorizontal(context) * 90,
              height: blockSizeVertical(context) * 12,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
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
            verticalSpaceRegular,
            Row(
              children: [
                SvgPicture.asset(
                  Assets.priceIcon,
                  width: blockSizeVertical(context) * 2.5,
                ),
                horizontalSpaceSmall,
                Text(
                  "RM ${product.productPrice}",
                  style: GoogleFonts.poppins(
                      fontSize: blockSizeVertical(context) * 2,
                      color: textColor,
                      fontWeight: FontWeight.w500),
                ),
                horizontalSpaceSmall,
                if (product.originalPrice != null)
                  Text(
                    "RM ${product.originalPrice}",
                    style: GoogleFonts.poppins(
                        fontSize: blockSizeVertical(context) * 1.5,
                        color: textColor,
                        decoration: TextDecoration.lineThrough),
                  ),
              ],
            ),
            verticalSpaceSmall,
            Text(
              product.productName!,
              style: GoogleFonts.poppins(
                fontSize: blockSizeVertical(context) * 2,
                color: textColor,
              ),
              overflow: TextOverflow.fade,
            ),
          ]),
        ),
      ),
    );
  }
}
