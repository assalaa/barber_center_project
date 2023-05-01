import 'package:barber_center/services/location_service.dart';
import 'package:barber_center/services/routes.dart';
import 'package:flutter/material.dart';

class Popup {
  static Future<bool> removeService(String serviceName) async {
    final bool? approved = await show(
      title: 'Remove $serviceName',
      content:
          'Are you sure you want to remove $serviceName service from your salon?',
      actions: [
        ActionButton(
            text: 'Remove', onPressed: () => Routes.back(returnDialog: true)),
      ],
    );
    return approved ?? false;
  }

  static Future<bool> removeEmployee(String employeeName) async {
    final bool? approved = await show(
      title: 'Remove Employee',
      content:
          'Are you sure you want to remove the employee \'$employeeName\' from your salon?',
      actions: [
        ActionButton(
            text: 'Remove', onPressed: () => Routes.back(returnDialog: true)),
      ],
    );
    return approved ?? false;
  }

  static Future<bool> closeMyBookings() async {
    final bool? approved = await show(
      title: 'Are you Sure?',
      content:
          'If you close bookings customers won\'t be able to see your salon.',
      actions: [
        ActionButton(
          text: 'Close my Salon to Bookings',
          textColor: Colors.purple,
          onPressed: () => Routes.back(returnDialog: true),
        )
      ],
    );
    return approved ?? false;
  }

  static Future<bool?> openAppSettings() async {
    return await show(
      title: 'Permission Denied',
      content:
          'We can\'t get your location. You need to allow location permission in the app\'s location settings to continue',
      cancelButton: false,
      barrierDismissible: false,
      actions: [
        ActionButton(
          text: 'Open Location Settings',
          onPressed: () {
            LocationService.openLocationSettings();
            Routes.back();
          },
        ),
      ],
    );
  }

  static Future<bool?> askLocation() async {
    return await show(
      title: 'Location Permission',
      content:
          'We need your permission to get your location. So we can show you on the map and customers will find your salon easy',
      actions: [
        ActionButton(
          text: 'Okay',
          onPressed: () => Routes.back(),
        ),
      ],
    );
  }

  static Future<bool?> locationServiceDisabled() async {
    return await show(
      title: 'Enable location',
      content:
          'Location service is disabled on this device. Please enable the location services to continue',
      cancelButton: false,
      actions: [
        TextButton(
            onPressed: () {
              Routes.back();
            },
            child: const Text('Okay'))
      ],
    );
  }

  static Future<bool?> show({
    required String title,
    required List<Widget> actions,
    String content = '',
    bool barrierDismissible = true,
    bool cancelButton = true,
  }) async {
    if (cancelButton) {
      actions.add(ActionButton(
        text: 'Cancel',
        textColor: Colors.red,
        onPressed: () => Routes.back(),
      ));
    }
    return showDialog<bool>(
      context: Routes.navigator.currentContext!,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(children: [Text(content)]),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: List.generate(
              actions.length,
              (index) =>
                  SizedBox(width: double.infinity, child: actions[index])),
        );
      },
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    required this.text,
    required this.onPressed,
    this.textColor,
    super.key,
  });

  final String text;
  final Color? textColor;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }
}
