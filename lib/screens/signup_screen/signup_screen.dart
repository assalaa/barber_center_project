import 'package:barber_center/screens/signup_screen/signup_screen_provider.dart';
import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/widgets/large_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../utils/app_assets.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_styles.dart';

class SignUPScreen extends StatefulWidget {
  const SignUPScreen({Key? key}) : super(key: key);

  @override
  State<SignUPScreen> createState() => _SignUPScreenState();
}

class _SignUPScreenState extends State<SignUPScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignUPScreenProvider>(
      create: (context) => SignUPScreenProvider(),
      child: Consumer<SignUPScreenProvider>(builder: (context, provider, _) {
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
                          Gap(AppLayout.getHeight(10)),
                          //Username
                          TextFormField(
                            validator: (value) {
                              if (value == "") {
                                return "Email can't be empty";
                              } else if (!provider.regExp.hasMatch(value!)) {
                                return "Email is invalid";
                              }
                              return "";
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                borderSide: BorderSide(color: Styles.greyColor),
                              ),
                              hintText: Strings.usernameInput,
                              hintStyle: TextStyle(fontSize: 20.0, color: Styles.greyColor),
                              contentPadding: const EdgeInsets.all(18.0),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Styles.brighttextColor,
                            ),
                          ),
                          Gap(AppLayout.getHeight(10)),
                          //Paasorwd
                          TextFormField(
                            obscureText: provider.obserText,
                            validator: (value) {
                              if (value == "") {
                                return "Password can't be empty!";
                              } else if (value!.length < 6) {
                                "Password too short";
                              }
                              return "";
                            },
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    provider.obserText = !provider.obserText;
                                  });
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
                          TextFormField(
                            validator: (value) {
                              if (value == "") {
                                return "Phone can't be empty!";
                              } else if (value!.length < 11) {
                                "Invalid phone number";
                              }
                              return "";
                            },
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                borderSide: BorderSide(color: Styles.greyColor),
                              ),
                              hintText: Strings.addressInput,
                              hintStyle: TextStyle(fontSize: 20.0, color: Styles.greyColor),
                              contentPadding: const EdgeInsets.all(18.0),
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Styles.brighttextColor,
                            ),
                          ),
                          Gap(AppLayout.getHeight(10)),
                          GestureDetector(
                              onTap: () {
                                provider.save();
                                // Navigator.of(context).pushNamed(homeRoute);
                              },
                              child: LargeRoundedButton(buttonName: Strings.continueBtn, buttonColor: Styles.primaryColor, buttonTextColor: Styles.brighttextColor)),
                          Gap(AppLayout.getHeight(30)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(120)),
                            child: Row(
                              children: [
                                Container(
                                  width: AppLayout.getHeight(40),
                                  height: AppLayout.getWidth(40),
                                  decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image: Svg(
                                          Assets.gmailIcon,
                                        ),
                                      ),
                                      color: Styles.greyColor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                                Gap(AppLayout.getWidth(30)),
                                Container(
                                  width: AppLayout.getHeight(40),
                                  height: AppLayout.getWidth(40),
                                  decoration: BoxDecoration(
                                      image: const DecorationImage(
                                        image: Svg(
                                          Assets.facebookIcon,
                                        ),
                                      ),
                                      color: Styles.greyColor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                              ],
                            ),
                          ),
                          Gap(AppLayout.getHeight(20)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(30)),
                            child: Row(
                              children: [
                                Text(
                                  Strings.redirectionToSingIn,
                                  style: Styles.headLineStyle4.copyWith(fontSize: 18),
                                ),
                                Text(
                                  Strings.signup,
                                  style: Styles.headLineStyle4.copyWith(fontWeight: FontWeight.bold, fontSize: 18, color: Styles.primaryColor),
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
