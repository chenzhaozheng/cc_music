import 'package:audioplayers/audioplayers.dart';
import 'package:cc_music/audio_cubit.dart';
import 'package:cc_music/audio_music_cubit.dart';
import 'package:cc_music/audio_musics_cubit.dart';
import 'package:cc_music/music/audio_play_page.dart';
import 'package:flutter/material.dart';
import 'package:cc_music/common/music.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../music_cubit.dart';
// import 'package:cc_music/music/audio_play_page.dart';

class _SecondScreenState extends State with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }
  @override
  bool get wantKeepAlive => true;
}

class SecondScreen extends StatelessWidget {
  State<StatefulWidget> createState() {
    return _SecondScreenState();
  }
  const SecondScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // title: new Text(music.name),
        title: BlocBuilder<AudioMusicCubit, Music>(
            builder: (context, music) => Center(
            )
        ),
      ),
      body: Stack(
          children: [
            BlocBuilder<AudioCubit, AudioPlayer>(
              builder: (context, audioPlayer) => Center(
                  child: BlocBuilder<AudioMusicsCubit, List<Music>>(
                    builder: (context, musics) => Center(
                      child: BlocBuilder<AudioMusicCubit, Music>(
                        builder: (context, music) => Center(
                          child: new AudioPlaybackPage(
                            music: music,
                            // setMusic: context.read<AudioMusicCubit>().setMusic,
                            musics: musics,
                            audioPlayer: audioPlayer

                          )
                        )
                      )
                    )
                  )
              ),
            ),
          ]
      ),
    );
  }
}
