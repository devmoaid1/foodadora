import 'package:flutter/material.dart';
import 'package:foodadora/app/app.locator.dart';
import 'package:foodadora/app/utilites/app_colors.dart';
import 'package:foodadora/app/utilites/screen_sizes.dart';
import 'package:foodadora/ui/widgets/foodadora_button.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:stacked_services/stacked_services.dart';

enum DialogType { addToCart, basic }
void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.addToCart: (context, sheetRequest, completer) =>
        _AddToCartDialog(request: sheetRequest, completer: completer),
    DialogType.basic: (context, sheetRequest, completer) =>
        _BasicDialog(request: sheetRequest, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}

class _AddToCartDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _AddToCartDialog(
      {Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                request.title.toString(),
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: textColor,
                    fontSize: blockSizeHorizontal(context) * 4),
              ),
              SizedBox(
                height: blockSizeVertical(context) * 4,
              ),
              request.description != null
                  ? Text(
                      request.description.toString(),
                      style: GoogleFonts.poppins(
                          color: textColor,
                          fontSize: blockSizeHorizontal(context) * 3,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                    )
                  : Container(),
              SizedBox(
                height: blockSizeVertical(context) * 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      completer(DialogResponse(confirmed: false));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: blockSizeHorizontal(context) * 6),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8)),
                      height: screenHeightPercentage(context, percentage: 0.08),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.poppins(
                              color: textColor,
                              fontWeight: FontWeight.w500,
                              fontSize: blockSizeHorizontal(context) * 4),
                        ),
                      ),
                    ),
                  ),
                  horizontalSpaceRegular,
                  GestureDetector(
                    onTap: () {
                      completer(DialogResponse(confirmed: true));
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: blockSizeHorizontal(context) * 6),
                      decoration: BoxDecoration(
                          color: actionColor,
                          borderRadius: BorderRadius.circular(8)),
                      height: screenHeightPercentage(context, percentage: 0.08),
                      child: Center(
                        child: Text(
                          "Remove",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: blockSizeHorizontal(context) * 4),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}

class _BasicDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(DialogResponse) completer;
  const _BasicDialog({Key? key, required this.request, required this.completer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                request.title.toString(),
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    color: textColor,
                    fontSize: blockSizeHorizontal(context) * 4),
              ),
              SizedBox(
                height: blockSizeVertical(context) * 4,
              ),
              request.description != null
                  ? Text(
                      request.description.toString(),
                      style: GoogleFonts.poppins(
                          color: textColor,
                          fontSize: blockSizeHorizontal(context) * 3,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                    )
                  : Container(),
              SizedBox(
                height: blockSizeVertical(context) * 4,
              ),
              FoodadoraButton(
                  label: request.mainButtonTitle ?? "",
                  onPressed: () {
                    completer(DialogResponse(confirmed: true));
                  })
            ],
          ),
        ));
  }
}
