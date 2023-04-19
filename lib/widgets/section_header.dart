import 'package:barber_center/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';

class SectionHeader extends StatelessWidget {
  final String sectionTitle;
  final String sectionSeeMore;
  const SectionHeader({required this.sectionTitle, Key? key, required this.sectionSeeMore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          sectionTitle,
          style: Styles.headLineStyle2,
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            sectionSeeMore,
            style: Styles.headLineStyle4,
          ),
        )
      ],
    );
  }
}
