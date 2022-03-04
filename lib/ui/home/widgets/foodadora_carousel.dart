import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart' as dotsIndicator;
import 'package:flutter/material.dart';
import 'package:foodadora/ui/utilites/size_config.dart';

class FoodadoraCarousel extends StatefulWidget {
  final List<String> imagePaths;
  const FoodadoraCarousel({
    required this.imagePaths,
  });

  @override
  _FoodadoraCarouselState createState() => _FoodadoraCarouselState();
}

class _FoodadoraCarouselState extends State<FoodadoraCarousel> {
  int carouselIndex = 0;
  @override
  Widget build(BuildContext context) {
    CarouselController _controller = CarouselController();
    return Column(
      children: [
        Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(SizeConfig.blockSizeHorizontal * 3))),
          child: CarouselSlider(
            items: widget.imagePaths
                .map((imagePath) => Image.asset(imagePath))
                .toList(),
            options: CarouselOptions(
              autoPlay: true,
              viewportFraction: 1,
              onPageChanged: (index, reason) =>
                  setState(() => carouselIndex = index),
            ),
            carouselController: _controller,
          ),
        ),
        dotsIndicator.DotsIndicator(
          dotsCount: widget.imagePaths.length,
          decorator: dotsIndicator.DotsDecorator(
            activeColor: Theme.of(context).primaryColor,
            size: Size(SizeConfig.blockSizeHorizontal * 2.5,
                SizeConfig.blockSizeHorizontal * 2.5),
            activeSize: Size(SizeConfig.blockSizeHorizontal * 3,
                SizeConfig.blockSizeHorizontal * 3),
          ),
          position: carouselIndex.toDouble(),
        )
      ],
    );
  }
}
