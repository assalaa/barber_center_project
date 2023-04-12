import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../helpers/input_formatters.dart';
import '../../helpers/validators.dart';
import '../../services/routes.dart';
import '../../utils/app_layout.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_styles.dart';
import '../../widgets/large_rounded_button.dart';
import 'signup_screen_provider.dart';

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
                            controller: provider.emailController,
                            validator: Validators.emailValidator,
                            inputFormatters: TextInputFormatters.denySpaces,
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
                            controller: provider.usernameController,
                            validator: Validators.usernameValidator,
                            inputFormatters: TextInputFormatters.denySpaces,
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
                            controller: provider.passwordController,
                            obscureText: provider.obserText,
                            validator: Validators.passwordValidator,
                            inputFormatters: TextInputFormatters.denySpaces,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    provider.obserText = !provider.obserText;
                                  });
                                },
                                child: const Icon(Icons.remove_red_eye),
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
                            controller: provider.phoneController,
                            validator: Validators.phoneNumberValidator,
                            inputFormatters: TextInputFormatters.denySpaces,
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
                          LargeRoundedButton(
                            buttonName: Strings.continueBtn,
                            buttonColor: Styles.primaryColor,
                            buttonTextColor: Styles.brighttextColor,
                            onTap: () async {
                              await provider.saveUser(context);
                            },
                          ),
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
                                    Routes.goTo(Routes.signupRoute);
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
