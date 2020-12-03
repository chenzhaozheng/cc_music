import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:cc_music/common/audio.dart';

class AudioCubit extends Cubit<AudioPlayer> {
  AudioCubit() : super(AudioPlayer(mode: PlayerMode.MEDIA_PLAYER));
  void setPlay(AudioPlayer audioPlayer) => emit(audioPlayer);
}

class ChangeAudioBlocState {
  ChangeAudioBlocState();
}
