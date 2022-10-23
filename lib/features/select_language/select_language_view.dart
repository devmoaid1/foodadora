// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:foodadora/app/utilites/app_colors.dart';
import 'package:foodadora/app/utilites/screen_sizes.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../../core/widgets/foodadora_app_bar.dart';
import '../../core/widgets/pressable.dart';
import 'select_language_viewmodel.dart';

class SelectLanguageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocalizationDelegate localizationDelegate =
        LocalizedApp.of(context).delegate;

    List<Locale> supportedLocales = localizationDelegate.supportedLocales;
    return Scaffold(
      appBar: const FoodadoraAppBar(isWithBack: true),
      body: ViewModelBuilder<SelectLanguageViewModel>.nonReactive(
        fireOnModelReadyOnce: true,
        viewModelBuilder: () => SelectLanguageViewModel(),
        builder: (context, model, child) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: blockSizeHorizontal(context) * 5,
                vertical: blockSizeVertical(context) * 4),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                translate("select_language"),
                style: GoogleFonts.poppins(
                    fontSize: blockSizeHorizontal(context) * 6,
                    color: textColor),
              ),
              verticalSpaceRegular,
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(
                      vertical: blockSizeVertical(context) / 3),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: supportedLocales.length,
                  itemBuilder: ((context, index) => Pressable(
                        onPressed: supportedLocales[index].languageCode ==
                                localizationDelegate.currentLocale.languageCode
                            ? null
                            : () async {
                                await changeLocale(context,
                                    supportedLocales[index].languageCode);
                                model.changeLocale();
                              },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: blockSizeHorizontal(context) * 5,
                              vertical: blockSizeVertical(context) * 2),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                model.getLanguageName(
                                    supportedLocales[index].languageCode),
                                style: GoogleFonts.poppins(
                                    color: textColor,
                                    fontSize:
                                        blockSizeHorizontal(context) * 4.5),
                              ),
                              if (supportedLocales[index].languageCode ==
                                  localizationDelegate
                                      .currentLocale.languageCode)
                                const Icon(
                                  Icons.check,
                                  color: activeColor,
                                )
                            ],
                          ),
                        ),
                      )),
                  separatorBuilder: (context, _) => const Divider(
                    color: dividerColor,
                    indent: 20,
                    endIndent: 20,
                  ),
                ),
              )
            ]),
          );
        },
      ),
    );
  }
}
