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
                  SelectWidget(
                    title: '${provider.anyServiceSelected ? provider.services[provider.indexSelected].name : 'Service'} Price: ${provider.price} EGP',
                    value: provider.price,
                    maxValue: 1000,
                    divisions: 200,
                    onChanged: provider.setPrice,
                    visible: provider.anyServiceSelected,
                  ),
                  const Gap(32),

                  /// Avg. Time
                  SelectWidget(
                    title: 'Average Time: ${minutesToHours(provider.avgTime)}',
                    value: provider.avgTime,
                    maxValue: 120,
                    divisions: 24,
                    onChanged: provider.setTime,
                    visible: provider.anyServiceSelected,
                  ),
                  const Gap(64),

                  /// Save Button
                  LargeRoundedButton(
                    loading: provider.loading,
                    buttonName: provider.buttonText,
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

class SelectWidget extends StatelessWidget {
  final String title;
  final int value;
  final double minValue;
  final double maxValue;
  final int divisions;
  final Function(double) onChanged;
  final bool visible;

  const SelectWidget({
    required this.title,
    required this.value,
    required this.maxValue,
    required this.divisions,
    required this.onChanged,
    required this.visible,
    this.minValue = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return const SizedBox.shrink();
    }

    final double sliderValue = value.toDouble();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 15),
          ),
          const Gap(10),
          SliderWidget(
            value: sliderValue,
            minValue: minValue,
            maxValue: maxValue,
            divisions: divisions,
            onChanged: onChanged,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(minValue.floor().toString()),
              Text(maxValue.floor().toString()),
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
    if (provider.services.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(
      runSpacing: 8.0,
      children: List.generate(provider.services.length, (index) {
        final ServiceModel serviceModel = provider.services[index];

        final int indexService = provider.services.indexOf(serviceModel);

        final bool isSelected = indexService == provider.indexSelected;

        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Semantics(
            button: true,
            child: GestureDetector(
              onTap: () => provider.selectService(provider.services.indexOf(serviceModel)),
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
