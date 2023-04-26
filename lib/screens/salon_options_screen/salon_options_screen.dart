import 'package:barber_center/helpers/extensions.dart';
import 'package:barber_center/helpers/validators.dart';
import 'package:barber_center/screens/salon_options_screen/salon_options_provider.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:barber_center/widgets/center_loading.dart';
import 'package:barber_center/widgets/dropdown_button.dart';
import 'package:barber_center/widgets/large_rounded_button.dart';
import 'package:barber_center/widgets/popup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SalonOptionsScreen extends StatelessWidget {
  const SalonOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SalonOptionsProvider>(
      create: (context) => SalonOptionsProvider(),
      child: Consumer<SalonOptionsProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: Styles.backgroundColor,
            appBar: AppBar(
              backgroundColor: Styles.backgroundColor,
              elevation: 0,
              title: const Text('Salon Information'),
            ),
            body: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 16,
                    ),
                    child: Form(
                      key: provider.formKey,
                      child: Column(
                        children: [
                          if (provider.loading) ...[
                            const CenterLoading(bottomMargin: 200)
                          ] else ...[
                            LabeledTextField(
                              controller: provider.tcName,
                              title: 'Salon\'s Name',
                              hintText: 'Class man barber shop',
                              validatorText: 'Please enter your salon\'s name',
                            ),
                            const Gap(32),
                            LabeledTextField(
                              controller: provider.tcAddress,
                              title: 'Salon\'s address',
                              hintText: 'Cleopatra eve. 4/20, Alexandria',
                              validatorText: 'Please enter your address',
                              textInputType: TextInputType.streetAddress,
                            ),
                            const Gap(32),
                            LabeledTextField(
                              controller: provider.tcPhone,
                              title: 'Salon\'s phone number',
                              hintText: '0020 0000 0000',
                              validatorText: 'Please enter your phone number',
                              textInputType: TextInputType.phone,
                              validator: Validators.phoneNumberValidator,
                            ),
                            const Gap(32),
                            InkWell(
                              onTap: () => Popup().show(
                                  title: 'Location',
                                  content: 'NOW!',
                                  actions: [
                                    TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                            'ofc man no problem dude'))
                                  ]),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.location_on_sharp,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Enter Location',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Gap(32),
                            SalonInfo(
                              value: provider.salonInformationModel.openTime
                                  .toStringTime(),
                              title: 'What time do you open your salon?',
                              items: getHalfHourIntervals(),
                              onChanged: provider.updateOpenTime,
                            ),
                            const Gap(22),
                            SalonInfo(
                              value: provider.salonInformationModel.closeTime
                                  .toStringTime(),
                              title: 'What time do you close your salon?',
                              items: getHalfHourIntervals(),
                              onChanged: provider.updateCloseTime,
                            ),
                            const Gap(22),
                            LabeledCheckBox(
                              title: 'Open to bookings?',
                              value: provider.salonInformationModel.isAvailable,
                              onChanged: provider.changeAvailability,
                            ),
                            const Spacer(),
                            LargeRoundedButton(
                              buttonName: 'Save',
                              onTap: provider.save,
                            ),
                            const Gap(22),
                          ]
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class LabeledTextField extends StatelessWidget {
  const LabeledTextField({
    required this.controller,
    required this.title,
    required this.hintText,
    required this.validatorText,
    this.textInputType = TextInputType.name,
    this.validator,
    super.key,
  });

  final String title;
  final String hintText;
  final String validatorText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textInputType,
      textInputAction: TextInputAction.next,
      inputFormatters: textInputType == TextInputType.phone
          ? [FilteringTextInputFormatter.digitsOnly]
          : null,
      validator: validator ??
          (value) {
            if (value!.isEmpty) {
              return validatorText;
            }
            return null;
          },
      decoration: InputDecoration(
        label: Text(title),
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 16),
        labelStyle: const TextStyle(color: Colors.black),
      ),
    );
  }
}

class SalonInfo extends StatelessWidget {
  const SalonInfo({
    required this.title,
    required this.value,
    required this.items,
    required this.onChanged,
    super.key,
  });

  final String title;
  final String value;
  final List<String> items;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          const Gap(16),
          DropdownWidget(
            value: value,
            items: items.toList().cast<String>(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}

class LabeledCheckBox extends StatelessWidget {
  const LabeledCheckBox({
    required this.title,
    required this.value,
    required this.onChanged,
    super.key,
  });

  final String title;
  final bool value;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          const Gap(16),
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: Styles.orangeColor,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
