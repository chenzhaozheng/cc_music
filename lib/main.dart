import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io';
import 'package:dio/dio.dart';

List<Widget> list = <Widget>[
  new ListTile(
    title: new Text('我不愿让你一个人'),
    subtitle: new Text('五月天'),
    leading: new Icon(
        Icons.theaters,
        color: Colors.blue[500]
    ),
  ),
];
var list2 = <Music>[
  new Music(name: 'I will carry you'),
  new Music(name: '你不是真正的快乐'),
];
class Music {
  const Music({this.name, this.mp3Rid, this.headImg, this.isPlay = false});
  final String name;
  final String mp3Rid;
  final String headImg;
  final bool isPlay;
}

typedef void ChangedCallback(Music music, bool inPlayMusicList);

class MusicListItem extends StatelessWidget {
  MusicListItem({Music music, this.inPlayMusicList, this.onChanged})
    : music = music,
      super(key: new ObjectKey(music));
  final Music music;
  final bool inPlayMusicList;
  final ChangedCallback onChanged;
  TextStyle _getTextStyle(BuildContext context) {
    if (!inPlayMusicList) return null;
    return new TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }
  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () {
        print('===');
        print(music);
        print('====');
        print(inPlayMusicList);
        onChanged(music, !inPlayMusicList);
      },
      leading: new CircleAvatar(
        backgroundColor: Colors.black54,
        child: new Text(music.name[0]),
      ),
      title: new Text(music.name, style: _getTextStyle(context))
    );
  }
}

class AudioPlayHomePage extends StatefulWidget {
  @override
  _AudioPlayHomePageState createState() => _AudioPlayHomePageState();
}

class _AudioPlayHomePageState extends State with SingleTickerProviderStateMixin {
  final TextEditingController _controller = new TextEditingController();

  TabController _tabController; //需要定义一个Controller
  List tabs = ["我的", "发现", "视频"];
  var list2 = <Music>[];
  _getMusics(content) async {
    var url = 'https://search.kuwo.cn/r.s?all=${content}&ft=music&itemset=web_2013&client=kt&pn=0&rn=20&rformat=json&encoding=utf8';
    print(url);
    String result;
    try {
      var response = await Dio().get(url,
        options: Options(
            responseType: ResponseType.json
        ),
      );
      try{
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

  Set<Music> _musicList = new Set<Music>();
  List<Music> _playMusicList = new List<Music>();
  Set<Music> _playMusic = new Set<Music>();
  Music playMusicRun = new Music();

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
  }
  // _playMusicList.add({
  //   name: '盛夏光年',
  //   mp3Rid: 'MP3_75712216',
  //   headImg: 'https://img4.kuwo.cn/wmvpic/324/9/5/3351076170.jpg'
  // });

  void _handleChanged(Music music, bool inPlayMusicList) {
    var isRepeat = false;
    var index = 0;
    _playMusicList.forEach((element) {
      if (element.mp3Rid == music.mp3Rid) {
        isRepeat = true;
      }
      // if (playMusicRun.mp3Rid == element.mp3Rid) {
      //   _playMusicList[index].isPlay = true;
      // }
      index++;
    });
    setState(() {
      playMusicRun = music;
      print('playMusicRun');
      print(playMusicRun);
      print(playMusicRun.name);
      if (!isRepeat)
        if (inPlayMusicList)
          _playMusicList.add(music);
        else
          _playMusicList.remove(music);
    });
  }

  @override
  Widget build(BuildContext context) {
    Row buildButtonColumn(IconData icon, String label, url) {
      Color color = Theme.of(context).primaryColor;
      return new Row(
        children: <Widget>[
          new Icon(icon, color: color),
          new Container(
              child: new IconButton(
                icon: new Text(
                  label,
                  style: new TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: color,
                  ),
                ),
                onPressed: () {
                  print('url');
                  print(url);
                  Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) =>
                      new MusicsListScreen(
                          // musics: url,
                        musics: url,
                      )
                    ),
                  );
                },
              ),
          )
        ],
      );
    }
    Widget _buildBottomNavigationBar(){
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: SizedBox(
            height: 54.0,
            child: Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(),
              margin: EdgeInsets.all(0.0),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child:  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new IconButton(
                        icon:new ClipOval(
                          // child: Image.asset(_playMusicList.toList()[_playMusicList.toList().length - 1].headImg,
                          //   fit: BoxFit.cover,
                          // ),
                          child: Image.asset('images/zhizu.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        // color: Colors.red[500],
                        onPressed: () {
                          // _playMusic.add(_playMusicList.toList()[_playMusicList.toList().length - 1]);
                          Navigator.push(
                            context,
                            new MaterialPageRoute(builder: (context) => new SecondScreen(
                              // music: _playMusicList.toList()[_playMusicList.toList().length - 1],
                              music: playMusicRun,
                              musics: _playMusicList,
                            )),
                          );
                        },
                      ),
                      new Expanded(
                        child:  new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                // padding: const EdgeInsets.only(bottom: 8.0),
                                child: new Text(
                                  // _playMusicList.toList()[_playMusicList.toList().length - 1].name,
                                  playMusicRun.name,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              new Text(
                                  '横滑可切换上下首',
                                  style: new TextStyle(
                                    color: Colors.grey[500],
                                  )
                              ),
                            ]
                        ),
                      ),
                      // buildButtonColumn(Icons.play_arrow, '', ''),
                      buildButtonColumn(Icons.list, '', _playMusicList)
                    ]
                  //  buildButtonColumn(Icons.list, 'SHARE')
                ),
              ),
            ),
          ),
        ),
      );
    }
    return new Scaffold(
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
              // Wrap(
              //   spacing: 8.0, // 主轴(水平)方向间距
              //   runSpacing: 4.0, // 纵轴（垂直）方向间距
              //   alignment: WrapAlignment.center, //沿主轴方向居中
              //   children: [
              //     Padding(
              //       padding: EdgeInsets.all(12.0),
              //       child: new TextField(
              //         controller: _controller,
              //         decoration:  new InputDecoration(
              //             hintText: 'search music'
              //         ),
              //       ),
              //     ),
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 250.0,
                    flexibleSpace: FlexibleSpaceBar(
                      // title: const Text('Demo'),
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
                          //创建列表项
                          // return new Container(
                          //   alignment: Alignment.center,
                          //   color: Colors.lightBlue[100 * (index % 9)],
                          //   child: new Text('list item $index'),
                          // );
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
              new ListTile(
                title: new Text('我不愿让你一个人'),
                subtitle: new Text('五月天'),
                leading: new Icon(
                    Icons.theaters,
                    color: Colors.blue[500]
                ),
              ),
            ]
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}

