import 'package:barber_center/models/saloon_service_details_model.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final Function onTap;
  final ServiceDetailModel serviceModel;
  const CategoryButton({
    required this.onTap,
    required this.serviceModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black87,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
      ).copyWith(
        side: MaterialStateProperty.resolveWith<BorderSide>(
          (states) {
            return BorderSide(
              color: serviceModel.selected ? Colors.black : Styles.primaryColor,
              width: 2.6,
            );
          },
        ),
      ),
      onPressed: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 4, 24, 0),
        child: Text(
          serviceModel.name,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: serviceModel.selected ? Colors.black : Styles.primaryColor,
            height: 1,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
