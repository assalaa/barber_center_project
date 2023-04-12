import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../services/routes.dart';
import '../../utils/app_assets.dart';
import '../../utils/app_layout.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_styles.dart';
import '../../widgets/large_rounded_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Fix: Remove Stack
      body: Stack(
        children: [
          Column(
            children: [
              Image.asset(
                  height: Get.height, fit: BoxFit.cover, Assets.welcomeBg)
            ],
          ),
          Container(
            width: AppLayout.getScreenWidth(),
            height: AppLayout.getScreenHeight(),
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.7)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppLayout.getWidth(18),
                vertical: AppLayout.getHeight(31)),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Strings.skipBtn,
                      style: Styles.textStyle,
                    ),
                    Text(
                      Strings.adminBtn,
                      style: Styles.textStyle,
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: AppLayout.getHeight(50)),
                  child: Column(
                    children: [
                      Text(
                        Strings.welcome,
                        style: Styles.headLineStyle1
                            .copyWith(color: Styles.brighttextColor),
                      ),
                      Gap(AppLayout.getHeight(5)),
                      Text(
                        textAlign: TextAlign.center,
                        Strings.welcomeSentence,
                        style: Styles.headLineStyle4,
                      ),
                      Gap(AppLayout.getHeight(50)),
                      Text(
                        Strings.proceed,
                        style: Styles.headLineStyle1
                            .copyWith(color: Styles.brighttextColor),
                      ),
                      Gap(AppLayout.getHeight(20)),
                      //BUTTONS START HERE
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          LargeRoundedButton(
                              buttonName: Strings.salonBtn,
                              buttonColor: Styles.primaryColor,
                              buttonTextColor: Styles.brighttextColor,
                              onTap: () => Routes.goTo(Routes.signinRoute)),
                          Gap(AppLayout.getHeight(12)),
                          LargeRoundedButton(
                              buttonName: Strings.customerBtn,
                              buttonColor: Styles.brighttextColor,
                              buttonTextColor: Styles.primaryColor,
                              onTap: () => Routes.goTo(Routes.signupRoute)),
                          Gap(AppLayout.getHeight(12)),
                          LargeRoundedButton(
                              buttonName: Strings.barberBtn,
                              buttonColor: Styles.primaryColor,
                              buttonTextColor: Styles.brighttextColor,
                              onTap: () => Routes.goTo(Routes.signinRoute)),
                          GestureDetector(
                            onTap: () {
                              Routes.goTo(Routes.signupRoute);
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              color: Colors.red,
                            ),
                          )
                          /*LargeRoundedButton(
                            buttonName: Strings.salonBtn,
                            buttonColor: Styles.primaryColor,
                            buttonTextColor: Styles.brighttextColor,
                            onPressed: () {
                              Navigator.of(context).pushNamed('/signup');
                            },
                          ),
                          Gap(AppLayout.getHeight(12)),
                          LargeRoundedButton(
                            buttonName: Strings.customerBtn,
                            buttonColor: Styles.brighttextColor,
                            buttonTextColor: Styles.primaryColor,
                            onPressed: () {
                              Navigator.of(context).pushNamed('/signup');
                            },
                          ),
                          Gap(AppLayout.getHeight(12)),
                          LargeRoundedButton(
                            buttonName: Strings.barberBtn,
                            buttonColor: Styles.primaryColor,
                            buttonTextColor: Styles.brighttextColor,
                            onPressed: () {
                              Navigator.of(context).pushNamed('/signup');
                            },
                          ),*/
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
