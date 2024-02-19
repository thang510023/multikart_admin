import 'dart:developer';

import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config.dart';

class LanguageLayout extends StatelessWidget {
  const LanguageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        color: appCtrl.appTheme.whiteColor,
        position: PopupMenuPosition.under,
        tooltip: fonts.showLanguage.tr,
        child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: Insets.i16 * 0.5),
            constraints: const BoxConstraints(minWidth: Sizes.s48),
            child: Row(children: [
              SvgPicture.asset(svgAssets.language,
                  height: Sizes.s25, color: appCtrl.appTheme.blackColor),
              Visibility(
                  visible: (MediaQuery.of(context).size.width > Sizes.s768),
                  child: Padding(
                      padding: const EdgeInsets.only(left: Insets.i16 * 0.5),
                      child: Text(fonts.selectLanguage.tr,
                          style: AppCss.nunitoSemiBold14
                              .textColor(appCtrl.appTheme.blackColor))))
            ])),
        itemBuilder: (context) {
          return [
            ...appArray.actionList
                .asMap()
                .entries
                .map((e) => PopupMenuItem<int>(
                    value: 0,
                    onTap: () {
                      if (e.value['title'] == "english" ||
                          e.value['title'] == 'अंग्रेजी' ||
                          e.value['title'] == 'انجليزي' ||
                          e.value['title'] == '영어') {
                        var locale = const Locale("en", 'US');
                        Get.updateLocale(locale);
                        appCtrl.languageVal = "en";
                        appCtrl.storage.write(session.languageCode, "en");
                        appCtrl.storage.write(session.countryCode, "US");
                      } else if (e.value['title'] == "arabic" ||
                          e.value['title'] == 'अरबी' ||
                          e.value['title'] == 'عربي' ||
                          e.value['title'] == '아랍어') {
                        var locale = const Locale("ar", 'AE');
                        Get.updateLocale(locale);
                        appCtrl.languageVal = "ar";
                        appCtrl.storage.write(session.languageCode, "ar");
                        appCtrl.storage.write(session.countryCode, "AE");
                      } else if (e.value['title'] == "korean" ||
                          e.value['title'] == 'कोरियाई' ||
                          e.value['title'] == 'كوري' ||
                          e.value['title'] == '한국어') {
                        var locale = const Locale("ko", 'KR');
                        Get.updateLocale(locale);

                        appCtrl.languageVal = "ko";
                        appCtrl.storage.write(session.languageCode, "ko");
                        appCtrl.storage.write(session.countryCode, "KR");
                      } else if (e.value['title'] == "hindi" ||
                          e.value['title'] == 'हिंदी' ||
                          e.value['title'] == 'هندي' ||
                          e.value['title'] == '힌디어') {
                        appCtrl.languageVal = "hi";
                        var locale = const Locale("hi", 'IN');
                        Get.updateLocale(locale);
                        appCtrl.storage.write(session.languageCode, "hi");
                        appCtrl.storage.write(session.countryCode, "IN");
                      }
                      appCtrl.update();

                      Get.forceAppUpdate();
                      log("message");
                      Get.back();
                      log("message1");
                    },
                    child: Text(
                      "${e.value["title"].toString().tr} - ${e.value["title"].toString().toUpperCase()}",
                      style: AppCss.nunitoMedium14
                          .textColor(appCtrl.appTheme.blackColor),
                    )))
                .toList(),
          ];
        });
  }
}
