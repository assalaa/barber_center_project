import 'package:barber_center/utils/app_layout.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:flutter/material.dart';

class FeaturedSalons extends StatelessWidget {
  final String name;
  final String location;
  final String? image;
  const FeaturedSalons({
    required this.name,
    required this.location,
    required this.image,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        //margin: const EdgeInsets.all(8),
        width: AppLayout.getWidth(200),
        height: AppLayout.getHeight(230),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ], borderRadius: BorderRadius.circular(12), color: Styles.brightTextColor),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8),
              width: AppLayout.getWidth(170),
              height: AppLayout.getHeight(120),
              decoration: BoxDecoration(
                image: image != null
                    ? DecorationImage(
                        image: NetworkImage(image!),
                        fit: BoxFit.fill,
                      )
                    : null,
                borderRadius: BorderRadius.circular(12),
                color: Colors.green,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: Styles.headLineStyle3.copyWith(fontWeight: FontWeight.bold, color: Styles.darkTextColor),
                  ),
                  Text(
                    location,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'open',
                        style: Styles.textStyle.copyWith(color: Colors.green),
                      ),
                      Row(
                        children: const [
                          Icon(
                            Icons.star_border,
                            color: Styles.primaryColor,
                          ),
                          Text(
                            '4.2',
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ));
  }
}
