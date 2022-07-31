import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayer extends StatefulWidget {
  final id;
  VideoPlayer(this.id);

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
//      isFullScreen:true,
      initialVideoId: YoutubePlayer.convertUrlToId(this.widget.id),
      flags: YoutubePlayerFlags(
        isFullScreen: true,
        disableDragSeek: true,
        autoPlay: true,
        mute: false,

      ),

    );

    return Scaffold(
      extendBodyBehindAppBar: true,
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,

      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 0),
        child: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
              SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
            },
    ),
      ),

    ),
    body: YoutubePlayerBuilder(
        player: YoutubePlayer(
          controller: _controller,
      ),
        builder: (context, player){
    return Column(
    children: [
    // some widgets
    player,
    //some other widgets
    ],
    );
    }
    ),
    );
  }
}
