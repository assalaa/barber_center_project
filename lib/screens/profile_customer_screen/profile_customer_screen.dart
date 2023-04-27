import 'package:barber_center/screens/profile_customer_screen/profile_customer_provider.dart';
import 'package:barber_center/widgets/profile/full_name.dart';
import 'package:barber_center/widgets/profile/logout_button.dart';
import 'package:barber_center/widgets/profile/profile_picture.dart';
import 'package:barber_center/widgets/profile_setting_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../models/language.dart';
import '../../services/language_constants.dart';
import '../../utils/app_styles.dart';

class ProfileCustomerScreen extends StatelessWidget {
  const ProfileCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileCustomerProvider>(
      create: (context) => ProfileCustomerProvider(),
      child: Consumer<ProfileCustomerProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 0,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            body: (() {
              if (provider.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LogoutButton(onPressed: provider.logout),
                            DropdownButton(
                                hint: Text(
                                  AppLocalizations.of(context)!.change_language,
                                  style: TextStyle(color: Styles.primaryColor),
                                ),
                                items: Language.languageList()
                                    .map<DropdownMenuItem<Language>>(
                                      (e) => DropdownMenuItem<Language>(
                                        value: e,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            Text(
                                              e.flag,
                                              style: const TextStyle(fontSize: 30),
                                            ),
                                            Text(e.name)
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList(),
                                onChanged: (
                                  Language? language,
                                ) async {
                                  if (language != null) {
                                    Locale _locale = await setLocale(language.languageCode);
                                    MyApp.setLocale(context, _locale);
                                  }
                                }),
                          ],
                        ),
                        const SizedBox(height: 32),
                        ProfilePicture(
                          image: provider.userModel.image,
                          updatePhoto: provider.updatePhoto,
                        ),
                        const SizedBox(height: 22),
                        FullName(userName: provider.userModel.name),
                        const SizedBox(height: 60),
                        const SettingButtons(),
                      ],
                    ),
                  ),
                ],
              );
            }()),
          );
        },
      ),
    );
  }
}

class SettingButtons extends StatelessWidget {
  const SettingButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const IconData privacyIcon = Icons.privacy_tip_outlined;

    const IconData bookingHistoryIcon = Icons.history_toggle_off_rounded;

    return Column(
      children: [
        ProfileSettingButton(
          icon: privacyIcon,
          text: AppLocalizations.of(context)!.settings,
          onTap: () {},
        ),
        ProfileSettingButton(
          icon: bookingHistoryIcon,
          text: AppLocalizations.of(context)!.booking_history,
          onTap: () {},
        ),
      ],
    );
  }
}
