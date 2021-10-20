import 'package:bloc/bloc.dart';
import 'package:cc_music/common/music.dart';

class AudioMusicsCubit extends Cubit<List<Music>> {
  AudioMusicsCubit() : super([]);
  void setMusics(List<Music> musics) => emit(musics);
  getMusics() => this.state;
}

class ChangeAudioMusicsBlocState {
  // final int index;
  ChangeAudioMusicsBlocState();
}
