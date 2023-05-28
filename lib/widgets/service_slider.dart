import 'package:barber_center/models/service_model.dart';
import 'package:barber_center/screens/profile_salon_screen/profile_salon_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ServiceSlider extends StatelessWidget {
  const ServiceSlider({
    required this.services,
    required this.deleteFunction,
    required this.addFunction,
    super.key,
  });

  final List<ServiceModel>? services;
  final Function(ServiceModel) deleteFunction;
  final Function() addFunction;

  @override
  Widget build(BuildContext context) {
    final itemCount = (services == null ? 0 : services!.length) + 1;

    return ListView.builder(
      itemCount: itemCount,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final ServiceModel? serviceModel =
            index != 0 ? (services?[index - 1]) : null;

        if (serviceModel == null) {
          if (index != 0) {
            return const SizedBox.shrink();
          } else {
            return AddButton(
              text: AppLocalizations.of(context)!.add_service,
              onTap: addFunction,
              circle: true,
            );
          }
        }

        final String text = serviceModel.name;
        final String image = serviceModel.image;

        dynamic onDelete() => deleteFunction(serviceModel);

        return ListItem(
          text: text,
          image: image,
          onDelete: onDelete,
          circle: true,
        );
      },
    );
  }
}
