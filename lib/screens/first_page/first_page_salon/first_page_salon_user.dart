import 'package:barber_center/screens/home_salon_screen/home_salon_screen.dart';
import 'package:barber_center/screens/notifications_screen/notifications_screen.dart';
import 'package:barber_center/screens/profile_salon_screen/profile_salon_screen.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';

class FirstPageSalonUser extends StatefulWidget {
  const FirstPageSalonUser({Key? key}) : super(key: key);

  @override
  State<FirstPageSalonUser> createState() => _BottomBarState();
}

class _BottomBarState extends State<FirstPageSalonUser> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeSalonScreen(),
    const NotificationsScreen(),
    const SaloonProfileScreen(),
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
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active_outlined),
              activeIcon: Icon(Icons.notifications_active_rounded),
              label: 'Notification'),
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_person_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
