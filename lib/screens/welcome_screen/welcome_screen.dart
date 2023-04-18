import 'package:barber_center/main.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/app_assets.dart';
import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/large_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            height: Get.height,
            fit: BoxFit.cover,
            Assets.welcomeBg,
          ),
          Container(
            width: AppLayout.getScreenWidth(),
            height: AppLayout.getScreenHeight(),
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.7)),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(18), vertical: AppLayout.getHeight(31)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.language,
                        style: Styles.textStyle,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: AppLayout.getHeight(50)),
                    child: Column(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.welcome,
                          style: Styles.headLineStyle1.copyWith(color: Styles.brightTextColor),
                        ),
                        Gap(AppLayout.getHeight(5)),
                        Text(
                          textAlign: TextAlign.center,
                          AppLocalizations.of(context)!.thanking,
                          style: Styles.headLineStyle4,
                        ),
                        Gap(AppLayout.getHeight(50)),
                        Text(
                          AppLocalizations.of(context)!.proceed,
                          style: Styles.headLineStyle1.copyWith(color: Styles.brightTextColor),
                        ),
                        Gap(AppLayout.getHeight(20)),
                        //BUTTONS START HERE
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            LargeRoundedButton(
                              buttonName: AppLocalizations.of(context)!.salon,
                              onTap: () => Routes.goTo(Routes.loginRoute, args: KindOfUser.SALON, enableBack: true),
                            ),
                            Gap(AppLayout.getHeight(12)),
                            LargeRoundedButton(
                              buttonName: AppLocalizations.of(context)!.customer,
                              buttonColor: Styles.brightTextColor,
                              buttonTextColor: Styles.primaryColor,
                              onTap: () => Routes.goTo(Routes.loginRoute, args: KindOfUser.CUSTOMER, enableBack: true),
                            ),
                            Gap(AppLayout.getHeight(12)),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
