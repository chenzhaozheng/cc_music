import '../common/music.dart';

class AudioLoveMusicsState {
  List<Music> musics;

  ///初始化方法
  AudioLoveMusicsState init() {
    return AudioLoveMusicsState()..musics = [];
  }
  // AudioMusicState init() {
  //   return AudioMusicState()
  //     ..music = new Music(
  //       name: '盛夏光年',
  //       mp3Rid: 'MP3_75712216',
  //       headImg: 'https://img4.kuwo.cn/wmvpic/324/9/5/3351076170.jpg',
  //       isPlay: false,
  //     );
  // }

  ///克隆方法,针对于刷新界面数据
  AudioLoveMusicsState clone() {
    return AudioLoveMusicsState()..musics = musics;
  }
}
