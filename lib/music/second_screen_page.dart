import 'package:cc_music/bloc/audio_cubit.dart';
import 'package:cc_music/bloc/audio_music_cubit.dart';
import 'package:cc_music/bloc/audio_music_state.dart';
import 'package:cc_music/bloc/audio_musics_cubit.dart';
import 'package:cc_music/bloc/audio_state.dart';
import 'package:cc_music/common/music.dart';
import 'package:cc_music/music/audio_play_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return Scaffold(
      appBar: AppBar(
        // title: new Text(music.name),
        title: BlocBuilder<AudioMusicCubit, AudioMusicState>(
            builder: (context, musicState) => Center()),
      ),
      body: Stack(children: [
        BlocBuilder<AudioCubit, AudioState>(
          builder: (context, audioPlayer) => Center(
              child: BlocBuilder<AudioMusicsCubit, List<Music>>(
                  builder: (context, musics) => Center(
                      child: BlocBuilder<AudioMusicCubit, AudioMusicState>(
                          builder: (context, musicState) => Center(
                              child: AudioPlaybackPage(
                                  music: musicState.music,
                                  // setMusic: context.read<AudioMusicCubit>().setMusic,
                                  musics: musics,
                                  audioPlayer: audioPlayer)))))),
        ),
      ]),
    );
  }
}
