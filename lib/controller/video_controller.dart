part of 'controller.dart';

class VideoController extends GetxController {
  late YoutubePlayerController controller;

  MateriModel materimodel = MateriModel();
  void playVideo(String url) {
    final vidioId = YoutubePlayer.convertUrlToId(url);
    controller = YoutubePlayerController(
      initialVideoId: vidioId!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
      ),
    );
  }

  @override
  void onInit() {
    playVideo(Get.arguments);
    super.onInit();
  }
}
