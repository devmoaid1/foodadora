import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:foodadora/app/utilites/app_colors.dart';
import 'package:foodadora/app/utilites/get_distance.dart';
import 'package:foodadora/app/utilites/screen_sizes.dart';
import 'package:foodadora/models/store.dart';
import 'package:foodadora/app/utilites/string_extension.dart';
import 'package:foodadora/ui/stores/stores_viewmodel.dart';
import 'package:foodadora/ui/widgets/pressable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

class StoreItem extends ViewModelWidget<StoresViewModel> {
  final Store store;

  const StoreItem({
    Key? key,
    required this.store,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, StoresViewModel viewModel) {
    String distance = store.pos?["geopoint"] != null
        ? " " +
            getDistance((store.pos?["geopoint"] as GeoPoint)).toString() +
            " Away"
        : "-";
    return Material(
      elevation: .5,
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      child: Pressable(
        borderRadius: BorderRadius.circular(10),
        onPressed: () =>
            viewModel.navigateToStoreDetails(store: store, distance: distance),
        child: Padding(
          padding: EdgeInsets.all(blockSizeVertical(context) * 1.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (store.imageUrl != null)
                SizedBox(
                  width: blockSizeHorizontal(context) * 120,
                  height: blockSizeVertical(context) * 12,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      store.imageUrl!,
                      loadingBuilder: (context, child, loadingProgress) =>
                          loadingProgress == null
                              ? child
                              : const CircularProgressIndicator.adaptive(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              verticalSpaceSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    constraints: BoxConstraints(
                        minWidth: blockSizeHorizontal(context) * 15,
                        maxWidth: blockSizeHorizontal(context) * 25),
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        " ${store.storeName?.toUpperCase() ?? ""}",
                        style: GoogleFonts.poppins(
                            color: textColor,
                            fontSize: blockSizeHorizontal(context) * 5.5),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Assets.pinLocationIcon,
                              width: blockSizeHorizontal(context) * 4,
                              color: textColor,
                            ),
                            Text(
                              distance,
                              style: GoogleFonts.poppins(
                                  color: textColor,
                                  fontSize: blockSizeHorizontal(context) * 3),
                            ),
                          ],
                        ),
                      ),
                      horizontalSpaceSmall,
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          store.category?.capitalize() ?? "",
                          style: GoogleFonts.poppins(
                              color: textColor,
                              fontSize: blockSizeHorizontal(context) * 3),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
