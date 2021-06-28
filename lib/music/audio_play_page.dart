import 'package:cc_music/bloc/audio_cubit.dart';
import 'package:cc_music/bloc/audio_duration_cubit.dart';
import 'package:cc_music/bloc/audio_music_cubit.dart';
import 'package:cc_music/bloc/audio_music_state.dart';
import 'package:cc_music/bloc/audio_position_cubit.dart';
import 'package:cc_music/bloc/audio_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AudioPlaybackPage extends StatefulWidget {
  final musics;
  final music;
  final audioPlayer;
  final setMusic;

  const AudioPlaybackPage(
      {Key key, this.music, this.musics, this.audioPlayer, this.setMusic})
      : super(key: key);

  @override
  _AudioPlaybackPageState createState() => _AudioPlaybackPageState();
}

class _AudioPlaybackPageState extends State<AudioPlaybackPage> {
  // AudioPlayer _audioPlayer;
  // Duration _duration;
  // Duration _position;
  //
  // StreamSubscription _durationSubscription;
  // StreamSubscription _positionSubscription;
  //
  // StreamSubscription _playerErrorSubscription;
  // StreamSubscription _playerStateSubscription;

  // _initAudioPlayer(musics, music) {
  //   _audioPlayer = widget.audioPlayer;
  //   context.read<PlayCubit>().state.init2(_audioPlayer);
  //   // context.read<PlayCubit>().state..(_audioPlayer);
  //
  //   _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
  //     context.read<AudioDurationCubit>().setDuration(duration);
  //     if (Theme.of(context).platform == TargetPlatform.iOS) {
  //       _audioPlayer.startHeadlessService();
  //       _audioPlayer.setNotification(
  //           title: 'App Name',
  //           artist: 'Artist or blank',
  //           albumTitle: 'Name or blank',
  //           imageUrl: 'url or blank',
  //           forwardSkipInterval: const Duration(seconds: 30),
  //           backwardSkipInterval: const Duration(seconds: 30),
  //           duration: duration,
  //           elapsedTime: Duration(seconds: 0));
  //     }
  //   });
  //   // 监听进度
  //   _positionSubscription =
  //       _audioPlayer.onAudioPositionChanged.listen((p) => setState(() {
  //             print("监听进度...$p");
  //             // _position = p;
  //             // print(p);
  //             context.read<AudioPositionCubit>().setPosition(p);
  //           }));
  //
  //   // 监听报错
  //   _playerErrorSubscription = _audioPlayer.onPlayerError.listen((msg) {
  //     print("监听报错");
  //     print('audioPlayer error : $msg');
  //     // setState(() {
  //     //   _duration = Duration(seconds: 0);
  //     //   _position = Duration(seconds: 0);
  //     // });
  //     context.read<AudioDurationCubit>().setDuration(Duration(seconds: 0));
  //     context.read<AudioPositionCubit>().setPosition(Duration(seconds: 0));
  //   });
  //   // 播放状态改变
  //   _audioPlayer.onPlayerStateChanged.listen((state) {
  //     print("播放状态改变");
  //     if (!mounted) return;
  //   });
  //   // IOS中来自通知区域得玩家状态变化流
  //   _audioPlayer.onNotificationPlayerStateChanged.listen((state) {
  //     if (!mounted) return;
  //   });
  // }

  // void _pause() async {
  //   print("暂停");
  //   final result = await _audioPlayer.pause();
  //   if (result == 1) {
  //     print("success");
  //   }
  // }

  // var _positionText = '', _durationText = '';

  @override
  void initState() {
    super.initState();
    // _initAudioPlayer(list2, playMusicRun);
  }

  // @override
  // void dispose() {
  //   // _audioPlayer.dispose();
  //   _durationSubscription?.cancel();
  //   _positionSubscription?.cancel();
  //   // _playerCompleteSubscription?.cancel();
  //   _playerErrorSubscription?.cancel();
  //   _playerStateSubscription?.cancel();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    // 立即停止
    // void _stop() async {
    //   print("停止");
    //   final result = await _audioPlayer.stop();
    //   if (result == 1) {
    //     // setState(() {
    //     //   _position = Duration();
    //     // });
    //     context.read<AudioPositionCubit>().setPosition(Duration());
    //   }
    // }

