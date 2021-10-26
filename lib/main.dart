import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:cc_music/bloc/audio_cubit.dart';
import 'package:cc_music/bloc/audio_duration_cubit.dart';
import 'package:cc_music/bloc/audio_love_musics_cubit.dart';
import 'package:cc_music/bloc/audio_music_cubit.dart';
import 'package:cc_music/bloc/audio_music_state.dart';
import 'package:cc_music/bloc/audio_musics_cubit.dart';
import 'package:cc_music/bloc/audio_position_cubit.dart';
import 'package:cc_music/bloc/audio_state.dart';
import 'package:cc_music/bloc/audio_status_cubit.dart';
import 'package:cc_music/bloc/music_cubit.dart';
import 'package:cc_music/common/audio.dart';
import 'package:cc_music/common/music.dart';
import 'package:cc_music/music/index_page.dart';
import 'package:cc_music/music/music_list_page.dart';
import 'package:cc_music/post.dart';
import 'package:cc_music/video/video_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/audio_search_musics_cubit.dart';
import 'common/search_delegate.dart';
import 'common/search_icon.dart';

var list2 = <Music>[];
Music playMusicRun = Music();

class AudioPlayHomePage extends StatefulWidget {
  const AudioPlayHomePage({Key key}) : super(key: key);

  @override
  _AudioPlayHomePageState createState() => _AudioPlayHomePageState();
}

