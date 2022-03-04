import 'package:flutter/material.dart';

import 'package:foodadora/app/constants/assets.dart';
import 'package:foodadora/models/product.dart';
import 'package:foodadora/ui/store_details/storeDetails_viewModel.dart';
import 'package:foodadora/ui/utilites/screen_sizes.dart';
import 'package:foodadora/ui/widgets/product_card.dart';
import 'package:foodadora/ui/widgets/store_circle.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import 'package:stacked/stacked.dart';

class StoreDetailsScreen extends StatelessWidget {
  const StoreDetailsScreen({Key? key}) : super(key: key);

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
      body: ViewModelBuilder<StoreDetailsViewModel>.reactive(
        viewModelBuilder: () => StoreDetailsViewModel(),
        builder: (context, model, _) => ListView(
            padding: EdgeInsets.symmetric(
                horizontal: blockSizeHorizontal(context) * 5,
                vertical: blockSizeVertical(context) * 1),
            shrinkWrap: true,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StoreCircle(imageUrl: Assets.mydinimage, onPressed: () {}),
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
                        child: Text("this is the address of the store",
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
                  // childAspectRatio:
                  //     screenWidthPercentage(context, percentage: 0.9) /
                  //         screenHeightPercentage(context),
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                ),
                itemCount: 4,
                itemBuilder: (context, index) => ProductCard(
                  productImageUrl:
                      'https://i.guim.co.uk/img/media/0b456c985e97aefa34b2e90bd8d598b0c15e76c5/0_233_5200_3119/master/5200.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=66dd95318ebe033c904b3f07f784d9b7',
                  storeImageUrl:
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/AEON_logo.svg/1280px-AEON_logo.svg.png',
                  productName: 'Tuna Can',
                  productPrice: 8.2020,
                  originalPrice: 11.909,
                  expiryWeeks: 3,
                  onButtonPressed: () {},
                  onTapped: () {
                    Product product = Product(
                        productName: 'Tuna Can',
                        productImages: [Assets.riceimage],
                        originalPrice: 11.909,
                        description:
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry.Lorem Ipsum is simply dummy text of the printing and typesetting industry");

                    model.navigateToProductDetails(product: product);
                  },
                ),
              )
            ]),
      ),
    );
  }
}
