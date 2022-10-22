import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:foodadora/app/constants/assets.dart';
import 'package:foodadora/app/constants/services_instances.dart';
import 'package:foodadora/app/constants/version.dart';
import 'package:foodadora/app/utilites/app_colors.dart';
import 'package:foodadora/app/utilites/screen_sizes.dart';
import 'package:foodadora/core/providers/user/user_service_provider.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../../core/widgets/foodadora_button.dart';
import '../../../select_language/language_code_name_map.dart';
import '../viewmodels/settings_viewmodel.dart';
import '../widgets/settings_row.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingsViewModel>.reactive(
        viewModelBuilder: () => settingsViewModel,
        disposeViewModel: false,
        builder: (context, model, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  context.watch<UserServiceProvider>().isLoggedOn
                      ? SettingsRow(
                          iconPath: Assets.usericon,
                          actionTitle: translate("settings.view_profile"),
                          title: model.customerProfile!.name.toString(),
                          onPressed: model.navigateToProfile,
                        )
                      : FoodadoraButton(
                          label: "Login / Signup",
                          onPressed: model.navigateToAuth,
                          color: actionColor,
                        ),
                  verticalSpaceRegular,
                  FittedBox(
                    child: Text(
                      translate("settings.app_settings"),
                      style: GoogleFonts.poppins(
                          color: textColor,
                          fontSize: screenWidth(context) * 0.04),
                    ),
                  ),
                  verticalSpaceRegular,
                  SettingsRow(
                      iconPath: Assets.languageIcon,
                      onPressed: model.navigateToLanguage,
                      title: translate("settings.language"),
                      subTitle: languageCodeNameMap[LocalizedApp.of(context)
                          .delegate
                          .currentLocale
                          .languageCode],
                      actionTitle: translate("settings.change")),
                ],
              ),
              Text(
                "Version $appVersion",
                style: GoogleFonts.raleway(color: lightTextColor),
              )
            ],
          );
        });
  }
}