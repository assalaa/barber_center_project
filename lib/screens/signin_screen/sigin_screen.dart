import 'package:barber_center/screens/signin_screen/signin_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../services/constants.dart';
import '../../utils/app_layout.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_styles.dart';
import '../../widgets/large_rounded_button.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignINScreenProvider>(
      create: (context) => SignINScreenProvider(),
      child: Consumer<SignINScreenProvider>(builder: (context, provider, _) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Styles.backgroundColor,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20), vertical: AppLayout.getHeight(32)),
              child: Center(
                  //HEADER
                  child: Column(
                children: [
                  Gap(AppLayout.getHeight(30)),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    const Icon(Icons.arrow_back_ios),
                    Text(
                      Strings.signup,
                      style: Styles.headLineStyle3,
                    ),
                    const SizedBox(),
                  ]),
                  Gap(AppLayout.getHeight(30)),
                  Text(
                    Strings.welcome2,
                    style: Styles.headLineStyle2.copyWith(fontSize: 30),
                  ),
                  Gap(AppLayout.getHeight(30)),
                  Text(
                    textAlign: TextAlign.center,
                    Strings.welcomeSentence,
                    style: Styles.headLineStyle4.copyWith(fontSize: 18),
                  ),
                  Gap(AppLayout.getHeight(30)),
                  //SIGN UP FORM
                  SingleChildScrollView(
                    child: Form(
                      key: provider.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          //EMAIL
                          TextFormField(
                            validator: (value) {
                              if (value!.length < 6) {
                                return "user name is too short";
                              } else if (value == "") {
                                return "username can't be empty";
                              }
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                borderSide: BorderSide(color: Styles.greyColor),
                              ),
                              hintText: Strings.emailInput,
                              hintStyle: TextStyle(fontSize: 20.0, color: Styles.greyColor),
                              contentPadding: const EdgeInsets.all(18.0),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Styles.brighttextColor,
                            ),
                          ),
                          Gap(AppLayout.getHeight(20)),

                          //Paasorwd
                          TextFormField(
                            obscureText: provider.obserText,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  provider.obscurePass();
                                },
                                child: Icon(Icons.remove_red_eye),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                borderSide: BorderSide(color: Styles.greyColor),
                              ),
                              hintText: Strings.passwordInput,
                              hintStyle: TextStyle(fontSize: 20.0, color: Styles.greyColor),
                              contentPadding: const EdgeInsets.all(18.0),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Styles.brighttextColor,
                            ),
                          ),
                          Gap(AppLayout.getHeight(10)),
                          //Paasorwd

                          Gap(AppLayout.getHeight(10)),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(homeRoute);
                              },
                              child: LargeRoundedButton(buttonName: Strings.continueBtn, buttonColor: Styles.primaryColor, buttonTextColor: Styles.brighttextColor)),
                          Gap(AppLayout.getHeight(30)),

                          Gap(AppLayout.getHeight(20)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(30)),
                            child: Row(
                              children: [
                                Text(
                                  Strings.redirectionToSingIn,
                                  style: Styles.headLineStyle4.copyWith(fontSize: 18),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(signinRoute);
                                  },
                                  // onTap: Routes.goTo(signinRoute),
                                  child: Text(
                                    Strings.signup,
                                    style: Styles.headLineStyle4.copyWith(fontWeight: FontWeight.bold, fontSize: 18, color: Styles.primaryColor),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )),
            ),
          ),
        );
      }),
    );
  }
}
