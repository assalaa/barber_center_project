import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../helpers/input_formatters.dart';
import '../../helpers/validators.dart';
import '../../utils/app_layout.dart';
import '../../utils/app_strings.dart';
import '../../utils/app_styles.dart';
import '../../widgets/large_rounded_button.dart';
import 'create_account_controller.dart';

class CreateAccountScreen extends StatefulWidget {
  final String kindOfUser;
  const CreateAccountScreen({required this.kindOfUser, Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CreateAccountController>(
      create: (context) => CreateAccountController(),
      child: Consumer<CreateAccountController>(
        builder: (context, provider, _) {
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
                                controller: provider.email,
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
                                  fillColor: Styles.brightTextColor,
                                ),
                              ),
                              Gap(AppLayout.getHeight(10)),
                              //Username
                              TextFormField(
                                controller: provider.name,
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
                                  fillColor: Styles.brightTextColor,
                                ),
                              ),
                              Gap(AppLayout.getHeight(10)),
                              //Paasorwd
                              TextFormField(
                                controller: provider.password,
                                obscureText: provider.visiblePassword,
                                validator: Validators.passwordValidator,
                                inputFormatters: TextInputFormatters.denySpaces,
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        provider.visiblePassword = !provider.visiblePassword;
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
                                  fillColor: Styles.brightTextColor,
                                ),
                              ),
                              Gap(AppLayout.getHeight(10)),
                              //Paasorwd
                              TextFormField(
                                controller: provider.phone,
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
                                  fillColor: Styles.brightTextColor,
                                ),
                              ),
                              Gap(AppLayout.getHeight(10)),
                              LargeRoundedButton(
                                buttonName: Strings.continueBtn,
                                buttonColor: Styles.primaryColor,
                                buttonTextColor: Styles.brightTextColor,
                                onTap: () async {
                                  await provider.saveUser(widget.kindOfUser);
                                },
                              ),
                              Gap(AppLayout.getHeight(30)),

                              Gap(AppLayout.getHeight(20)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