    // 播放
    // void _play(Music music) async {
    //   // context.read<PlayCubit>()._play();
    //   // widget.music = music;
    //   final playPosition = (_position != null &&
    //           _duration != null &&
    //           _position.inMilliseconds > 0 &&
    //           _position.inMilliseconds < _duration.inMilliseconds)
    //       ? _position
    //       : null;
    //   var url = '';
    //   if (music.mp3Rid != '') {
    //     var mp3Rid = music.mp3Rid;
    //     url =
    //         'http://antiserver.kuwo.cn/anti.s?rid=$mp3Rid&response=res&format=mp3|aac&type=convert_url&br=320kmp3&agent=iPhone&callback=getlink&jpcallback=getlink.mp3';
    //   }
    //   print('开始播放' + url);
    //   final result = await _audioPlayer.play(url, position: playPosition);
    //   print(result);
    //   if (result == 1) {
    //     print(result);
    //   }
    //   _audioPlayer.setPlaybackRate(playbackRate: 1.0);
    // }

    // 播放完成

    // 图片部分
    Widget imgSection = BlocBuilder<AudioMusicCubit, AudioMusicState>(
        builder: (context, musicState) => Container(
            child: Image.network(
                (musicState.music.headImg != null
                    ? musicState.music.headImg
                    : 'images/zhizu.jpg'),
                width: 600.0,
                height: 240.0,
                fit: BoxFit.cover)));

    Widget introSection = BlocBuilder<AudioMusicCubit, AudioMusicState>(
        builder: (context, musicState) => Container(
              child: Row(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        musicState.music.name != null
                            ? musicState.music.name
                            : '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30.0)),
                    Text(musicState.music.artist != null
                        ? musicState.music.artist
                        : ''),
                    Text('Love -- '),
                  ],
                )
              ]),
            ));

    // 播放进度
    Widget processing = Container(
        child: BlocBuilder<AudioDurationCubit, Duration>(
            builder: (context, _duration) => BlocBuilder<AudioPositionCubit,
                    Duration>(
                builder: (context, _position) => Column(

                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Slider(
                            onChanged: (v) {
                              // ignore: non_constant_identifier_names
                              final Position = v * _duration.inMilliseconds;
                              context
                                  .read<AudioCubit>()
                                  .seek(context, Position);
                            },
                            value: (_position != null &&
                                    _duration != null &&
                                    _position.inMilliseconds > 0 &&
                                    _position.inMilliseconds <
                                        _duration.inMilliseconds)
                                ? _position.inMilliseconds /
                                    _duration.inMilliseconds
                                : 0.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _position != null
                                    ? '${_position ?? ''}'
                                    : _duration != null ? _duration : '',
                              ),
                              Text(
                                _position != null
                                    ? '${_duration ?? ''}'
                                    : _duration != null ? _duration : '',
                              ),
                            ],
                          )
                        ]))));

    // 播放按钮
    Widget videoSection = Container(
        child: BlocBuilder<AudioCubit, AudioState>(
      builder: (context, _audioPlayer) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
              icon: Icon(Icons.first_page),
              onPressed: () {
                context.read<AudioCubit>().lastPlay(context);
              }),
          BlocBuilder<AudioMusicCubit, AudioMusicState>(
              builder: (context, musicState) => IconButton(
                  icon: Icon(Icons.play_arrow),
                  onPressed: () {
                    context.read<AudioCubit>().play(context, musicState.music);
                  })),
          IconButton(
              icon: Icon(Icons.pause),
              onPressed: () {
                context.read<AudioCubit>().pause(context);
              }),
          IconButton(
              icon: Icon(Icons.last_page),
              onPressed: () {
                context.read<AudioCubit>().nextPlay(context);
              })
        ],
      ),
    ));

    return Scaffold(
        // appBar: AppBar(),
        body: Container(
      padding: EdgeInsets.all(24.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            imgSection,
            introSection,
            processing,
            videoSection
          ]),
    ));
  }
}
