import 'package:barber_center/models/employee_model.dart';
import 'package:barber_center/models/service_model.dart';
import 'package:barber_center/screens/profile_screen/profile_screen_provider.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/profile/full_name.dart';
import 'package:barber_center/widgets/profile/logout_button.dart';
import 'package:barber_center/widgets/profile/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SaloonProfileScreen extends StatelessWidget {
  const SaloonProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileScreenProvider>(
      create: (context) => ProfileScreenProvider(),
      child: Consumer<ProfileScreenProvider>(
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
                        LogoutButton(provider: provider),
                        const SizedBox(height: 32),
                        ProfilePicture(provider: provider),
                        const SizedBox(height: 22),
                        FullName(fullName: provider.userModel.name),
                        const SizedBox(height: 10),
                        LocationInfo(location: provider.userModel.city),
                        const SizedBox(height: 60),
                        const TabBarWidget(),
                        const Gap(64),
                        EmployeesAndServices(
                          employees: provider.employees,
                          services: provider.services,
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
      margin: const EdgeInsets.symmetric(horizontal: 64),
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
      child: const TabBar(
        tabs: [
          Tab(text: 'Service'),
          Tab(text: 'Employee'),
        ],
        unselectedLabelColor: Styles.primaryColor,
        labelColor: Colors.white,
        labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        indicator: ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
          color: Styles.primaryColor,
        ),
      ),
    );
  }
}

class EmployeesAndServices extends StatelessWidget {
  const EmployeesAndServices({
    this.employees,
    this.services,
    super.key,
  });
  final List<EmployeeModel>? employees;
  final List<ServiceModel>? services;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: TabBarView(
        children: [
          ServiceSlider(services: services),
          EmployeeSlider(employees: employees),
        ],
      ),
    );
  }
}

class ServiceSlider extends StatelessWidget {
  const ServiceSlider({
    required this.services,
    super.key,
  });

  final List<ServiceModel>? services;

  @override
  Widget build(BuildContext context) {
    final itemCount = (services == null ? 0 : services!.length) + 1;

    return ListView.builder(
      itemCount: itemCount,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final bool addButton = index == 0;

        final ServiceModel? serviceModel =
            !addButton ? (services?[index - 1]) : null;

        if (serviceModel == null && !addButton) {
          return const SizedBox.shrink();
        }

        final String text =
            addButton ? 'Add Service' : serviceModel?.name ?? '';
        final String? image = serviceModel?.image;

        return ListItem(
          text: text,
          image: image,
          addButton: addButton,
          onTap: () => Routes.goTo(Routes.addServiceRoute, enableBack: true),
        );
      },
    );
  }
}

class EmployeeSlider extends StatelessWidget {
  const EmployeeSlider({
    required this.employees,
    super.key,
  });

  final List<EmployeeModel>? employees;

  @override
  Widget build(BuildContext context) {
    final itemCount = (employees == null ? 0 : employees!.length) + 1;

    return ListView.builder(
      itemCount: itemCount,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final bool addButton = index == 0;

        final EmployeeModel? employeeModel =
            !addButton ? (employees?[index - 1]) : null;

        if (employeeModel == null && !addButton) {
          return const SizedBox.shrink();
        }

        final String text =
            addButton ? 'Add Employee' : employeeModel?.name ?? '';
        final String? image = employeeModel?.image;

        return ListItem(
          text: text,
          image: image,
          addButton: addButton,
          onTap: () => Routes.goTo(Routes.addEmployeeRoute, enableBack: true),
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
    this.addButton = false,
    super.key,
  });

  final String text;
  final String? image;
  final bool addButton;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: AspectRatio(
        aspectRatio: 1 / 1.6,
        child: Column(
          children: [
            addButton
                ? AddButton(onTap: onTap)
                : AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        image: image == null
                            ? null
                            : DecorationImage(
                                image: NetworkImage(image!), fit: BoxFit.cover),
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
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(16)),
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
