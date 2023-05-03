import 'package:barber_center/models/barber_model.dart';
import 'package:barber_center/screens/profile_salon_screen/profile_salon_screen.dart';
import 'package:barber_center/screens/salon_details_screen/salon_details_provider.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/app_assets.dart';
import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_strings.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/utils/utils.dart';
import 'package:barber_center/widgets/category_button.dart';
import 'package:barber_center/widgets/center_loading.dart';
import 'package:barber_center/widgets/large_rounded_button.dart';
import 'package:barber_center/widgets/profile/full_name.dart';
import 'package:barber_center/widgets/service_element.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SalonDetailsScreen extends StatelessWidget {
  final String uid;
  const SalonDetailsScreen({
    required this.uid,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SalonDetailsProvider>(
      create: (context) => SalonDetailsProvider(uid),
      child: Consumer<SalonDetailsProvider>(builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: Styles.backgroundColor,
          body: Column(
            children: [
              if (provider.loading) ...[
                const CenterLoading()
              ] else ...[
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      //IMAGE

                      if (provider.salon.image != null) ...[
                        Image.network(
                          provider.salon.image!,
                          width: AppLayout.getScreenWidth(),
                          height: AppLayout.getHeight(300),
                          fit: BoxFit.cover,
                        ),
                      ] else ...[
                        Image.asset(
                          Assets.welcomeBg,
                          width: AppLayout.getScreenWidth(),
                          height: AppLayout.getHeight(300),
                          fit: BoxFit.cover,
                          color: const Color(0xff141212).withOpacity(0.6),
                          colorBlendMode: BlendMode.darken,
                        ),
                      ],

                      //ICONS BACK AND FAVORITE
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Material(
                                color: Styles.greyColor.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(100),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(100),
                                  onTap: () {
                                    Routes.back();
                                  },
                                  child: Container(
                                    width: AppLayout.getHeight(50),
                                    height: AppLayout.getWidth(50),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: Styles.brightTextColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      //BODY
                      Positioned(
                        top: AppLayout.getHeight(250),
                        child: Container(
                          width: AppLayout.getScreenWidth(),
                          height: AppLayout.getHeight(
                              900), // AppLayout.getScreenHeight(),
                          decoration: const BoxDecoration(
                            color: Styles.backgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: AppLayout.getWidth(14),
                              vertical: AppLayout.getWidth(14),
                            ),
                            child: SingleChildScrollView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FullName(
                                    userName: provider.salon.name,
                                    salonName:
                                        provider.salonInformation?.salonName,
                                    center: false,
                                  ),
                                  Gap(AppLayout.getHeight(8)),
                                  LocationInfo(
                                    location: provider.salonInformation
                                            ?.location?.getAddress ??
                                        provider.salonInformation?.address,
                                    center: false,
                                  ),
                                  const SizedBox(height: 16),
                                  const Divider(),
                                  Services(provider: provider),
                                  const SizedBox(height: 16),
                                  EstTimeAndTotalPrice(
                                    visible: provider.hasItemSelected(),
                                    time: provider.salonService.durationInMin,
                                    price: provider.salonService.price.toInt(),
                                  ),
                                  const SizedBox(height: 10),
                                  Barbers(provider: provider),
                                  const Divider(),
                                  const SizedBox(height: 10),
                                  BookButton(provider: provider),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]
            ],
          ),
        );
      }),
    );
  }
}

class Services extends StatelessWidget {
  const Services({
    required this.provider,
    super.key,
  });

  final SalonDetailsProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Services',
                  style: Styles.headLineStyle3.copyWith(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Choose Services',
                  style: Styles.textStyle.copyWith(
                    fontSize: 16,
                    color: Styles.greyColor,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
            Column(
              children: [
                const Text('Home Service'),
                SizedBox(
                  height: 28,
                  child: Switch(
                    value: provider.homeService,
                    onChanged: provider.changeHomeService,
                  ),
                ),
              ],
            ),
          ],
        ),
        // const SizedBox(height: 6),
        SizedBox(
          height: 80,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: provider.salonService.services.length,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CategoryButton(
                  serviceModel: provider.salonService.services[i],
                  onTap: () {
                    Future.delayed(
                      const Duration(milliseconds: 130),
                      () {
                        provider.selectCategory(i);
                      },
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class EstTimeAndTotalPrice extends StatelessWidget {
  const EstTimeAndTotalPrice({
    required this.visible,
    required this.time,
    required this.price,
    super.key,
  });

  final bool visible;
  final int time;
  final int price;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: RichText(
        text: TextSpan(
          text: 'Duration: ',
          style: Styles.textStyle.copyWith(
            fontSize: 18,
            color: Styles.darkTextColor,
            fontWeight: FontWeight.w400,
          ),
          children: [
            TextSpan(
              text: '$time minutes',
              style: Styles.textStyle.copyWith(
                fontSize: 20,
                color: Styles.darkTextColor,
                fontWeight: FontWeight.w400,
              ),
            ),
            const TextSpan(text: '\nTotal Price:'),
            TextSpan(
              text: ' $price EGP',
              style: Styles.textStyle.copyWith(
                fontSize: 20,
                color: Styles.darkTextColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Barbers extends StatelessWidget {
  const Barbers({
    required this.provider,
    super.key,
  });

  final SalonDetailsProvider provider;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: provider.hasItemSelected(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          RichText(
            text: TextSpan(
              text: 'Barbers',
              style: Styles.headLineStyle3.copyWith(
                color: Colors.black,
                fontSize: 18,
              ),
              children: [
                TextSpan(
                  text: '    Choose a Barber',
                  style: Styles.textStyle.copyWith(
                    fontSize: 17,
                    color: Styles.greyColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: provider.employees.length,
              itemBuilder: (context, index) {
                final BarberModel barberModel = provider.employees[index];

                if (provider.isEmployeeCapable(barberModel)) {
                  return ServiceElement(
                    name: barberModel.barberName,
                    image: barberModel.image,
                    isSelected: provider.selectedEmployee == barberModel,
                    onTap: () => provider.selectEmployee(barberModel),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BookButton extends StatelessWidget {
  const BookButton({
    required this.provider,
    super.key,
  });

  final SalonDetailsProvider provider;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: provider.canBook(),
      child: Row(
        children: [
          Expanded(
            child: LargeRoundedButton(
              buttonName: Strings.bookingBtn,
              onTap: () {
                if (provider.hasItemSelected()) {
                  if (provider.hasEmployeeSelected()) {
                    Routes.goTo(
                      Routes.bookingRoute,
                      args: [
                        provider.salonService,
                        provider.salonInformation,
                        provider.selectedEmployee,
                      ],
                      enableBack: true,
                    );
                  } else {
                    showMessageError('Please select a barber');
                  }
                } else {
                  showMessageError('Please select a service');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
