part of 'config.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double defaultSize = 0;
  static Orientation? orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;
  }
}

// mengambil properti height berdasarkan ukuran perlayar
double getHeight(double inputHeight) {
  double? screenHeight = SizeConfig.screenHeight;

  // 812 adalah layout height yang designer gunakan
  return (inputHeight / 800.0) * screenHeight;
}

// mengambil properti widht berdasarkan ukuran perlayar
double getWidht(double inputWidth) {
  double? screenWidth = SizeConfig.screenWidth;

  // 812 adalah layout Width yang designer gunakan
  return (inputWidth / 360.0) * screenWidth;
}
