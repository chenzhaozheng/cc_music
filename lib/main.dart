import 'dart:convert';
// import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cc_music/audio_cubit.dart';
import 'package:cc_music/audio_duration_cubit.dart';
import 'package:cc_music/audio_music_cubit.dart';
import 'package:cc_music/audio_musics_cubit.dart';
import 'package:cc_music/audio_position_cubit.dart';
import 'package:cc_music/common/audio.dart';
import 'package:cc_music/music/music_list.dart';
import 'package:cc_music/music_cubit.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:cc_music/common/music.dart';
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

// class ShareDataWidget extends InheritedWidget {
//   ShareDataWidget({
//     @required this.data,
//     @required this.url,
//     // @required this._duration,
//     // @required this._position,
//     // @required this._audioPlayer
//     Widget child
//   }) :super(child: child);
//
//   final int data; //需要在子树中共享的数据，保存点击次数
//   String url;
//   //定义一个便捷方法，方便子树中的widget获取共享数据
//   static ShareDataWidget of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
//   }
//
//   //该回调决定当data发生变化时，是否通知子树中依赖data的Widget
//   @override
//   bool updateShouldNotify(ShareDataWidget old) {
//     //如果返回true，则子树中依赖(build函数中有调用)本widget
//     //的子widget的`state.didChangeDependencies`会被调用
//     return old.data != data;
//   }
// }

var list2 = <Music>[
  new Music(name: 'I will carry you'),
  new Music(name: '你不是真正的快乐'),
];
Music playMusicRun = new Music();

class AudioPlayHomePage extends StatefulWidget {
  // AudioPlayHomePage(int count);
  @override
  _AudioPlayHomePageState createState() => _AudioPlayHomePageState();
}

class _AudioPlayHomePageState extends State with SingleTickerProviderStateMixin {

  final TextEditingController _controller = new TextEditingController();
  TabController _tabController; //需要定义一个Controller
  List tabs = ["我的", "发现", "视频"];
  List<Music> _playMusicList = new List<Music>();
  var list2 = <Music>[];


