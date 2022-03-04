import 'package:flutter/material.dart';
import 'package:foodadora/ui/home/home_viewModel.dart';
import 'package:foodadora/ui/home/widgets/foodadora_carousel.dart';
import 'package:foodadora/ui/home/widgets/home_row.dart';
import 'package:foodadora/ui/home/widgets/product_item.dart';
import 'package:foodadora/ui/utilites/size_config.dart';
import 'package:foodadora/ui/widgets/store_circle.dart';
import 'package:stacked/stacked.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<HomeViewModel>.nonReactive(
      viewModelBuilder: () => HomeViewModel(),
      // onModelReady: (model) => model.logout(),
      builder: (context, model, _) => Scaffold(
          body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.blockSizeHorizontal * 5,
              vertical: SizeConfig.blockSizeVertical * 2,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, Yasser Ehab',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: SizeConfig.blockSizeHorizontal * 6.5,
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(height: SizeConfig.blockSizeVertical),
                const FoodadoraCarousel(imagePaths: [
                  'assets/images/banner1.png',
                  'assets/images/banner2.png',
                  'assets/images/banner1.png',
                  'assets/images/banner2.png',
                ]),
                HomeRow(
                  titleLabel: 'Nearby Stores',
                  buttonLabel: 'See all',
                  buttonOnPressed: () {},
                ),
                SizedBox(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.blockSizeVertical * 20,
                  child: ListView.separated(
                    clipBehavior: Clip.none,
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => StoreCircle(
                      imageUrl:
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/AEON_logo.svg/1280px-AEON_logo.svg.png',
                      onPressed: () {},
                    ),
                    separatorBuilder: (context, index) =>
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
                  ),
                ),
                HomeRow(
                  titleLabel: 'Recent items',
                  buttonLabel: 'See all',
                  buttonOnPressed: () {},
                ),
                Container(
                  width: SizeConfig.screenWidth * 0.9,
                  height: SizeConfig.blockSizeVertical * 41,
                  margin: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 2,
                  ),
                  child: ListView.separated(
                    clipBehavior: Clip.none,
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => ProductItem(
                      productImageUrl:
                          'https://i.guim.co.uk/img/media/0b456c985e97aefa34b2e90bd8d598b0c15e76c5/0_233_5200_3119/master/5200.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=66dd95318ebe033c904b3f07f784d9b7',
                      storeImageUrl:
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/AEON_logo.svg/1280px-AEON_logo.svg.png',
                      productName: 'Tuna Can',
                      productPrice: 8.2020,
                      originalPrice: 11.909,
                      expiryWeeks: 3,
                      onButtonPressed: () {},
                      onTapped: () {},
                    ),
                    separatorBuilder: (context, index) =>
                        SizedBox(width: SizeConfig.blockSizeHorizontal * 4),
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
