import 'package:audioplayers/audioplayers.dart';

class AudioState {
  AudioPlayer audioPlayer;

  //AudioPlayer(mode: PlayerMode.MEDIA_PLAYER)

  // PlayState(this._audioPlayer, this._duration, this._position);
  ///初始化方法
  AudioState init() {
    print('初始化播放器');
    return AudioState()
      ..audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  }

  ///克隆方法,针对于刷新界面数据
  AudioState clone() {
    return AudioState()..audioPlayer = audioPlayer;
  }

  playStatus() {
    return AudioState()..audioPlayer.state.toString();
  }
}