  _getMusics(content) async {
    var url = 'https://search.kuwo.cn/r.s?all=$content&ft=music&itemset=web_2013&client=kt&pn=0&rn=20&rformat=json&encoding=utf8';
    print(url);
    String result;
    try {
      var response = await Dio().get(url,
        options: Options(
            responseType: ResponseType.json
        ),
      );
      try{
        // ignore: non_constant_identifier_names
        var JSON = new JsonCodec();
        Map<String, dynamic> data2 = JSON.decode(response.data.replaceAll("'",'"'));
        setState(() {
          list2 = [];
        });
        for (var da in data2['abslist']) {
          setState(() {
            list2.add(new Music(name: da['NAME'], mp3Rid: da['MP3RID'], headImg: da['hts_MVPIC']));
          });
        }
      } catch(e) {
        print("Error: $e");
      }
    } catch (exception) {
      print(exception);
      result = 'Failed getting IP address';
    }
  }
  // @override
  // void initState() {
  //   super.initState();
  //   // final Music music = this.music;
  //   var music = widget.music;
  //   var mp3Rid = music.mp3Rid;
  //   var musics = widget.musics;
  //   url = 'http://antiserver.kuwo.cn/anti.s?rid=${mp3Rid}&response=res&format=mp3|aac&type=convert_url&br=320kmp3&agent=iPhone&callback=getlink&jpcallback=getlink.mp3';
  //   // url = 'http://ip.h5.nf01.sycdn.kuwo.cn/763ad5cfc60ec39ae50a6f285994397d/5f77503a/resource/n2/75/78/1887355251.mp3';
  //   print(url);
  //   _initAudioPlayer(musics, music);
  // }

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      print('fuck you init state.');
      print(_controller.text);
      _getMusics(_controller.text).then((res) => {
        print(res)
        // list2.push()
      });
    });
    _tabController = TabController(
        vsync: this,
        length: tabs.length
    );
    _tabController.addListener((){
      switch(_tabController.index){
      //   case 1: ...;
      // case 2: ... ;
      }
    });
    _playMusicList.add(
        new Music(
          name: '盛夏光年',
          mp3Rid: 'MP3_75712216',
          headImg: 'https://img4.kuwo.cn/wmvpic/324/9/5/3351076170.jpg',
          isPlay: false,
        )
    );
    playMusicRun = new Music(name: 'music');


    // url = 'http://antiserver.kuwo.cn/anti.s?rid=${mp3Rid}&response=res&format=mp3|aac&type=convert_url&br=320kmp3&agent=iPhone&callback=getlink&jpcallback=getlink.mp3';
    // // url = 'http://ip.h5.nf01.sycdn.kuwo.cn/763ad5cfc60ec39ae50a6f285994397d/5f77503a/resource/n2/75/78/1887355251.mp3';
    // print(url);

    // _initAudioPlayer(musics, music);
  }


  @override
  Widget build(BuildContext context) {

    void _handleChanged(Music music, bool inPlayMusicList) {
      var isRepeat = false;
      var index = 0;
      _playMusicList.forEach((element) {
        if (element.mp3Rid == music.mp3Rid) {
          isRepeat = true;
        }
        index++;
      });
      setState(() {
        playMusicRun = music;
        if (!isRepeat)
          if (inPlayMusicList)
            _playMusicList.add(music);
          else
            _playMusicList.remove(music);
      });
      context.read<AudioMusicsCubit>().setMusics(_playMusicList);
      context.read<AudioMusicCubit>().setMusic(music);
      // context.read()<context>
    }
    var mp3Rid = playMusicRun.mp3Rid;
    var url = 'http://antiserver.kuwo.cn/anti.s?rid=$mp3Rid&response=res&format=mp3|aac&type=convert_url&br=320kmp3&agent=iPhone&callback=getlink&jpcallback=getlink.mp3';
    // var music = widget.music;
    // var musics = widget.musics;
    // var music = list2[0];
    // var mp3Rid = music.mp3Rid;
    // var musics = list2;
    // return BlocListener<MusicCubit>


    return new MaterialApp(
        title: 'test1',
        home: Scaffold(
          appBar: AppBar(
            title: new Text("Music"),
            bottom: TabBar(
              controller: _tabController,
              tabs: tabs.map((e) => Tab(text: e)).toList()
            )
          ),
          body: Scrollbar(
            child: TabBarView(
                controller: _tabController,
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        pinned: true,
                        expandedHeight: 250.0,
                        flexibleSpace: FlexibleSpaceBar(
                          title:  new TextField(
                            controller: _controller,
                            decoration:  new InputDecoration(
                                hintText: 'search music'
                            ),
                          ),
                          background: Image.asset(
                            "images/zhizu.jpg", fit: BoxFit.cover,),
                        ),
                      ),
                      new SliverFixedExtentList(
                        itemExtent: 50.0,
                        delegate: new SliverChildBuilderDelegate(
                                (BuildContext context, int index) {
                                return new Container(
                                    child: new MusicListItem(
                                      music: list2[index],
                                      inPlayMusicList: _playMusicList.contains(list2[index]),
                                      onChanged: _handleChanged,
                                    )
                                );
                            },
                            childCount: list2.length //50个列表项
                        ),
                      ),
                    ],
                  ),
                  new ListTile(
                    title: new Text('我不愿让你一个人'),
                    subtitle: new Text('五月天'),
                    leading: new Icon(
                        Icons.theaters,
                        color: Colors.blue[500]
                    ),
                  ),
                  // new ListTile(
                  //   title: new Text('我不愿让你一个人'),
                  //   subtitle: new Text('五月天'),
                  //   leading: new Icon(
                  //       Icons.theaters,
                  //       color: Colors.blue[500]
                  //   ),
                  // ),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Stack(
                        children: [
                          BlocBuilder<MusicCubit, int>(
                            builder: (context, count) => Center(child: Text('$count')),
                          ),
                          BlocBuilder<AudioCubit, AudioPlayer>(
                            builder: (context, x) => Center(child: Text('xx')),
                          ),
                          FloatingActionButton(
                            child: const Icon(Icons.add),
                            onPressed: () => context.read<MusicCubit>().increment(2),
                          )
                        ]
                    )
                  ),
                ]
            ),
          ),
          bottomNavigationBar: new Audio(
            url,
            _playMusicList
          ),
          // bottomNavigationBar: new Audio(),
        ),
    );
  }
}

void main() {
  // initPlatformState();
  // runApp(new MaterialApp(
  //   title: 'test1',
  //   home: Scaffold(
  //     appBar: AppBar(
  //       title: Text("test2"),
  //     ),
  //     body: BlocBuilder<MusicCubit, int>(
  //       // child: ShareDataWidget(
  //       //   child: new AudioPlayHomePage()
  //       // ),
  //       builder: (context, count) => Center(child: new AudioPlayHomePage(count))
  //     )
  //   )
  // ));
  runApp(MultiBlocProvider(
      providers: [
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
        )
      ],
      child: new AudioPlayHomePage()
  ));
}

Future<void> initPlatformState() async {
  try {
    // print("initPlatformState");
    // await FlutterPlugin.initialize();
  } on PlatformException {
  }
}