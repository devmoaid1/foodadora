// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:foodadora/app/utilites/app_colors.dart';
import 'package:foodadora/app/utilites/screen_sizes.dart';
import 'package:foodadora/ui/select_language/select_language_viewmodel.dart';
import 'package:foodadora/ui/widgets/foodadora_app_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

class SelectLanguageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LocalizationDelegate localizationDelegate =
        LocalizedApp.of(context).delegate;

    List<Locale> supportedLocales = localizationDelegate.supportedLocales;
    return Scaffold(
      appBar: foodadoraAppBar(context, withBack: true),
      body: ViewModelBuilder<SelectLanguageViewModel>.nonReactive(
        fireOnModelReadyOnce: true,
        viewModelBuilder: () => SelectLanguageViewModel(),
        builder: (context, model, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: blockSizeHorizontal(context) * 5,
                  vertical: blockSizeVertical(context) * 4),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                      child: SizedBox(
                        height: blockSizeVertical(context) *
                            9 *
                            supportedLocales.length,
                        child: ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: supportedLocales.length,
                          itemBuilder: ((context, index) => Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: blockSizeVertical(context) / 3),
                                child: ListTile(
                                  tileColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  onTap: supportedLocales[index].languageCode ==
                                          localizationDelegate
                                              .currentLocale.languageCode
                                      ? null
                                      : () async {
                                          await changeLocale(
                                              context,
                                              supportedLocales[index]
                                                  .languageCode);
                                          model.changeLocale();
                                        },
                                  title: Text(
                                      model.getLanguageName(
                                          supportedLocales[index].languageCode),
                                      style: GoogleFonts.poppins(
                                          color: textColor)),
                                  trailing:
                                      supportedLocales[index].languageCode ==
                                              localizationDelegate
                                                  .currentLocale.languageCode
                                          ? const Icon(
                                              Icons.check,
                                              color: activeColor,
                                            )
                                          : null,
                                ),
                              )),
                          separatorBuilder: (context, _) => const Divider(
                            color: dividerColor,
                            indent: 20,
                            endIndent: 20,
                          ),
                        ),
                      ),
                    )
                  ]),
            ),
          );
        },
      ),
    );
  }
}
