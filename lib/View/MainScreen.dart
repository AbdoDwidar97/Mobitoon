import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class MainScreen extends StatefulWidget
{
  String movieUrl;

  MainScreen({this.movieUrl});

  @override
  State<StatefulWidget> createState() => MainScreenState();
}

class MainScreenState extends State <MainScreen>
{
  double w = 0, h = 0;
  VideoPlayerController _controller;
  bool isScreenClicked = true;

  @override
  void initState()
  {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft
    ]);

    _controller = VideoPlayerController.network(widget.movieUrl)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose()
  {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    w = MediaQuery.of(context).size.width / 50;
    h = MediaQuery.of(context).size.height / 50;

    return Scaffold(
      body: SafeArea(
        child: Stack(

          children: [

            Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: InkWell(
                onTap: (){
                  setState(() {
                    this.isScreenClicked = !isScreenClicked;
                  });
                },
                child: Container(
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                      : SizedBox(),
                ),
              ),
            ),

            AnimatedPositioned(
              top: h*1,
              left: (this.isScreenClicked) ? w*2: w*-10,
              duration: Duration(milliseconds: 200),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                iconSize: w*2,
                onPressed: (){Navigator.of(context).pop();},
              ),
            ),

            AnimatedPositioned(
              bottom: (this.isScreenClicked) ? h*2 : h*-12,
              left: 0,
              right: 0,
              duration: Duration(milliseconds: 200),
              child: Column(
                children: [

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      //Text(_controller.value.position.inMinutes.toString(), style: TextStyle(fontSize: h*1, color: Colors.white)),
                      //SizedBox(width: w*0.5),

                      SizedBox(
                        width: w*37,
                        child: VideoProgressIndicator(_controller, allowScrubbing: true, colors: VideoProgressColors(playedColor: Colors.white)),
                      ),

                    ],
                  ),

                  SizedBox(height: h*2),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      InkWell(
                        onTap: (){
                          setState(()
                          {
                            _controller.seekTo(Duration(seconds: _controller.value.position.inSeconds -10));
                          });

                        },
                        child: SizedBox(
                          width: w*3.5,
                          height: w*3.5,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[900],
                            child: Icon(Icons.settings_backup_restore, color: Colors.white, size: w*2),
                          ),
                        ),
                      ),

                      SizedBox(width: w*2),

                      InkWell(
                        onTap: (){
                          setState(()
                          {
                            _controller.value.isPlaying
                                ? _controller.pause()
                                : _controller.play();
                          });

                        },
                        child: SizedBox(
                          width: w*4.5,
                          height: w*4.5,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[900],
                            child: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white, size: w*3),
                          ),
                        ),
                      ),

                      SizedBox(width: w*2),

                      InkWell(
                        onTap: (){
                          setState(()
                          {
                            _controller.seekTo(Duration(seconds: _controller.value.position.inSeconds + 10));
                          });

                        },
                        child: SizedBox(
                          width: w*3.5,
                          height: w*3.5,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[900],
                            child: Icon(Icons.forward_5_outlined, color: Colors.white, size: w*2),
                          ),
                        ),
                      ),

                    ],
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