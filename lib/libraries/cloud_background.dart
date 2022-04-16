import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoApp extends UniqueWidget {
  static VideoPlayerController? _controller;

  const VideoApp({required GlobalKey<State<StatefulWidget>> key}) : super(key: key);

  @override
  _VideoAppState createState() => _VideoAppState();
}

class _VideoAppState extends State<VideoApp> {

  @override
  void initState() {
    super.initState();
    if (VideoApp._controller != null) {
      return;
    }
    VideoApp._controller = VideoPlayerController.asset('assets/video/cloud.mp4')
      ..initialize().then((_) {
        setState(() {
          VideoApp._controller?.setLooping(true);
          VideoApp._controller?.setPlaybackSpeed(1);
          VideoApp._controller?.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 1,
      widthFactor: 1,
      child: AnimatedSwitcher(
          child: VideoApp._controller?.value.isInitialized == true
              ? VideoPlayer(VideoApp._controller!)
              : const SizedBox.shrink(),
          duration: const Duration(seconds: 1)),
    );
  }
}

class CloudBackground extends StatelessWidget {
  final Widget? child;

  const CloudBackground({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [VideoApp(key: GlobalKey<_VideoAppState>()), child ?? Container()]);
  }
}
