import 'package:barber_center/helpers/validators.dart';
import 'package:barber_center/models/salon_information_model.dart';
import 'package:barber_center/screens/options_barber_screen/barber_options_provider.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/center_loading.dart';
import 'package:barber_center/widgets/labeled_text_field.dart';
import 'package:barber_center/widgets/large_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class BarberOptionsScreen extends StatelessWidget {
  const BarberOptionsScreen({super.key, this.salonInformationModel});

  final SalonInformationModel? salonInformationModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BarberOptionsProvider>(
      create: (context) => BarberOptionsProvider(salonInformationModel),
      child: Consumer<BarberOptionsProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: Styles.backgroundColor,
            appBar: AppBar(
              backgroundColor: Styles.backgroundColor,
              elevation: 0,
              title: const Text('Barber Information'),
            ),
            body: Container(
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
                      const Gap(32),
                      LabeledTextField(
                        controller: provider.tcName,
                        title: AppLocalizations.of(context)!.name_info_field,
                        hintText:
                            AppLocalizations.of(context)!.barber_name_hint,
                        validatorText:
                            AppLocalizations.of(context)!.name_validation,
                      ),
                      const Gap(25),
                      LabeledTextField(
                        controller: provider.tcPhone,
                        title: AppLocalizations.of(context)!.phone_info_field,
                        hintText: '0020 0000 0000',
                        validatorText:
                            AppLocalizations.of(context)!.phone_validation,
                        textInputType: TextInputType.phone,
                        validator: Validators.phoneNumberValidator,
                      ),
                      const Gap(25),
                      WorkingPlace(provider: provider),
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
          );
        },
      ),
    );
  }
}

class WorkingPlace extends StatelessWidget {
  const WorkingPlace({
    required this.provider,
    super.key,
  });

  final BarberOptionsProvider provider;

  @override
  Widget build(BuildContext context) {
    if (provider.salonInformationModel == null) {
      return LargeRoundedButton(
        buttonName: 'Add Working Place',
        buttonTextColor: Colors.black,
        buttonColor: Colors.white,
        iconData: Icons.add,
        onTap: () => Routes.goTo(Routes.searchRoute, enableBack: true),
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            offset: Offset(1, 1),
            blurRadius: 1,
            color: Colors.grey,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            provider.salonInformationModel!.salonName,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Text(provider.salonInformationModel!.location?.getAddress ??
              provider.salonInformationModel!.address),
          const Divider(),
          ElevatedButton(
            onPressed: provider.leaveWork,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Leave Workplace'),
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
