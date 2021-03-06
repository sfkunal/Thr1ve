import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  Image help = Image.asset(
    'images/HelpScreen.png',
    scale: 9,
  );
  String logo = 'images/logo.png';

  Widget videoTip() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            // Container(
            //   height: 30,
            //   color: Colors.deepPurple.shade500,
            // ),
            YoutubePlayer(
              aspectRatio: 9 / 9,
              controller: YoutubePlayerController(
                initialVideoId: YoutubePlayer.convertUrlToId(
                        'https://www.youtube.com/watch?v=EhceUfGlyls')
                    .toString(),
                flags: YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                  loop: true,
                ),
              ),
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.amber,
              bottomActions: [
                ProgressBar(isExpanded: true),
              ],
            ),
            Container(
              height: 30,
              color: Colors.deepPurple.shade500,
            ),
          ],
        ),
        Image.asset(
          logo,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade400,
      appBar: AppBar(
        title: Text('Tutorial'),
      ),
      body: videoTip(),
    );
  }
}
