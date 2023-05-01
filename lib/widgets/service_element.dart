import 'package:barber_center/utils/app_styles.dart';
import 'package:flutter/material.dart';

class ServiceElement extends StatelessWidget {
  const ServiceElement({
    required this.name,
    required this.image,
    required this.isSelected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String name;
  final String? image;
  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            width: 100,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              boxShadow: isSelected ? [BoxShadow(color: Colors.grey.shade500, blurRadius: 12, offset: Offset(0, 6))] : [BoxShadow(color: Colors.grey.shade300, blurRadius: 12, offset: Offset(0, 6))],
              color: isSelected ? Styles.darkBlueColor : Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: image != null ? NetworkImage(image!) : null,
                ),
                const SizedBox(height: 6),
                FittedBox(
                  child: Text(
                    name,
                    style: isSelected ? Styles.textStyle.copyWith(color: Colors.white, fontSize: 14) : Styles.textStyle.copyWith(color: Colors.black, fontSize: 14),
                  ),
                )
              ],
            ),
          ),
          isSelected
              ? const Positioned(
                  top: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Styles.primaryColor,
                    radius: 12,
                    child: Padding(
                      padding: EdgeInsets.all(2),
                      child: FittedBox(
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ))
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
