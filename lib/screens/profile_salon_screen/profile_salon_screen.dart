import 'package:barber_center/models/employee_model.dart';
import 'package:barber_center/models/service_model.dart';
import 'package:barber_center/screens/profile_salon_screen/profile_salon_provider.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/profile/full_name.dart';
import 'package:barber_center/widgets/profile/logout_button.dart';
import 'package:barber_center/widgets/profile/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SaloonProfileScreen extends StatelessWidget {
  const SaloonProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileSalonProvider>(
      create: (context) => ProfileSalonProvider(),
      child: Consumer<ProfileSalonProvider>(
        builder: (context, provider, _) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
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
                return Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LogoutButton(onPressed: provider.logout),
                        const SizedBox(height: 32),
                        ProfilePicture(
                          image: provider.userModel.image,
                          updatePhoto: provider.updatePhoto,
                        ),
                        const SizedBox(height: 22),
                        FullName(fullName: provider.userModel.name),
                        const SizedBox(height: 10),
                        LocationInfo(location: provider.userModel.city),
                        const SizedBox(height: 60),
                        const TabBarWidget(),
                        const Gap(64),
                        TabViewWidget(
                          children: [
                            ServiceSlider(
                              services: provider.services,
                              deleteFunction: provider.removeService,
                            ),
                            EmployeeSlider(
                              employees: provider.employees,
                              deleteFunction: provider.removeEmployee,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ]);
              }()),
            ),
          );
        },
      ),
    );
  }
}

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 58),
      // padding: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            offset: Offset(1, 2),
            color: Styles.greyColor,
          )
        ],
      ),
      child: TabBar(
        tabs: [
          Tab(text: AppLocalizations.of(context)!.tab_employees),
          Tab(text: AppLocalizations.of(context)!.tab_services),
        ],
        unselectedLabelColor: Styles.primaryColor,
        labelColor: Colors.white,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        indicator: const ShapeDecoration(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
          color: Styles.primaryColor,
        ),
      ),
    );
  }
}

class TabViewWidget extends StatelessWidget {
  const TabViewWidget({
    required this.children,
    super.key,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: TabBarView(children: children),
    );
  }
}

class ServiceSlider extends StatelessWidget {
  const ServiceSlider({
    required this.services,
    required this.deleteFunction,
    super.key,
  });

  final List<ServiceModel>? services;
  final Function(ServiceModel) deleteFunction;

  @override
  Widget build(BuildContext context) {
    final itemCount = (services == null ? 0 : services!.length) + 1;

    return ListView.builder(
      itemCount: itemCount,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final ServiceModel? serviceModel = index != 0 ? (services?[index - 1]) : null;

        if (serviceModel == null && index != 0) {
          return const SizedBox.shrink();
        }

        final String text = serviceModel?.name ?? AppLocalizations.of(context)!.add_service;
        final String? image = serviceModel?.image;

        final Function()? onTap = serviceModel == null ? () => Routes.goTo(Routes.addServiceRoute, enableBack: true) : null;

        final Function()? onDelete = serviceModel != null ? () => deleteFunction(serviceModel) : null;

        return ListItem(
          text: text,
          image: image,
          onTap: onTap,
          onDelete: onDelete,
        );
      },
    );
  }
}

class EmployeeSlider extends StatelessWidget {
  const EmployeeSlider({
    required this.employees,
    required this.deleteFunction,
    super.key,
  });

  final List<EmployeeModel>? employees;
  final Function(EmployeeModel) deleteFunction;

  @override
  Widget build(BuildContext context) {
    final itemCount = (employees == null ? 0 : employees!.length) + 1;

    return ListView.builder(
      itemCount: itemCount,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final EmployeeModel? employeeModel = index != 0 ? (employees?[index - 1]) : null;

        if (employeeModel == null && index != 0) {
          return const SizedBox.shrink();
        }

        final String text = employeeModel?.name ?? AppLocalizations.of(context)!.add_employees;
        final String? image = employeeModel?.image;

        final Function()? onTap = employeeModel == null ? () => Routes.goTo(Routes.addEmployeeRoute, enableBack: true) : null;

        final Function()? onDelete = employeeModel != null ? () => deleteFunction(employeeModel) : null;

        return ListItem(
          text: text,
          image: image,
          onTap: onTap,
          onDelete: onDelete,
        );
      },
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    required this.text,
    this.image,
    this.onTap,
    this.onDelete,
    super.key,
  });

  final String text;
  final String? image;
  final Function()? onTap;
  final Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: AspectRatio(
            aspectRatio: 1 / 1.6,
            child: Column(
              children: [
                onTap != null
                    ? AddButton(onTap: onTap)
                    : AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            image: image == null ? null : DecorationImage(image: NetworkImage(image!), fit: BoxFit.cover),
                          ),
                        ),
                      ),
                const SizedBox(height: 4),
                Flexible(
                  child: Text(
                    text,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
        if (onDelete != null) ...[
          Positioned(
            right: 0,
            top: 0,
            child: Semantics(
              button: true,
              label: 'Delete',
              enabled: true,
              child: GestureDetector(
                onTap: onDelete,
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 14,
                  child: Icon(Icons.remove_circle_outline, color: Colors.red),
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({
    this.onTap,
    super.key,
  });

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(16)),
            child: const Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LocationInfo extends StatelessWidget {
  const LocationInfo({
    this.location,
    super.key,
  });

  final String? location;

  @override
  Widget build(BuildContext context) {
    if (location == null) {
      return const SizedBox.shrink();
    }

    const IconData locationIcon = Icons.location_on;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          locationIcon,
          color: Styles.primaryColor,
        ),
        const SizedBox(width: 6),
        Text(
          location!,
          style: const TextStyle(fontSize: 18, color: Styles.greyColor),
        ),
      ],
    );
  }
}
