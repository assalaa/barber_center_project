import 'package:barber_center/helpers/input_formatters.dart';
import 'package:barber_center/helpers/validators.dart';
import 'package:barber_center/main.dart';
import 'package:barber_center/screens/create_account_screen/create_account_controller.dart';
import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_strings.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/large_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class CreateAccountScreen extends StatefulWidget {
  final KindOfUser kindOfUser;
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
            backgroundColor: Styles.backgroundColor,
            appBar: AppBar(
              backgroundColor: Styles.backgroundColor,
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(20), vertical: AppLayout.getHeight(32)),
                child: Center(
                  //HEADER
                  child: Column(
                    children: [
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
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                validator: Validators.emailValidator,
                                inputFormatters: TextInputFormatters.denySpaces,
                                decoration: const InputDecoration(
                                  hintText: Strings.emailInput,
                                ),
                              ),
                              Gap(AppLayout.getHeight(10)),
                              //Username
                              TextFormField(
                                controller: provider.name,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                validator: Validators.usernameValidator,
                                inputFormatters: TextInputFormatters.denySpaces,
                                decoration: const InputDecoration(
                                  hintText: Strings.usernameInput,
                                ),
                              ),
                              Gap(AppLayout.getHeight(10)),
                              //Paasorwd
                              TextFormField(
                                controller: provider.password,
                                keyboardType: TextInputType.visiblePassword,
                                textInputAction: TextInputAction.next,
                                obscureText: provider.visiblePassword,
                                validator: Validators.passwordValidator,
                                inputFormatters: TextInputFormatters.denySpaces,
                                decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      /**
                                       * NEEDS TO BE CHANGED INSIDE THE PROVIDER*/
                                      setState(() {
                                        provider.visiblePassword = !provider.visiblePassword;
                                      });
                                    },
                                    child: const Icon(Icons.remove_red_eye),
                                  ),
                                  hintText: Strings.passwordInput,
                                ),
                              ),
                              Gap(AppLayout.getHeight(10)),

                              //CITY
                              TextFormField(
                                controller: provider.city,
                                keyboardType: TextInputType.streetAddress,
                                textInputAction: TextInputAction.done,
                                onEditingComplete: () async {
                                  await provider.saveUser(widget.kindOfUser);
                                },
                                decoration: const InputDecoration(
                                  hintText: Strings.addressInput,
                                ),
                              ),
                              Gap(AppLayout.getHeight(10)),
                              LargeRoundedButton(
                                loading: provider.loading,
                                buttonName: Strings.continueBtn,
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
