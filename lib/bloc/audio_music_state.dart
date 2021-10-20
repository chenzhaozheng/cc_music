import '../common/music.dart';

class AudioMusicState {
  Music music;

  //AudioPlayer(mode: PlayerMode.MEDIA_PLAYER)

  // PlayState(this._audioPlayer, this._duration, this._position);
  ///初始化方法
  AudioMusicState init() {
    return AudioMusicState()
      ..music = new Music(
        name: '盛夏光年',
        mp3Rid: 'MP3_75712216',
        headImg: 'https://img4.kuwo.cn/wmvpic/324/9/5/3351076170.jpg',
        isPlay: false,
      );
  }

  ///克隆方法,针对于刷新界面数据
  AudioMusicState clone() {
    return AudioMusicState()..music = music;
  }
}
