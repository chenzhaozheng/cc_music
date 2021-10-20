import 'package:cc_music/bloc/audio_cubit.dart';
import 'package:cc_music/bloc/audio_music_cubit.dart';
import 'package:cc_music/bloc/audio_music_state.dart';
import 'package:cc_music/bloc/audio_state.dart';
import 'package:cc_music/common/cd.dart';
import 'package:cc_music/common/music.dart';
import 'package:cc_music/music/dialog_page.dart';
import 'package:cc_music/music/music_page.dart';
import 'package:cc_music/music/qrcode_page2.dart';
import 'package:cc_music/music/second_screen_page.dart';
import 'package:cc_music/music/test_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Audio extends StatelessWidget {
  final List<Music> _playMusicList;
  final String url;
  final Music music;
  AnimationController cdIconController;
  Animation<double> cdIconAnimation;

  Audio(this.url, this._playMusicList, this.music);

  Widget build(BuildContext context) {
    Row buildButtonColumn(
        IconData icon, String label, url, Music music, List<Music> musics) {
      Color color = Theme.of(context).primaryColor;
      return Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.list,
              color: color,
              size: 24.0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        BlocBuilder<AudioMusicCubit, AudioMusicState>(
                            builder: (context, x) => new MusicsListScreen())),
              );
            },
          ),
          // IconButton(
          //   icon: Icon(
          //     Icons.ac_unit,
          //     color: color,
          //     size: 24.0,
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       // MaterialPageRoute(
          //       //     builder: (context) => QrCodeWidget(
          //       //         url:
          //       //             'http://shan-m.newbeeaichain.com/m/#/set-good?botId=qsbzhst38520280&cardId=000001')),
          //       MaterialPageRoute(
          //         settings: RouteSettings(name: 'qrcode_page'),
          //         builder: (context) => QrCodeWidget(
          //             url:
          //                 'http://shan-m.newbeeaichain.com/m/#/set-good?botId=qsbzhst38520280&cardId=000001'),
          //       ),
          //     );
          //   },
          // ),
          // IconButton(
          //   icon: Icon(
          //     Icons.ac_unit,
          //     color: color,
          //     size: 24.0,
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => DialogWidget(text: '加载中'),
          //         ));
          //   },
          // )
        ],
      );
    }

    Column musicPlay() {
      return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                // padding: const EdgeInsets.only(bottom: 8.0),
                child: BlocBuilder<AudioMusicCubit, AudioMusicState>(
              builder: (context, musicState) => Text(
                musicState.music.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )),
            // new Rotation(),
            // Text('横滑可切换上下首',
            //     style: TextStyle(
            //       color: Colors.grey[500],
            //     )),
          ]);
    }

    return Container(
      color: Colors.white,
      child: SafeArea(
        child: SizedBox(
          height: 54.0,
          child: Card(
            elevation: 2.0,
            shape: RoundedRectangleBorder(),
            margin: EdgeInsets.all(0.0),
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Cd(),
                    // BlocBuilder<AudioCubit, AudioState>(
                    //     builder: (context, audioState) =>
                    //         Text(audioState.audioPlayer.state.toString())),
                    Expanded(child: musicPlay()),
                    // buildButtonColumn(Icons.play_arrow, '', ''),
                    buildButtonColumn(
                        Icons.list, '', url, music, this._playMusicList)
                  ]
                  //  buildButtonColumn(Icons.list, 'SHARE')
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