class AudioPlaybackPage extends StatefulWidget {
  final musics;
  final music;
  const AudioPlaybackPage({Key key, this.music, this.musics}) : super(key: key);
  @override
  _AudioPlaybackPageState createState() => _AudioPlaybackPageState();
}

class _AudioPlaybackPageState extends State<AudioPlaybackPage> {
  // Music music;
  String url;
  PlayerMode mode;

  AudioPlayer _audioPlayer;

  Duration _duration;
  Duration _position;
  StreamSubscription _durationSubscription;
  StreamSubscription _positionSubscription;
  StreamSubscription _playerCompleteSubscription;
  StreamSubscription _playerErrorSubscription;
  StreamSubscription _playerStateSubscription;

  get _durationText => _duration?.toString()?.split('.')?.first ?? '';
  get _positionText => _duration?.toString()?.split('.')?.first ?? '';

  @override
  void initState() {
    super.initState();
    // final Music music = this.music;
    var music = widget.music;
    var mp3Rid = music.mp3Rid;
    var musics = widget.musics;
    url = 'http://antiserver.kuwo.cn/anti.s?rid=${mp3Rid}&response=res&format=mp3|aac&type=convert_url&br=320kmp3&agent=iPhone&callback=getlink&jpcallback=getlink.mp3';
    // url = 'http://ip.h5.nf01.sycdn.kuwo.cn/763ad5cfc60ec39ae50a6f285994397d/5f77503a/resource/n2/75/78/1887355251.mp3';
    _initAudioPlayer(musics, music);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
    super.dispose();
  }

