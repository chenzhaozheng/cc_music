import 'package:cc_music/audio_music_cubit.dart';
import 'package:cc_music/common/music.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MusicPlay extends StatelessWidget {
  final Music music;
  const MusicPlay({Key key, this.music}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            // padding: const EdgeInsets.only(bottom: 8.0),
            child: BlocBuilder<AudioMusicCubit, Music>(
              builder: (context, music) => new Text(
                // _playMusicList.toList()[_playMusicList.toList().length - 1].name,
                music.name,
                style: new TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
            )
          ),
          new Text(
              '横滑可切换上下首',
              style: new TextStyle(
                color: Colors.grey[500],
              )
          ),
        ]
    );
  }
}
