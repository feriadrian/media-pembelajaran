import 'package:flutter/material.dart';
import 'package:skripsi/config/config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.title,
    required this.press,
    this.isloading = false,
    this.lebar,
    required this.isWrapper,
  }) : super(key: key);

  final String title;
  final Function()? press;
  final bool isloading;
  final bool isWrapper;
  final double? lebar;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      width: isWrapper == true ? lebar : double.infinity,
      height: getHeight(56),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.blue[600]),
        onPressed: press,
        child: isloading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
