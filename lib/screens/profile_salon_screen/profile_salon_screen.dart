import 'package:barber_center/models/barber_model.dart';
import 'package:barber_center/models/user_model.dart';
import 'package:barber_center/screens/profile_salon_screen/profile_salon_provider.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/profile/full_name.dart';
import 'package:barber_center/widgets/service_slider.dart';
import 'package:barber_center/widgets/profile/logout_button.dart';
import 'package:barber_center/widgets/profile/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LogoutButton(onPressed: provider.logout),
                            const EditButton(),
                          ],
                        ),
                        const SizedBox(height: 32),
                        ProfilePicture(
                          image: provider.userModel.image,
                          updatePhoto: provider.updatePhoto,
                        ),
                        const SizedBox(height: 22),
                        FullName(
                          userName: provider.userModel.name,
                          salonName: provider.salonInformationModel?.salonName,
                        ),
                        const SizedBox(height: 10),
                        LocationInfo(
                            location: provider.salonInformationModel?.location
                                    ?.getAddress ??
                                provider.salonInformationModel?.address),
                        const SizedBox(height: 32),
                        const TabBarWidget(),
                        const SizedBox(height: 48),
                        TabViewWidget(
                          children: [
                            ServiceSlider(
                              services: provider.services,
                              deleteFunction: provider.removeService,
                              addFunction: () => Routes.goTo(
                                  Routes.addServiceRoute,
                                  enableBack: true),
                            ),
                            EmployeeSlider(
                              userModel: provider.userModel,
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

class EditButton extends StatelessWidget {
  const EditButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => Routes.goTo(Routes.salonOptionsRoute, enableBack: true),
      icon: const Icon(Icons.edit),
      color: Styles.primaryColor,
    );
  }
}

class TabBarWidget extends StatelessWidget {
  const TabBarWidget({super.key});

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
          Tab(text: AppLocalizations.of(context)!.tab_services),
          Tab(text: AppLocalizations.of(context)!.tab_employees),
        ],
        unselectedLabelColor: Styles.primaryColor,
        labelColor: Colors.white,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        indicator: const ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))),
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

class EmployeeSlider extends StatelessWidget {
  const EmployeeSlider({
    required this.userModel,
    required this.employees,
    required this.deleteFunction,
    super.key,
  });
  final UserModel userModel;
  final List<BarberModel>? employees;
  final Function(BarberModel) deleteFunction;

  @override
  Widget build(BuildContext context) {
    final itemCount = (employees == null ? 0 : employees!.length) + 1;

    return ListView.builder(
      itemCount: itemCount,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final BarberModel? barberModel =
            index != 0 ? (employees?[index - 1]) : null;

        if (barberModel == null) {
          if (index != 0) {
            return const SizedBox.shrink();
          } else {
            return AddButton(
              text: AppLocalizations.of(context)!.add_employees,
              onTap: () => Routes.goTo(
                enableBack: true,
                Routes.searchRoute,
                args: userModel.kindOfUser,
              ),
            );
          }
        }

        final String text = barberModel.barberName;
        final String? image = barberModel.image;

        return ListItem(
          text: text,
          image: image,
          onDelete: () => deleteFunction(barberModel),
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
    this.circle = false,
    super.key,
  });

  final String text;
  final String? image;
  final Function()? onTap;
  final Function()? onDelete;
  final bool circle;

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
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(circle ? 100 : 16),
                      image: image == null || image == ''
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
    required this.text,
    required this.onTap,
    this.circle = false,
    super.key,
  });

  final String text;
  final Function() onTap;
  final bool circle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: AspectRatio(
        aspectRatio: 1 / 1.6,
        child: Column(
          children: [
            Semantics(
              button: true,
              child: GestureDetector(
                onTap: onTap,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(circle ? 100 : 16)),
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

class LocationInfo extends StatelessWidget {
  const LocationInfo({
    this.location,
    this.center = true,
    super.key,
  });

  final String? location;
  final bool center;

  @override
  Widget build(BuildContext context) {
    if (location == null) {
      return const SizedBox.shrink();
    }

    const IconData locationIcon = Icons.location_on;

    return Padding(
      padding:
          center ? const EdgeInsets.symmetric(horizontal: 16) : EdgeInsets.zero,
      child: Row(
        mainAxisAlignment:
            center ? MainAxisAlignment.center : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            locationIcon,
            color: Styles.primaryColor,
            size: 28,
          ),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              location!,
              // textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(fontSize: 18, color: Styles.greyColor),
            ),
          ),
        ],
      ),
    );
  }
}
