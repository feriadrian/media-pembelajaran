import 'package:flutter/material.dart';
import 'package:skripsi/config/config.dart';

class MateriCard extends StatelessWidget {
  const MateriCard({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  final String title;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.only(
          bottom: getHeight(8),
        ),
        width: SizeConfig.screenWidth,
        padding: EdgeInsets.all(
          getWidht(12),
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              spreadRadius: 1,
              color: Colors.grey.withOpacity(0.5),
              offset: const Offset(
                0,
                3.0,
              ),
            ),
          ],
          color: const Color(0xfff7f7f7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
