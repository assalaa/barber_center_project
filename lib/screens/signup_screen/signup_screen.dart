import 'package:barber_center/database/db_auth.dart';
import 'package:barber_center/screens/signup_screen/signup_screen_provider.dart';
import 'package:barber_center/services/constants.dart';
import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_strings.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/large_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SignUPScreen extends StatefulWidget {
  const SignUPScreen({Key? key}) : super(key: key);

  @override
  State<SignUPScreen> createState() => _SignUPScreenState();
}

class _SignUPScreenState extends State<SignUPScreen> {
  late String _email, _password;
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
                            onChanged: (value) {
                              setState(() {
                                _email = value.trim();
                              });
                            },
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
                            onChanged: (value) {
                              setState(() {
                                _password = value.trim();
                              });
                            },
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
                                DBAuth.signup(context, _email, _password);
                                //provider.signup(context, provider.passwordController.text, provider.emailController.text);
                                // provider.save();
                                // Navigator.of(context).pushNamed(homeRoute);
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
                                    Strings.signIn,
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
