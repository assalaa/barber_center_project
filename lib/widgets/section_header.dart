import 'package:barber_center/utils/app_strings.dart';
import 'package:barber_center/utils/app_styles.dart';
import 'package:flutter/cupertino.dart';

class SectionHeader extends StatelessWidget {
  final String sectionTitle;
  const SectionHeader({required this.sectionTitle, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          sectionTitle,
          style: Styles.headLineStyle2,
        ),
        Text(
          Strings.seeMoreOption,
          style: Styles.headLineStyle4,
        )
      ],
    );
  }
}
