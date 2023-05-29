import 'package:barber_center/screens/notifications_screen/notifications_screen.dart';
import 'package:barber_center/screens/profile_barber/profile_barber_screen.dart';
import 'package:barber_center/screens/booking_story/booking_story_page.dart';
import 'package:barber_center/screens/home_barber_screen/home_barber_screen.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

class FirstPageBarberUser extends StatefulWidget {
  const FirstPageBarberUser({Key? key}) : super(key: key);

  @override
  State<FirstPageBarberUser> createState() => _BottomBarState();
}

class _BottomBarState extends State<FirstPageBarberUser> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeBarberScreen(),
    const NotificationsScreen(),
    const BarberProfileScreen(),
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
              icon: Icon(Icons.notifications_active_outlined),
              activeIcon: Icon(Icons.notifications_active_rounded),
              label: 'Book'),
          // BottomNavigationBarItem(
          //     icon: Icon(FluentSystemIcons.ic_fluent_premium_regular),
          //     activeIcon: Icon(FluentSystemIcons.ic_fluent_premium_filled),
          //     label: 'VIP'),
          BottomNavigationBarItem(
              icon: Icon(FluentSystemIcons.ic_fluent_person_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled),
              label: 'Profile'),
        ],
      ),
    );
  }
}
