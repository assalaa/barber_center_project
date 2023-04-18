import 'package:barber_center/models/saloon_service_details_model.dart';
import 'package:barber_center/screens/salon_details_screen/salon_details_provider.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_strings.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:barber_center/widgets/large_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
              return Column(
                children: [
                  Stack(children: [
                    Container(
                      width: AppLayout.getScreenWidth(),
                      height: AppLayout.getHeight(300),
                      decoration: BoxDecoration(
                        image: provider.userModel.image != null
                            ? DecorationImage(
                                image: NetworkImage(provider.userModel.image!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: AppLayout.getHeight(15),
                          decoration: const BoxDecoration(
                            color: Styles.backgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: AppLayout.getWidth(16),
                        vertical: AppLayout.getWidth(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: AppLayout.getHeight(50),
                            height: AppLayout.getWidth(50),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Styles.greyColor.withOpacity(0.6)),
                            child: Center(
                              child: GestureDetector(
                                onTap: () => Routes.back(),
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Styles.brightTextColor,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: AppLayout.getHeight(50),
                            height: AppLayout.getWidth(50),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Styles.greyColor.withOpacity(0.6)),
                            child: const Center(
                              child: Icon(
                                Icons.favorite,
                                color: Styles.brightTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  Expanded(
                      child: Container(
                    width: double.infinity,
                    height:
                        AppLayout.getHeight(AppLayout.getScreenHeight() - 200),
                    padding: EdgeInsets.symmetric(
                      horizontal: AppLayout.getWidth(22),
                      vertical: AppLayout.getWidth(10),
                    ),
                    decoration:
                        const BoxDecoration(color: Styles.backgroundColor),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FullName(name: provider.userModel.name),
                        Gap(AppLayout.getHeight(10)),
                        LocationInfo(city: provider.userModel.city),
                        Gap(AppLayout.getHeight(25)),
                        SalonServicesList(
                          salonServices: provider.salonServiceModel.services,
                        ),
                        const WorkingHours(),
                        const Spacer(),
                        BookButton(onTap: () {}),
                        Gap(AppLayout.getHeight(32)),
                      ],
                    ),
                  )),
                ],
              );
            }()));
      }),
    );
  }
}

class FullName extends StatelessWidget {
  const FullName({
    required this.name,
    super.key,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: Styles.textStyle.copyWith(
        fontSize: 24,
        color: Styles.darkTextColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class LocationInfo extends StatelessWidget {
  const LocationInfo({
    required this.city,
    super.key,
  });

  final String city;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.pin_drop,
          color: Styles.primaryColor,
          size: 25,
        ),
        Gap(AppLayout.getWidth(5)),
        Text(
          city,
          style: Styles.textStyle.copyWith(
            fontSize: 18,
            color: Styles.greyColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class BookButton extends StatelessWidget {
  const BookButton({
    required this.onTap,
    super.key,
  });

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LargeRoundedButton(
          buttonName: Strings.bookingBtn,
          onTap: onTap,
        ),
      ],
    );
  }
}

class WorkingHours extends StatelessWidget {
  const WorkingHours({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();

    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Gap(AppLayout.getHeight(20)),
    //     Text('Working Hours', style: Styles.headLineStyle3),
    //     Gap(AppLayout.getHeight(15)),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Text(
    //           'Opens at:',
    //           style: Styles.headLineStyle2.copyWith(
    //             fontWeight: FontWeight.w500,
    //             fontSize: 18,
    //             color: Styles.darkTextColor.withOpacity(0.7),
    //           ),
    //         ),
    //         Text(
    //           'Open',
    //           style: Styles.textStyle.copyWith(
    //             color: Colors.green,
    //             fontWeight: FontWeight.bold,
    //             fontSize: 20,
    //           ),
    //         )
    //       ],
    //     ),
    //     Gap(AppLayout.getHeight(15)),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Text(
    //           'Closes at:',
    //           style: Styles.headLineStyle2.copyWith(
    //             fontWeight: FontWeight.w500,
    //             fontSize: 18,
    //             color: Styles.darkTextColor.withOpacity(0.7),
    //           ),
    //         ),
    //         Text(
    //           '10PM',
    //           style: Styles.textStyle.copyWith(
    //             color: Colors.green,
    //             fontWeight: FontWeight.bold,
    //             fontSize: 20,
    //           ),
    //         ),
    //       ],
    //     ),
    //     Gap(AppLayout.getHeight(18)),
    //   ],
    // );
  }
}

class SalonServicesList extends StatelessWidget {
  const SalonServicesList({
    required this.salonServices,
    super.key,
  });

  final List<ServiceDetailModel> salonServices;

  @override
  Widget build(BuildContext context) {
    if (salonServices.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Services', style: Styles.headLineStyle3),
        Gap(AppLayout.getHeight(10)),
        Wrap(
          runSpacing: 8,
          children: List.generate(
            salonServices.length,
            (index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Styles.pinkColor.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(12),
                ),
                width: AppLayout.getWidth(100),
                height: AppLayout.getHeight(45),
                child: Center(
                    child: Text(
                  'Hair Style',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: Styles.textStyle,
                )),
              );
            },
          ),
        ),
      ],
    );
  }
}
