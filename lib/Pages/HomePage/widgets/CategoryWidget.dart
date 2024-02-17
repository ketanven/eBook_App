import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryWidget extends StatelessWidget {
  final String iconPath;
  final String btnName;
  final VoidCallback onTap;

  const CategoryWidget({
    Key? key,
    required this.iconPath,
    required this.btnName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: onTap, // Call the onTap callback when the widget is tapped
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(iconPath),
              ),
              Text(
                btnName,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