class _AudioPlayHomePageState extends State<AudioPlayHomePage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  TabController _tabController; //// 需要定义一个Controller
  List tabs = ["我的", "发现", "视频"];
  List<Music> _playMusicList = List<Music>();
  var searchContent = '';
  var listPage = 0;
  ScrollController _scrollController = ScrollController();

  StreamSubscription _durationSubscription;
  StreamSubscription _positionSubscription;
  StreamSubscription _playerErrorSubscription;
  StreamSubscription _playerStateSubscription;

  // 响应空白处的焦点的Node
  FocusNode blankNode = FocusNode();
  // FocusNode listNode = FocusNode(debugLabel: )
  FocusNode focusNode = FocusNode();

  _initAudioPlayer(musics, music) {
    AudioPlayer _audioPlayer = context.read<AudioCubit>().state.audioPlayer;

    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
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
            elapsedTime: Duration(seconds: 0));
      }
    });
    // 监听进度
    _positionSubscription = _audioPlayer.onAudioPositionChanged.listen(
        // (p) => setState(() {
        //   context.read<AudioPositionCubit>().setPosition(p);
        // })
        (p) => {context.read<AudioPositionCubit>().setPosition(p)});

    // 监听报错
    _playerErrorSubscription = _audioPlayer.onPlayerError.listen((msg) {
      print("监听报错");
      print('audioPlayer error : $msg');
      context.read<AudioDurationCubit>().setDuration(Duration(seconds: 0));
      context.read<AudioPositionCubit>().setPosition(Duration(seconds: 0));
    });
    // 播放状态改变
    _audioPlayer.onPlayerStateChanged.listen((state) {
      print("播放状态改变");
      print(state);
      print(state.toString());
      if (state.toString() == "AudioPlayerState.COMPLETED") {
        context.read<AudioCubit>().nextPlay(context);
      }
      BlocProvider.of<AudioStatusCubit>(context).setValue(state.toString());
      print(mounted);
      print("播放状态改变 end");
      if (!mounted) return;
    });
    // IOS中来自通知区域得玩家状态变化流
    _audioPlayer.onNotificationPlayerStateChanged.listen((state) {
      if (!mounted) return;
    });
  }

  _getMusics(content) async {
    var url =
        //&ft=music&client=kt&itemset=web_2013
        //callback=searchMusicResult&
        'http://search.kuwo.cn/r.s?all=$content&ft=music&client=kt&cluster=0&pn=${listPage}&rn=20&rformat=json&encoding=utf8&vipver=MUSIC_8.0.3.1&';
    // 'https://search.kuwo.cn/r.s?all=$content&pn=${listPage}&rn=20&rformat=json&encoding=utf8';
    print(url);
    String result;
    try {
      var response = await Dio().get(
        url,
        options: Options(responseType: ResponseType.json),
      );
      try {
        // ignore: non_constant_identifier_names
        var JSON = JsonCodec();
        Map<String, dynamic> data2 =
            JSON.decode(response.data.replaceAll("'", '"'));
        for (var da in data2['abslist']) {
          print(da);
          final name = da['NAME'].replaceAll('&nbsp;', '');
          final artist = da['ARTIST'].replaceAll('&nbsp;', '');
          setState(() {
            list2.add(Music(
                name: name,
                mp3Rid: da['MP3RID'],
                headImg: da['hts_MVPIC'],
                artist: artist));
          });
        }
      } catch (e) {
        print("Error: $e");
      }
    } catch (exception) {
      print(exception);
      result = 'Failed getting IP address';
    }
  }

  _getCounter() async {
    // 初始化存储信息，获取存储的喜欢的音乐存储到对应的bloc
    final prefs = await SharedPreferences.getInstance();
    final counter = prefs.getString('counter') ?? '';
    print('getCounter');
    print(counter);
    if (counter != '') {
      var listMap = jsonDecode(counter);
      print(listMap);
      // print(listMap[0]);
      List<Music> listMap2 =
          List<Music>.from(listMap.map((model) => Music.fromJson(model)));
      // List<Post> posts =
      //     List<Post>.from(l.map((model) => Post.fromJson(model)));
      // List<Music> listMap = new List<Music>.from(listDynamic);
      BlocProvider.of<AudioLoveMusicsCubit>(context).setMusics(listMap2);
    }
  }

  @override
  Future<void> initState() {
    super.initState();
    _controller.addListener(() {
      print(_controller.text);
      setState(() {
        list2 = [];
        searchContent = _controller.text;
        listPage = 0;
      });
      _getMusics(_controller.text).then((res) => {
            print(res)
            // list2.push()
          });
      focusNode.unfocus();
    });
    _tabController = TabController(vsync: this, length: tabs.length);
    _tabController.addListener(() {
      print('==start==');
      print(_tabController.index);
      print('==end==');
      switch (_tabController.index) {
      }
    });
    _playMusicList.add(Music(
      name: '盛夏光年',
      mp3Rid: 'MP3_75712216',
      headImg: 'https://img4.kuwo.cn/wmvpic/324/9/5/3351076170.jpg',
      isPlay: false,
    ));
    playMusicRun = Music(name: 'music');

    _scrollController.addListener(() {
      print('scroll ...');
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        setState(() {
          listPage = listPage + 1;
        });
        // _getMore();
        _getMusics(searchContent);
      }
    });

    _initAudioPlayer(list2, playMusicRun);

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        print('得到焦点');
      } else {
        print('失去焦点');
      }
    });
    // 初始化存储信息，获取存储的喜欢的音乐存储到对应的bloc
    _getCounter();
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      home: SearchIcon(),
    );
  }
}

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<MusicCubit>(
      create: (context) => MusicCubit(),
    ),
    BlocProvider<AudioCubit>(
      create: (context) => AudioCubit(),
    ),
    BlocProvider<AudioMusicsCubit>(
      create: (context) => AudioMusicsCubit(),
    ),
    BlocProvider<AudioMusicCubit>(
      create: (context) => AudioMusicCubit(),
    ),
    BlocProvider<AudioDurationCubit>(
      create: (context) => AudioDurationCubit(),
    ),
    BlocProvider<AudioPositionCubit>(
      create: (context) => AudioPositionCubit(),
    ),
    BlocProvider<AudioStatusCubit>(
      create: (context) => AudioStatusCubit(),
    ),
    BlocProvider<AudioSearchMusicsCubit>(
      create: (context) => AudioSearchMusicsCubit(),
    ),
    BlocProvider<AudioLoveMusicsCubit>(
      create: (context) => AudioLoveMusicsCubit(),
    ),
  ], child: AudioPlayHomePage()));
}

Future<void> initPlatformState() async {
  try {} on PlatformException {}
}
