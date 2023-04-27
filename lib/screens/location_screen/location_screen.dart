import 'package:barber_center/helpers/validators.dart';
import 'package:barber_center/models/salon_information_model.dart';
import 'package:barber_center/screens/location_screen/location_screen_provider.dart';
import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/center_loading.dart';
import 'package:barber_center/widgets/labeled_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({required this.salonInformationModel, super.key});

  final SalonInformationModel salonInformationModel;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LocationProvider>(
      create: (context) =>
          LocationProvider(salonInformationModel: salonInformationModel),
      child: Consumer<LocationProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: Styles.backgroundColor,
            appBar: AppBar(
              backgroundColor: Styles.backgroundColor,
              elevation: 0,
              title: const Text('Salon Location'),
            ),
            body: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Form(
                key: provider.formKey,
                child: Column(
                  children: [
                    if (provider.loading) ...[
                      const CenterLoading(bottomMargin: 200)
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
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: Colors.white,
                          ),
                          child: provider.showMap
                              ? ConfirmAddressSection(
                                  onPressed: () =>
                                      provider.changeShowMap(false),
                                  address: salonInformationModel
                                      .location?.getAddress,
                                )
                              : ChangeAddressField(
                                  salonInformationModel: salonInformationModel,
                                  provider: provider,
                                ),
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
    required this.onPressed,
    required this.address,
    super.key,
  });

  final String? address;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          address ?? '',
          style: const TextStyle(fontSize: 18),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 12,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
            ),
            child: const Text(
              'Choose this location',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
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
    required this.salonInformationModel,
    required this.provider,
    super.key,
  });

  final SalonInformationModel salonInformationModel;
  final LocationProvider provider;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          child: Column(
            children: [
              Text(
                salonInformationModel.location?.getAddress ?? '',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 22),
              Expanded(
                child: SingleChildScrollView(
                  child: WidgetPacker(
                    children: [
                      LabeledTextField(
                        enabled: false,
                        controller: provider.country,
                        title: 'Country',
                        hintText: 'Egypt',
                        validator: Validators.cannotBeEmptyValidator,
                      ),
                      LabeledTextField(
                        enabled: false,
                        controller: provider.countryCode,
                        title: 'Country Code',
                        hintText: 'EG',
                        validator: Validators.cannotBeEmptyValidator,
                      ),
                      LabeledTextField(
                        controller: provider.administrativeArea,
                        title: 'Administrative Area',
                        hintText: 'Administrative Area',
                        validator: Validators.cannotBeEmptyValidator,
                      ),
                      LabeledTextField(
                        controller: provider.subAdministrativeArea,
                        title: 'Sub Administrative Area',
                        hintText: 'Sub Administrative Area',
                        validator: Validators.cannotBeEmptyValidator,
                      ),
                      LabeledTextField(
                        controller: provider.locality,
                        title: 'Locality',
                        hintText: 'Alexandria',
                        validator: Validators.cannotBeEmptyValidator,
                      ),
                      LabeledTextField(
                        controller: provider.subLocality,
                        title: 'Sub Locality',
                        hintText: 'Sub Locality',
                        validator: Validators.cannotBeEmptyValidator,
                      ),
                      LabeledTextField(
                        controller: provider.thoroughfare,
                        title: 'Thoroughfare',
                        hintText: 'Thoroughfare',
                        validator: Validators.cannotBeEmptyValidator,
                      ),
                      LabeledTextField(
                        controller: provider.subThoroughfare,
                        title: 'Sub Thoroughfare',
                        hintText: 'Sub Thoroughfare',
                        validator: Validators.cannotBeEmptyValidator,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: provider.save,
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
                    child: const Text(
                      'Save',
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
