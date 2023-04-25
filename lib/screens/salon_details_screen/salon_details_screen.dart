import 'package:barber_center/models/employee_model.dart';
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
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                child: Column(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: SafeArea(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Material(
                                      color: Styles.greyColor.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(100),
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        onTap: () {
                                          Routes.back();
                                        },
                                        child: Container(
                                          width: AppLayout.getHeight(50),
                                          height: AppLayout.getWidth(50),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
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
                              top: 280,
                              child: Container(
                                width: AppLayout.getScreenWidth(),
                                height: 600, // AppLayout.getScreenHeight(),
                                decoration: const BoxDecoration(
                                  color: Styles.backgroundColor,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppLayout.getWidth(12),
                                    vertical: AppLayout.getWidth(12),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        provider.salon.name,
                                        style: Styles.textStyle.copyWith(
                                          fontSize: 24,
                                          color: Styles.darkTextColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Gap(AppLayout.getHeight(10)),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.pin_drop,
                                            color: Styles.primaryColor,
                                            size: 30,
                                          ),
                                          Gap(AppLayout.getWidth(5)),
                                          Text(
                                            provider.salon.city,
                                            style: Styles.textStyle.copyWith(
                                                fontSize: 20,
                                                color: Styles.greyColor,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 24),
                                      Text('Services',
                                          style: Styles.headLineStyle3),
                                      const SizedBox(height: 12),
                                      SizedBox(
                                        height: 55,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: provider
                                              .salonService.services.length,
                                          itemBuilder: (context, i) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: CategoryButton(
                                                serviceModel: provider
                                                    .salonService.services[i],
                                                onTap: () {
                                                  Future.delayed(
                                                    const Duration(
                                                        milliseconds: 130),
                                                    () {
                                                      provider
                                                          .selectCategory(i);
                                                    },
                                                  );
                                                },
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Visibility(
                                        visible: provider.hasItemSelected(),
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Duration: ',
                                            style: Styles.textStyle.copyWith(
                                              fontSize: 20,
                                              color: Styles.darkTextColor,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            children: [
                                              TextSpan(
                                                text:
                                                    '${provider.salonService.durationInMin} minutes',
                                                style:
                                                    Styles.textStyle.copyWith(
                                                  fontSize: 20,
                                                  color: Styles.primaryColor,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                              const TextSpan(text: '\nPrice:'),
                                              TextSpan(
                                                text:
                                                    ' \$${provider.salonService.price}',
                                                style:
                                                    Styles.textStyle.copyWith(
                                                  fontSize: 20,
                                                  color: Styles.primaryColor,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      Text('Barbers',
                                          style: Styles.headLineStyle3),
                                      const SizedBox(height: 12),
                                      Visibility(
                                        visible: provider.hasItemSelected(),
                                        child: SizedBox(
                                          height: 120,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount:
                                                provider.employees.length,
                                            itemBuilder: (context, index) {
                                              final EmployeeModel
                                                  employeeModel =
                                                  provider.employees[index];

                                              final bool showEmployee = provider
                                                  .salonService.services
                                                  .every((element) =>
                                                      employeeModel.servicesIds
                                                          .contains(element
                                                              .serviceId));

                                              if (showEmployee) {
                                                return ServiceElement(
                                                  name: employeeModel.name,
                                                  image: employeeModel.image,
                                                  isSelected: provider
                                                          .selectedEmployee ==
                                                      employeeModel,
                                                  onTap: () =>
                                                      provider.selectEmployee(
                                                          employeeModel),
                                                );
                                              } else {
                                                return const SizedBox();
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      Visibility(
                                        visible: provider.canBook(),
                                        child: LargeRoundedButton(
                                          buttonName: Strings.bookingBtn,
                                          onTap: () {
                                            if (provider.hasItemSelected()) {
                                              if (provider
                                                  .hasEmployeeSelected()) {
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
                                                showMessageError(
                                                    'Please select a barber');
                                              }
                                            } else {
                                              showMessageError(
                                                  'Please select a service');
                                            }
                                          },
                                        ),
                                      ),
                                    ],
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
              ),
            ],
          ),
        );
      }),
    );
  }
}
