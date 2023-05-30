import 'package:barber_center/helpers/validators.dart';
import 'package:barber_center/screens/location_screen/location_screen_provider.dart';
import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/center_loading.dart';
import 'package:barber_center/widgets/labeled_text_field.dart';
import 'package:barber_center/widgets/large_rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocationProvider>(
      create: (context) => LocationProvider(),
      child: Consumer<LocationProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: Styles.backgroundColor,
            appBar: AppBar(
              backgroundColor: Styles.backgroundColor,
              elevation: 0,
              title: Text(AppLocalizations.of(context)!.location),
            ),
            body: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Form(
                key: provider.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (provider.loading) ...[
                      const CenterLoading(bottomMargin: 200)
                    ] else if (!provider.haveLocation) ...[
                      Center(
                        child: Text(
                          AppLocalizations.of(context)!.location_permission,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      LargeRoundedButton(
                        buttonName:
                            AppLocalizations.of(context)!.allow_permission,
                        onTap: () async {
                          await provider.getLocation();
                        },
                      ),
                      const SizedBox(height: 32),
                    ] else ...[
                      InkWell(
                        onTap: () => provider.changeShowMap(true),
                        child: AnimatedContainer(
                          height: provider.showMap
                              ? AppLayout.getScreenHeight() * 6.4 / 10
                              : AppLayout.getScreenHeight() * 2 / 10,
                          width: double.infinity,
                          duration: const Duration(milliseconds: 400),
                          decoration: BoxDecoration(border: Border.all()),
                          child: const Center(child: Text('Map will be here')),
                        ),
                      ),
                      const SizedBox(height: 28),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            vertical: 22,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: Colors.white,
                          ),
                          child: provider.showMap
                              ? ConfirmAddressSection(provider: provider)
                              : ChangeAddressField(provider: provider),
                        ),
                      ),
                    ],
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

class ConfirmAddressSection extends StatelessWidget {
  const ConfirmAddressSection({
    required this.provider,
    super.key,
  });

  final LocationProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          provider.locationModel?.getAddress ?? '',
          style: const TextStyle(fontSize: 18),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: Visibility(
            visible: !provider.loading,
            replacement: const CupertinoActivityIndicator(),
            child: ElevatedButton(
              onPressed: () => provider.changeShowMap(false),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
              ),
              child: Text(
                AppLocalizations.of(context)!.choose_location,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

class ChangeAddressField extends StatelessWidget {
  const ChangeAddressField({
    required this.provider,
    super.key,
  });

  final LocationProvider provider;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Column(
            children: [
              Text(
                provider.locationModel?.getAddress ?? '',
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: WidgetPacker(
                    children: [
                      LabeledTextField(
                        enabled: false,
                        controller: provider.country,
                        title: AppLocalizations.of(context)!.country_title,
                        hintText: AppLocalizations.of(context)!.country_hint,
                        validator: Validators.cannotBeEmptyValidator,
                      ),
                      LabeledTextField(
                        controller: provider.administrativeArea,
                        title:
                            AppLocalizations.of(context)!.administrative_area,
                        hintText:
                            AppLocalizations.of(context)!.administrative_area,
                        validator: Validators.cannotBeEmptyValidator,
                        onChanged: provider.updatePlacemark,
                      ),
                      LabeledTextField(
                        controller: provider.locality,
                        title: AppLocalizations.of(context)!.locality,
                        hintText: AppLocalizations.of(context)!.locality_hint,
                        validator: Validators.cannotBeEmptyValidator,
                        onChanged: provider.updatePlacemark,
                      ),
                      LabeledTextField(
                        controller: provider.subLocality,
                        title: AppLocalizations.of(context)!.sub_locality,
                        hintText: AppLocalizations.of(context)!.sub_locality,
                        validator: Validators.cannotBeEmptyValidator,
                        onChanged: provider.updatePlacemark,
                      ),
                      LabeledTextField(
                        controller: provider.street,
                        title: AppLocalizations.of(context)!.street,
                        hintText: AppLocalizations.of(context)!.street,
                        validator: Validators.cannotBeEmptyValidator,
                        onChanged: provider.updatePlacemark,
                      ),
                      LabeledTextField(
                        controller: provider.postalCode,
                        title: AppLocalizations.of(context)!.postal_code,
                        hintText: AppLocalizations.of(context)!.postal_code,
                        validator: Validators.cannotBeEmptyValidator,
                        textInputType: TextInputType.number,
                        onChanged: provider.updatePlacemark,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.pop(context, provider.locationModel),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 12,
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)),
                  ),
                  child: Visibility(
                    visible: !provider.loadingSave,
                    replacement: const CupertinoActivityIndicator(),
                    child: Text(
                      AppLocalizations.of(context)!.my_location,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }
}

class WidgetPacker extends StatelessWidget {
  const WidgetPacker({
    required this.children,
    super.key,
  });

  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate((children.length / 2).ceil(), (index) {
        index = index * 2;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: index + 1 < children.length
              ? Row(
                  children: [
                    children[index],
                    const SizedBox(width: 12),
                    children[index + 1],
                  ],
                )
              : children[index],
        );
      }),
    );
  }
}
