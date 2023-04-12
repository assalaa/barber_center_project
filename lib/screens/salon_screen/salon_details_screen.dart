import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:flutter/material.dart';

class SalonDetailsScreen extends StatelessWidget {
  const SalonDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.backgroundColor,
        body: ListView(
          children: [
            Container(
              width: AppLayout.getScreenWidth(),
              height: AppLayout.getHeight(200),
              color: Colors.pink,
              child: Container(
                margin: EdgeInsets.only(top: 190),
                height: AppLayout.getHeight(10),
                decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(12)),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  width: AppLayout.getScreenWidth(),
                  height: AppLayout.getHeight(AppLayout.getScreenHeight() - 200),
                  decoration: BoxDecoration(
                    color: Colors.green,
                  ),
                )),
          ],
        ));
  }
}
