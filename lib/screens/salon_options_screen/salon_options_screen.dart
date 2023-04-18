import 'package:barber_center/helpers/extensions.dart';
import 'package:barber_center/screens/salon_options_screen/salon_options_provider.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:barber_center/widgets/dropdown_button.dart';
import 'package:barber_center/widgets/large_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SalonOptionsScreen extends StatelessWidget {
  const SalonOptionsScreen({required this.salonId, super.key});

  final String salonId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SalonOptionsProvider>(
      create: (context) => SalonOptionsProvider(salonId),
      child: Consumer<SalonOptionsProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: Styles.backgroundColor,
            appBar: AppBar(
              backgroundColor: Styles.backgroundColor,
              elevation: 0,
              title: const Text('Salon Information'),
            ),
            body: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const Gap(16),
                  SalonInfo(
                    value: provider.salonInformationModel.chairs.toString(),
                    title: 'How many chairs do you have in your salon?',
                    items: const ['1', '2', '3', '4', '5'],
                    onChanged: provider.updateChairs,
                  ),
                  const Gap(22),
                  SalonInfo(
                    value:
                        provider.salonInformationModel.openTime.toStringTime(),
                    title: 'What time do you open your salon?',
                    items: getHalfHourIntervals(),
                    onChanged: provider.updateOpenTime,
                  ),
                  const Gap(22),
                  SalonInfo(
                    value:
                        provider.salonInformationModel.closeTime.toStringTime(),
                    title: 'What time do you close your salon?',
                    items: getHalfHourIntervals(),
                    onChanged: provider.updateCloseTime,
                  ),
                  const Gap(32),
                  AddressTextField(controller: provider.tcAddress),
                  const Gap(48),
                  LargeRoundedButton(
                    buttonName: 'Save',
                    onTap: provider.save,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class AddressTextField extends StatelessWidget {
  const AddressTextField({
    required this.controller,
    super.key,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        children: [
          const Text(
            'Your Salon\'s Address',
            style: TextStyle(fontSize: 16),
          ),
          const Gap(10),
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.streetAddress,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: 'Address'),
          ),
        ],
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
    return Column(
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
    );
  }
}
