import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:cc_music/audio_duration_cubit.dart';
import 'package:cc_music/audio_music_cubit.dart';
import 'package:cc_music/audio_musics_cubit.dart';
import 'package:cc_music/audio_position_cubit.dart';
import 'package:cc_music/common/music.dart';
import 'package:cc_music/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AudioPlaybackPage extends StatefulWidget {
  final musics;
  final music;
  final audioPlayer;
  final setMusic;
  const AudioPlaybackPage({Key key, this.music, this.musics, this.audioPlayer, this.setMusic}) : super(key: key);
  @override
  _AudioPlaybackPageState createState() => _AudioPlaybackPageState();
}

class _AudioPlaybackPageState extends State<AudioPlaybackPage>  {
  AudioPlayer _audioPlayer;
  Duration _duration;
  Duration _position;

  StreamSubscription _durationSubscription;
  StreamSubscription _positionSubscription;
  StreamSubscription _playerCompleteSubscription;
  StreamSubscription _playerErrorSubscription;
  StreamSubscription _playerStateSubscription;

  _initAudioPlayer(musics, music) {
    print('init==========');
    // var mode = PlayerMode.MEDIA_PLAYER;
    // widget.audioPlayer;
    // _audioPlayer = AudioPlayer(mode: mode);
    _audioPlayer = widget.audioPlayer;
    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
      // setState(() => {
      //   _duration = duration
      // });
      context.read<AudioDurationCubit>().setDuration(duration);

      if (Theme.of(context).platform == TargetPlatform.iOS) {
        _audioPlayer.startHeadlessService();
        _audioPlayer.setNotification(
            title: 'App Name',
            artist: 'Artist or blank',
            albumTitle: 'Name or blank',
            imageUrl: 'url or blank',
            forwardSkipInterval: const Duration(seconds: 30),
            backwardSkipInterval: const Duration(seconds: 30),
            duration: duration,
            elapsedTime: Duration(seconds: 0)
        );
      }
    });
    // 监听进度
    _positionSubscription = _audioPlayer.onAudioPositionChanged.listen((p) => setState(() {
      print("监听进度...");
      // _position = p;
      context.read<AudioPositionCubit>().setPosition(p);
    }));

    // 监听报错
    _playerErrorSubscription = _audioPlayer.onPlayerError.listen((msg) {
      print("监听报错");
      print('audioPlayer error : $msg');
      // setState(() {
      //   _duration = Duration(seconds: 0);
      //   _position = Duration(seconds: 0);
      // });
      context.read<AudioDurationCubit>().setDuration(Duration(seconds: 0));
      context.read<AudioPositionCubit>().setPosition(Duration(seconds: 0));
    });
    // 播放状态改变
    _audioPlayer.onPlayerStateChanged.listen((state) {
      print("播放状态改变");
      if (!mounted) return;
      // setState(() {
      //
      // });
    });
    // IOS中来自通知区域得玩家状态变化流
    _audioPlayer.onNotificationPlayerStateChanged.listen((state) {
      if (!mounted) return;
    });
  }

  void _play(Music music) async {
    // widget.music = music;
    final playPosition = (_position != null &&
        _duration != null &&
        _position.inMilliseconds > 0 &&
        _position.inMilliseconds < _duration.inMilliseconds)
        ? _position
        : null;
    var url = '';
    if (music.mp3Rid != '') {
      var mp3Rid = music.mp3Rid;
      url = 'http://antiserver.kuwo.cn/anti.s?rid=$mp3Rid&response=res&format=mp3|aac&type=convert_url&br=320kmp3&agent=iPhone&callback=getlink&jpcallback=getlink.mp3';
    }
    print('开始播放' + url);
    final result = await _audioPlayer.play(url, position: playPosition);
    print(result);
    if (result == 1) {
      print(result);
    }
    _audioPlayer.setPlaybackRate(playbackRate: 1.0);
  }

  void _stop() async {
    print("停止");
    final result = await _audioPlayer.stop();
    if (result == 1) {
      // setState(() {
      //   _position = Duration();
      // });
      context.read<AudioPositionCubit>().setPosition(Duration());
    }
  }

  void _pause() async {
    print("暂停");
    final result = await _audioPlayer.pause();
    if (result == 1) {
      print("success");
    }
  }

  var _positionText = '',
      _durationText = '';

  @override
  void initState() {
    super.initState();
    print('init=====x=====');
    _initAudioPlayer(list2, playMusicRun);
  }

  @override
  void dispose() {
    // _audioPlayer.dispose();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    // _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 播放完成
    _playerCompleteSubscription = _audioPlayer.onPlayerCompletion.listen((event) {
      print("播放完成");
      // setState(() {
      //   _position = Duration();
      // });
      context.read<AudioPositionCubit>().setPosition(Duration());
      // var musics = context.read<AudioMusicsCubit>();
      var musics = BlocProvider.of<AudioMusicsCubit>(context).getMusics();
      var music = context.read<AudioMusicCubit>().getMusic();
      var nextIndex = 0;
      var index = 0;
      musics.forEach((element) {
        index++;
        if (element.mp3Rid == music.mp3Rid) {
          nextIndex = index;
        }
      });
      if (musics.length == nextIndex) {
        nextIndex = 0;
      }
      print('musics');
      // print(widget.musics);
      print(nextIndex);
      // _play(widget.musics[nextIndex]);
      context.read<AudioMusicCubit>().setMusic(musics[nextIndex]);
      // context.read<And>().increment(2);
      // widget.setMusic(widget.musics[nextIndex]);
    });
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        children: <Widget>[
          BlocBuilder<AudioDurationCubit, Duration>(
            builder: (context, _duration) =>
            BlocBuilder<AudioPositionCubit, Duration>(
              builder:  (context, _position) => Column(
                children: <Widget>[
                  BlocBuilder<AudioMusicCubit, Music>(
                    builder: (context, music) => new Text(
                      music.name,
                    ),
                  ),
                  Text(
                    _position != null
                        ? '${_positionText ?? ''} / ${_durationText ?? ''}'
                        : _duration != null ? _durationText : '',
                  ),
                  Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Stack(
                        children: [
                          Slider(
                            onChanged: (v) {
                              // ignore: non_constant_identifier_names
                              final Position = v * _duration.inMilliseconds;
                              _audioPlayer.seek(Duration(milliseconds:  Position.round()));
                            },
                            value: (_position != null &&
                                _duration !=null &&
                                _position.inMilliseconds > 0 &&
                                _position.inMilliseconds < _duration.inMilliseconds)
                                ? _position.inMilliseconds / _duration.inMilliseconds
                                : 0.0,
                          ),
                        ],
                      )
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(icon: Icon(Icons.play_arrow), onPressed: () {
                        _play(playMusicRun);
                      }),
                      IconButton(icon: Icon(Icons.pause), onPressed: () {
                        _pause();
                      }),
                      IconButton(icon: Icon(Icons.stop), onPressed: () {
                        _stop();
                      })
                    ],
                  ),
                ]
              )
            )
          )
        ]
      )// bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

}
