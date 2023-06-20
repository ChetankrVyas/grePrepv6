import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class MyOpening extends StatefulWidget {
  const MyOpening({super.key});

  @override
  State<MyOpening> createState() => _MyOpeningState();
}

class _MyOpeningState extends State<MyOpening> {
  final VideoPlayerController videoPlayerController =
      VideoPlayerController.asset('assets/video.mp4');
  ChewieController? chewieController;
  @override
  void initState() {
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: 3 / 5,
        autoPlay: true,
        looping: true,
        autoInitialize: true,
        showControls: false);
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GREPREP',
              style: TextStyle(
                color: Colors.white,
              )),
          backgroundColor: const Color.fromARGB(255, 116, 35, 93),
          toolbarHeight: 60,
        ),
        body: Stack(
          children: [
            Chewie(controller: chewieController!),
            Container(
              alignment: Alignment.bottomCenter,
              height: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Positioned(
                    bottom: 0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "phone", (route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 116, 35, 93),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10)),
                      child: const Text(
                        'Continue with phone number',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 55, vertical: 20),
                    child: Text(
                      'By continuing, you agree to our Terms. See how we use your data in our Privacy Policy',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
