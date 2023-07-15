import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:skripsi/config/config.dart';

import '../widgets/custom_textfield.dart';

class SoalCard extends StatelessWidget {
  const SoalCard({
    Key? key,
    required this.textController,
    required this.gambarController,
    required this.press,
    required this.hintText,
  }) : super(key: key);

  final TextEditingController textController;
  final TextEditingController gambarController;
  final Function() press;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        CustomTextfield(
          isWrap: true,
          hintText: hintText,
          controller: textController,
        ),
        SizedBox(
          height: getHeight(18),
        ),
        const Text('Upload Gambar Pendukung Soal(Optional)'),
        SizedBox(
          height: getHeight(24),
        ),
        Row(
          children: [
            Expanded(
              child: CustomTextfield(
                onTap: press,
                hintText: 'Soal.jpg',
                readOnly: true,
                controller: gambarController,
              ),
            ),
            SizedBox(
              width: getWidht(18),
            ),
            GestureDetector(
              onTap: press,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: getHeight(8),
                  horizontal: getWidht(8),
                ),
                child: SvgPicture.asset(
                  'assets/clip.svg',
                  color: Colors.white,
                  height: getHeight(24),
                  width: getWidht(24),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: getHeight(24),
        ),
        const Divider(
          color: Colors.black,
          thickness: 2,
        ),
      ],
    );
  }
}