  _initAudioPlayer(musics, music) {
    mode = PlayerMode.MEDIA_PLAYER;
    // init
    _audioPlayer = AudioPlayer(mode: mode);
    _durationSubscription = _audioPlayer.onDurationChanged.listen((duration) {
      setState(() => {
        _duration = duration
      });
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        // _audioPlayer.startHea
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
      _position = p;
    }));
    // 播放完成
    _playerCompleteSubscription = _audioPlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _position = Duration();
      });


      //
      // _playMusicList.forEach((element) {
      //   if (element.mp3Rid == music.mp3Rid) {
      //     isRepeat = true;
      //   }
      //   index++;
      // });
      //
      var index = 0;
      var nextIndex = 0;
      musics.forEach((element) {
        if (element.mp3Rid == music.mp3Rid) {
          nextIndex = index + 1;
        }
        index++;
      });
      print('播放完成=');
      print(nextIndex);
      print(musics[nextIndex]);
      print(musics.length);
      print('=');
      if (musics.length <= nextIndex) {
        nextIndex = 0;
      }
      _play(musics[nextIndex]);
      // widget.music = musics[nextIndex];
      print('播放完成==');
    });
    // 监听报错
    _playerErrorSubscription = _audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      setState(() {
        _duration = Duration(seconds: 0);
        _position = Duration(seconds: 0);
      });
    });
    // 播放状态改变
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() {

      });
    });
    // IOS中来自通知区域得玩家状态变化流
    _audioPlayer.onNotificationPlayerStateChanged.listen((state) {
      if (!mounted) return;
    });
  }

  void _play(Music music) async {
    final playPosition = (_position != null &&
      _duration != null &&
      _position.inMilliseconds > 0 &&
      _position.inMilliseconds < _duration.inMilliseconds)
      ? _position
      : null;
    // videoView.setVideoURI(Uri.parse(url));
    // final t = Uri.parse(url);
    if (music.mp3Rid != '') {
      var mp3Rid = music.mp3Rid;
      url = 'http://antiserver.kuwo.cn/anti.s?rid=${mp3Rid}&response=res&format=mp3|aac&type=convert_url&br=320kmp3&agent=iPhone&callback=getlink&jpcallback=getlink.mp3';
    }
    final result = await _audioPlayer.play(url, position: playPosition);
    if (result == 1) {
      print(result);
      print('play succes');
    }
    _audioPlayer.setPlaybackRate(playbackRate: 1.0);
  }

  void _pause() async {
    final result = await _audioPlayer.pause();
    if (result == 1) {
      print('succes');
    }
  }

  _stop() async {
    final result = await _audioPlayer.stop();
    if (result == 1) {
      setState(() {
        _position = Duration();
      });
    }
  }

  // _nextSong() async {
  // }

  @override
  Widget build(BuildContext context) {
    Row buildButtonColumn(IconData icon, String label) {
      Color color = Theme.of(context).primaryColor;
      return new Row(
        children: [
          new Icon(icon, color: color),
          new Container(
            child: new Text(
              label,
              style: new TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: color,
              )
            )
          )
        ],
      );
    }
    Widget _buildBottomNavigationBar(){
      return Container(
        color: Colors.white,
        child: SafeArea(
          child: SizedBox(
            height: 54.0,
            child: Card(
              elevation: 2.0,
              shape: RoundedRectangleBorder(),
              margin: EdgeInsets.all(0.0),
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child:  new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new IconButton(
                        icon:new ClipOval(
                          child: Image.asset('images/zhizu.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        // color: Colors.red[500],
                        onPressed: () {
                          Navigator.push(
                          context,
                          new MaterialPageRoute(builder: (context) => new SecondScreen()),
                          );
                        },
                      ),
                      new Expanded(
                        child:  new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Container(
                                // padding: const EdgeInsets.only(bottom: 8.0),
                                child: new Text(
                                  '我不愿让你一个',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              new Text(
                                  '横滑可切换上下首',
                                  style: new TextStyle(
                                    color: Colors.grey[500],
                                  )
                              ),
                            ]
                        ),
                      ),
                      buildButtonColumn(Icons.play_arrow, ''),
                      buildButtonColumn(Icons.list, '')
                    ]
                  //  buildButtonColumn(Icons.list, 'SHARE')
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Text(
              widget.music.name
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
                _play(widget.music);
              }),
              IconButton(icon: Icon(Icons.pause), onPressed: () {
                _pause();
              }),
              IconButton(icon: Icon(Icons.stop), onPressed: () {
                _stop();
              })
            ],
          ),
        ],
      ),
      // bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}

class _SecondScreenState extends State with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }
  @override
  bool get wantKeepAlive => true;
}

class SecondScreen extends StatelessWidget {
  State<StatefulWidget> createState() {
    return _SecondScreenState();
  }
  final Music music;
  final musics;
  const SecondScreen({Key key, this.music, this.musics}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(music.name),
      ),
      body: new Center(
        child: new AudioPlaybackPage(
            music: music,
            musics: musics
        )
      ),
    );
  }
}

class MusicsListScreen extends StatelessWidget {
  final musics;
  const MusicsListScreen({Key key, this.musics}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('musics');
    print(this.musics);
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("播放列表"),
      ),
      body: new Center(
          child: new ListView(
            children: musics.map<Widget>((Music music) {
                    return new ListTile(
                      title: new Text(music.name),
                      subtitle: new Text('五月天'),
                      leading: new Icon(
                          Icons.theaters,
                          color: Colors.blue[500]
                      ),
                    );
                }).toList(),
          )
      ),
    );
  }
}

void main() {
  runApp(new MaterialApp(
    title: 'My app',
    home: new AudioPlayHomePage()
  ));
}