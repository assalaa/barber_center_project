import 'package:flutter/material.dart';

import '../../services/constants.dart';

class SignUPScreen extends StatelessWidget {
  const SignUPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, signinRoute);
            },
            child: Text("signup")),
      ),
    );
  }
}
