import 'package:barber_center/models/saloon_service_details_model.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatelessWidget {
  final Function() onTap;
  final ServiceDetailModel serviceModel;
  const CategoryButton({
    required this.onTap,
    required this.serviceModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSelected = serviceModel.selected;

    return Stack(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: isSelected ? Colors.white : Styles.primaryColor,
            backgroundColor:
                isSelected ? Styles.primaryColor : Colors.grey.shade200,
            padding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(22)),
            ),
            shadowColor: Colors.white,
          ).copyWith(
            side: MaterialStateProperty.resolveWith<BorderSide>(
              (states) {
                return BorderSide(
                  color:
                      isSelected ? Styles.primaryColor : Colors.grey.shade300,
                  width: 4,
                );
              },
            ),
          ),
          onPressed: onTap,
          child: Container(
            width: 120,
            height: 100,
            padding: EdgeInsets.symmetric(
                horizontal: isSelected ? 10 : 20, vertical: 10),
            child: FittedBox(
              child: Center(
                child: Text(
                  serviceModel.name,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.black54,
                    height: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
