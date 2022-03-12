import 'package:flutter/material.dart';
import 'package:foodadora/app/app.locator.dart';
import 'package:foodadora/ui/utilites/screen_sizes.dart';
import 'package:foodadora/ui/widgets/foodadora_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked_services/stacked_services.dart';

enum DialogType { addToCart, admin }
void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
    DialogType.addToCart: (context, sheetRequest, completer) =>
        _BasicDialog(request: sheetRequest, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
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
                    fontWeight: FontWeight.bold,
                    fontSize: blockSizeHorizontal(context) * 5),
              ),
              SizedBox(
                height: blockSizeVertical(context) * 4,
              ),
              request.description != null
                  ? Text(
                      request.description.toString(),
                      style: GoogleFonts.poppins(
                          fontSize: blockSizeHorizontal(context) * 4,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.start,
                    )
                  : Container(),
              SizedBox(
                height: blockSizeVertical(context) * 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: screenWidthPercentage(context, percentage: 0.28),
                    child: FoodadoraButton(
                      label: request.mainButtonTitle,
                      onPressed: () {
                        completer(DialogResponse(confirmed: true));
                      },
                      color: const Color(0xFF08A5D2),
                    ),
                  ),
                  SizedBox(
                    width: blockSizeHorizontal(context),
                  ),
                  Container(
                    width: screenWidthPercentage(context, percentage: 0.28),
                    child: FoodadoraButton(
                      label: "Cancel",
                      onPressed: () {
                        completer(DialogResponse(confirmed: false));
                      },
                      color: Colors.white,
                      borderColor: Colors.black,
                      labelColor: Colors.black,
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
