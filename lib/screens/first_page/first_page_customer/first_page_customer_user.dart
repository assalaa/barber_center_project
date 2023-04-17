import 'package:barber_center/screens/booking_screen/booking_screen.dart';
import 'package:barber_center/screens/home_customer_screen/home_customer_screen.dart';
import 'package:barber_center/screens/profile_screen/customer_profile_screen.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

class FirstPageCustomerUser extends StatefulWidget {
  const FirstPageCustomerUser({Key? key}) : super(key: key);

  @override
  State<FirstPageCustomerUser> createState() => _BottomBarState();
}

class _BottomBarState extends State<FirstPageCustomerUser> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeCustomerScreen(),
    const BookingScreen(),
    const Text('data'),
    const CustomerProfileScreen(),
  ];

  void onTappedItem(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _widgetOptions[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: onTappedItem,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Styles.primaryColor,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Styles.greyColor,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(
                  FluentSystemIcons.ic_fluent_book_formula_information_regular),
              activeIcon: Icon(FluentSystemIcons
                  .ic_fluent_book_formula_compatibility_filled),
              label: 'Book'),
          BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_premium_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_premium_filled),
              label: 'VIP'),
          BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_person_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled),
              label: 'Profile'),
        ],
      ),
    );
  }
}
