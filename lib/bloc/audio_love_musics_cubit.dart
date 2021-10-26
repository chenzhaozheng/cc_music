import 'package:bloc/bloc.dart';
import 'package:cc_music/common/music.dart';
import 'audio_love_musics_state.dart';

// class AudioLoveMusicsCubit extends Cubit<List<Music>z> {
//   AudioLoveMusicsCubit() : super([]);
//   void setMusics(List<Music> musics) => emit(musics);
//   getMusics() => this.state;
// }
class AudioLoveMusicsCubit extends Cubit<AudioLoveMusicsState> {
  // AudioLoveMusicsCubit() : super([]);
  AudioLoveMusicsCubit() : super(AudioLoveMusicsState().init());
  void setMusics(List<Music> musics) => emit(state.clone()..musics = musics);
  getMusics() => this.state.musics;
}

class ChangeAudioLoveMusicsBlocState {
  // final int index;
  ChangeAudioLoveMusicsBlocState();
}
