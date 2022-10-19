// ignore_for_file: file_names

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:foodadora/app/constants/assets.dart';

class FoodadoraNetworkImage extends StatelessWidget {
  final String imagePath;
  final BoxFit? fit;

  const FoodadoraNetworkImage(
      {required super.key, required this.imagePath, this.fit = BoxFit.contain});

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(imagePath,
        key: key,
        cache: true,
        fit: fit,
        printError: true, loadStateChanged: (ExtendedImageState state) {
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );

        case LoadState.completed:
          return ExtendedRawImage(
            image: state.extendedImageInfo?.image,
            fit: fit,
          );

        case LoadState.failed:
          return Image.asset(Assets.foodadoraPlaceHolder, fit: fit);
        default:
          return state.completedWidget;
      }
    });
  }
}
