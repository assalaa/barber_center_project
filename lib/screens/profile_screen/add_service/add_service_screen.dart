import 'package:barber_center/models/service_model.dart';
import 'package:barber_center/screens/profile_screen/add_service/add_service_provider.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:barber_center/widgets/large_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class AddServicePage extends StatelessWidget {
  const AddServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddServiceProvider>(
      create: (context) => AddServiceProvider(),
      child: Consumer<AddServiceProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Add Service'),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  const Gap(32),

                  /// Text
                  const BodyTitle(),
                  const Gap(36),

                  /// Services
                  AllServices(provider: provider),
                  const Gap(48),

                  /// Price
                  SelectPrice(provider: provider),
                  const Gap(32),

                  /// Avg. Time
                  SelectTime(provider: provider),
                  const Gap(64),

                  /// Save Button
                  LargeRoundedButton(
                    loading: provider.loading,
                    buttonName: 'Save',
                    onTap: () async {
                      await provider.saveService();
                    },
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

class SelectTime extends StatelessWidget {
  const SelectTime({
    required this.provider,
    super.key,
  });
  final AddServiceProvider provider;

  @override
  Widget build(BuildContext context) {
    if (provider.selectedService == null) {
      return const SizedBox.shrink();
    }

    const int divisions = 24;

    const double minTime = 0.0;
    const double maxTime = 120.0;

    const String title = 'Average Time: ';
    final String time = minutesToHours(provider.avgTime);

    final double timeSliderValue = provider.avgTime.toDouble();

    final Function(double) onTimeChange = provider.setTime;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title$time',
            style: const TextStyle(fontSize: 15),
          ),
          const Gap(10),
          SliderWidget(
            maxValue: maxTime,
            divisions: divisions,
            value: timeSliderValue,
            onChanged: onTimeChange,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(minTime.floor().toString()),
              Text(maxTime.floor().toString()),
            ],
          ),
        ],
      ),
    );
  }
}

class SelectPrice extends StatelessWidget {
  const SelectPrice({
    required this.provider,
    super.key,
  });
  final AddServiceProvider provider;

  @override
  Widget build(BuildContext context) {
    if (provider.selectedService == null) {
      return const SizedBox.shrink();
    }

    const double minPrice = 0.0;
    const double maxPrice = 1000.0;

    final String title = '${provider.selectedService!.name} Price: ';
    final String price = '${provider.price} EGP';

    final double priceSliderValue = provider.price.toDouble();

    final Function(double) onPriceChange = provider.setPrice;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title$price',
            style: const TextStyle(fontSize: 15),
          ),
          const Gap(10),
          SliderWidget(value: priceSliderValue, onChanged: onPriceChange),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(minPrice.floor().toString()),
              Text(maxPrice.floor().toString()),
            ],
          ),
        ],
      ),
    );
  }
}

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    required this.value,
    required this.onChanged,
    this.minValue = 0,
    this.maxValue = 1000,
    this.divisions = 200,
    super.key,
  });

  final double value;
  final double minValue;
  final double maxValue;
  final int divisions;
  final Function(double value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Slider.adaptive(
      value: value,
      min: minValue,
      max: maxValue,
      divisions: divisions,
      onChanged: onChanged,
      thumbColor: Styles.primaryColor,
      activeColor: Colors.black,
    );
  }
}

class AllServices extends StatelessWidget {
  const AllServices({
    required this.provider,
    super.key,
  });

  final AddServiceProvider provider;

  @override
  Widget build(BuildContext context) {
    final List<ServiceModel>? services = provider.services;

    if (services == null) {
      return const SizedBox.shrink();
    }

    return Wrap(
      runSpacing: 8.0,
      children: List.generate(services.length, (index) {
        final ServiceModel serviceModel = services[index];

        final bool isSelected = serviceModel == provider.selectedService;

        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Semantics(
            button: true,
            child: GestureDetector(
              onTap: () => provider.selectService(serviceModel),
              child: SizedBox(
                width: 72,
                child: Column(
                  children: [
                    Opacity(
                      opacity: isSelected ? 1 : 0.4,
                      child: CircleAvatar(
                        radius: 32,
                        backgroundImage: NetworkImage(
                          serviceModel.image,
                        ),
                      ),
                    ),
                    const Gap(6),
                    FittedBox(
                      child: Text(
                        serviceModel.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: isSelected ? Colors.black : Styles.greyColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}

class BodyTitle extends StatelessWidget {
  const BodyTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const String title = 'Please select from services below';

    return const Center(
      child: FittedBox(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
