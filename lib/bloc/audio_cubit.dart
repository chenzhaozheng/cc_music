// import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:cc_music/bloc/audio_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/music.dart';
import 'audio_duration_cubit.dart';
import 'audio_music_cubit.dart';
import 'audio_musics_cubit.dart';
import 'audio_position_cubit.dart';

class AudioCubit extends Cubit<AudioState> {
  AudioCubit() : super(AudioState().init());
  // void setPlay(AudioPlayer audioPlayer) =>
  //     emit(state.clone()..audioPlayer = state.audioPlayer);

  void play(context, Music music) async {
    var stateRes = state.audioPlayer.state.toString();
    print('stateRes');
    print(stateRes);
    if (stateRes != 'AudioPlayerState.STOPPED' && stateRes != 'null') {
      await this.stop(context);
    }
    Duration _position = BlocProvider.of<AudioPositionCubit>(context).state;
    Duration _duration = BlocProvider.of<AudioDurationCubit>(context).state;
    final playPosition = (_position != null &&
            _duration != null &&
            _position.inMilliseconds > 0 &&
            _position.inMilliseconds < _duration.inMilliseconds)
        ? _position
        : null;
    var url = '';
    if (music.mp3Rid != '') {
      var mp3Rid = music.mp3Rid;
      url =
          'http://antiserver.kuwo.cn/anti.s?rid=$mp3Rid&response=res&format=mp3|aac&type=convert_url&br=320kmp3&agent=iPhone&callback=getlink&jpcallback=getlink.mp3';
    }
    final result = await state.audioPlayer.play(url, position: playPosition);
    if (result == 1) {
      print(result);
    }
    state.audioPlayer.setPlaybackRate(playbackRate: 1.0);
    print('=====');
    print(state.audioPlayer.state.toString());
  }

  void pause(context) async {
    // AudioPlayer _audioPlayer = state.audioPlayer;
    print("暂停");
    final result = await state.audioPlayer.pause();
    if (result == 1) {
      print("success");
    }
  }

  Future<void> stop(context) async {
    // AudioPlayer _audioPlayer = state.audioPlayer;
    final result = await state.audioPlayer.stop();
    print("停止");
    print(result);
    if (result == 1) {
      print("执行");
      BlocProvider.of<AudioPositionCubit>(context)
          .setPosition(Duration(seconds: 0));
      BlocProvider.of<AudioDurationCubit>(context)
          .setDuration(Duration(seconds: 0));
      // context.read<AudioPositionCubit>().setPosition(p);
    }
  }

  // 上一首
  void lastPlay(context) async {
    await this.stop(context);
    BlocProvider.of<AudioPositionCubit>(context)
        .setPosition(Duration(seconds: 0));
    var musics = BlocProvider.of<AudioMusicsCubit>(context).getMusics();
    var music = BlocProvider.of<AudioMusicCubit>(context).getMusic();
    var mainIndex = 0;
    var index = 0;
    musics.forEach((element) {
      index++;
      if (element.mp3Rid == music.mp3Rid) {
        mainIndex = index - 2;
        if (mainIndex < 0) {
          mainIndex = musics.length - 1;
        }
      }
    });
    BlocProvider.of<AudioMusicCubit>(context).setMusic(musics[mainIndex]);
    this.play(context, musics[mainIndex]);
  }

  // 下一首
  void nextPlay(context) async {
    await this.stop(context);
    BlocProvider.of<AudioPositionCubit>(context).setPosition(Duration());
    var musics = BlocProvider.of<AudioMusicsCubit>(context).getMusics();
    var music = BlocProvider.of<AudioMusicCubit>(context).getMusic();
    var mainIndex = 0;
    var index = 0;
    musics.forEach((element) {
      index++;
      if (element.mp3Rid == music.mp3Rid) {
        mainIndex = index;
        if (musics.length == mainIndex) {
          mainIndex = 0;
        }
      }
    });
    BlocProvider.of<AudioMusicCubit>(context).setMusic(musics[mainIndex]);
    this.play(context, musics[mainIndex]);
  }

  // ignore: non_constant_identifier_names
  void seek(context, Position) async {
    // AudioPlayer _audioPlayer = state.audioPlayer;
    state.audioPlayer.seek(Duration(milliseconds: Position.round()));
  }
}

class ChangeAudioBlocState {
  ChangeAudioBlocState();
}
