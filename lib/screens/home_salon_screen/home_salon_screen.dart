import 'package:barber_center/screens/home_salon_screen/home_salon_provider.dart';
import 'package:barber_center/services/routes.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeSalonScreen extends StatelessWidget {
  const HomeSalonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeSalonProvider>(
      create: (context) => HomeSalonProvider(),
      child: Consumer<HomeSalonProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            backgroundColor: Styles.backgroundColor,
            appBar: AppBar(
              elevation: 0,
              toolbarHeight: 0,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  if (provider.loading) ...[
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  ] else ...[
                    if (!provider.isProfileCompleted) ...[
                      CompleteProfileWidget(
                        onPressed: () => Routes.goTo(Routes.salonOptionsRoute, enableBack: true),
                      ),
                    ],
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CompleteProfileWidget extends StatelessWidget {
  const CompleteProfileWidget({
    required this.onPressed,
    super.key,
  });

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Your profile isn\'t completed',
              style: TextStyle(fontSize: 16),
            ),
            ElevatedButton(
              onPressed: onPressed,
              child: const Text('Complete'),
            ),
          ],
        ),
      ),
    );
  }
}
