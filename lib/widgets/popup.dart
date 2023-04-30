import 'package:barber_center/services/routes.dart';
import 'package:flutter/material.dart';

class Popup {
  static Future<bool?> askLocation() async {
    return await show(
      title: 'Allow location',
      content:
          'So we can show you on the map and customers will find your salon easy',
      actions: [
        TextButton(
            onPressed: () {
              Routes.back(returnDialog: true);
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
      actions.add(const CancelButton());
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
          actions: actions,
        );
      },
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: const Text('Cancel'),
      onPressed: () {
        Routes.back();
      },
    );
  }
}
