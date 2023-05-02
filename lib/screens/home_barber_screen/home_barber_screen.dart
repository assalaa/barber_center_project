import 'package:barber_center/services/routes.dart';
import 'package:flutter/material.dart';

class HomeBarberScreen extends StatelessWidget {
  const HomeBarberScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InkWell(
        // onTap: () => Routes.goTo(Routes.searchRoute, enableBack: true),
        child: const Center(
          child: Text('Home Barber Screen'),
        ),
      ),
    );
  }
}
