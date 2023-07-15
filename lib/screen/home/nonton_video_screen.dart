import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../controller/controller.dart';

class NontonVideoScreen extends StatelessWidget {
  const NontonVideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VideoController());

    return WillPopScope(
      onWillPop: () async {
        await SystemChrome.setPreferredOrientations(
            [DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);
        return true;
      },
      child: Scaffold(
        body: Center(
          child: YoutubePlayer(
            actionsPadding: const EdgeInsets.all(8),
            controller: controller.controller,
            showVideoProgressIndicator: true,
            onReady: () => debugPrint('ready'),
            bottomActions: [
              CurrentPosition(),
              ProgressBar(isExpanded: true),
              FullScreenButton(),
            ],
          ),
        ),
      ),
    );
  }
}
