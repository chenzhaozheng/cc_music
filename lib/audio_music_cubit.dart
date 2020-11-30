import 'package:bloc/bloc.dart';
import 'package:cc_music/common/music.dart';

class AudioMusicCubit extends Cubit<Music> {
  AudioMusicCubit() : super(new Music(
    name: '盛夏光年',
    mp3Rid: 'MP3_75712216',
    headImg: 'https://img4.kuwo.cn/wmvpic/324/9/5/3351076170.jpg',
    isPlay: false,
  ));
  void setMusic(Music music) => emit(music);
}

class ChangeAudioMusicBlocState {
  // final int index;
  ChangeAudioMusicBlocState();
}
