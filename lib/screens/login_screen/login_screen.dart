import 'package:barber_center/helpers/input_formatters.dart';
import 'package:barber_center/helpers/validators.dart';
import 'package:barber_center/main.dart';
import 'package:barber_center/screens/login_screen/login_screen_provider.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_strings.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/large_rounded_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  final KindOfUser kindOfUser;
  const LoginScreen({required this.kindOfUser, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginController>(
      create: (context) => LoginController(),
      child: Consumer<LoginController>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                Strings.signup,
                style: Styles.headLineStyle3,
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20), vertical: AppLayout.getHeight(32)),
                child: Column(
                  children: [
                    Gap(AppLayout.getHeight(10)),
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
                    Form(
                      key: provider.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          //EMAIL
                          TextFormField(
                            controller: provider.email,
                            validator: Validators.emailValidator,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            inputFormatters: TextInputFormatters.denySpaces,
                            decoration: const InputDecoration(
                              hintText: Strings.emailInput,
                            ),
                          ),
                          Gap(AppLayout.getHeight(20)),

                          //PASSWORD
                          TextFormField(
                            controller: provider.password,
                            validator: Validators.passwordValidator,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.visiblePassword,
                            onEditingComplete: () async {
                              await provider.login(kindOfUser);
                            },
                            inputFormatters: TextInputFormatters.denySpaces,
                            obscureText: provider.visiblePassword,
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  provider.obscurePass();
                                },
                                child: const Icon(Icons.remove_red_eye),
                              ),
                              hintText: Strings.passwordInput,
                            ),
                          ),
                          Gap(AppLayout.getHeight(10)),

                          Gap(AppLayout.getHeight(10)),
                          LargeRoundedButton(
                            loading: provider.loading,
                            buttonName: Strings.continueBtn,
                            onTap: () async {
                              await provider.login(kindOfUser);
                            },
                          ),
                          Gap(AppLayout.getHeight(30)),

                          Gap(AppLayout.getHeight(20)),
                          //RICH TEXT
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: Strings.redirectionToSingIn,
                              style: Styles.headLineStyle4.copyWith(fontSize: 18),
                              children: [
                                TextSpan(
                                  text: ' ${Strings.signIn}',
                                  style: Styles.headLineStyle4.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Styles.primaryColor,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Routes.goTo(Routes.createAccountRoute, args: kindOfUser, enableBack: true);
                                    },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
