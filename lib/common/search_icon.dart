import 'package:cc_music/bloc/audio_love_musics_cubit.dart';
import 'package:cc_music/bloc/audio_love_musics_state.dart';
import 'package:cc_music/bloc/audio_music_cubit.dart';
import 'package:cc_music/bloc/audio_music_state.dart';
import 'package:cc_music/common/search_delegate.dart';
import 'package:cc_music/music/love_music_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cc_music/common/audio.dart';
import 'music.dart';
import 'package:sprintf/sprintf.dart';

class SearchIcon extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchIconState();
  }
}

class _SearchIconState extends State<SearchIcon> {
  List<Music> _playMusicList = List<Music>();
  Music playMusicRun = Music(name: 'music');

  void handleClick() {
    print('---');
  }

  @override
  Widget build(BuildContext context) {
    var mp3Rid = playMusicRun.mp3Rid;
    var url =
        'http://antiserver.kuwo.cn/anti.s?rid=$mp3Rid&response=res&format=mp3|aac&type=convert_url&br=320kmp3&agent=iPhone&callback=getlink&jpcallback=getlink.mp3';
    var temp = BlocProvider.of<AudioLoveMusicsCubit>(context).getMusics();
    var itemCount = sprintf("%s", [temp.length]);

    return Scaffold(
      appBar: AppBar(
        title: Text("搜索"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(context: context, delegate: SearchBarDelegate());
              })
        ],
      ),
      body: Container(
          color: Color(0xffdddddd),
          child: Column(
            children: [
              // SearchIcon(),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, top: 0, bottom: 0, right: 15),
                // child: DecoratedBox(
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(3.0), //3像素圆角
                //     image: DecorationImage(
                //       image: AssetImage('images/demo1.jpg'),
                //       fit: BoxFit.fill,
                //     ),
                //   ),
                child: Image.asset('images/demo1.jpg',
                    fit: BoxFit.fitWidth, width: 400, height: 200),
                // ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: FlatButton(
                  // minWidth: 100,
                  color: Colors.white,
                  // highlightColor: Colors.blue[700],
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  textColor: Colors.black,
                  child: Container(
                      padding: const EdgeInsets.only(
                          bottom: 15.0, top: 15.0, left: 0, right: 0.0),
                      child: BlocBuilder<AudioLoveMusicsCubit,
                              AudioLoveMusicsState>(
                          builder: (context, musicsState) => Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 0,
                                          right: 10,
                                          top: 0,
                                          bottom: 0),
                                      child: Image.asset('images/demo.png',
                                          fit: BoxFit.cover,
                                          width: 50,
                                          height: 50),
                                    ),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '我喜欢的音乐',
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            sprintf("%s首",
                                                [musicsState.musics.length]),
                                            style:
                                                TextStyle(color: Colors.green),
                                          )
                                        ]),
                                  ]))),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  // onPressed: () {},
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BlocBuilder<AudioMusicCubit, AudioMusicState>(
                                  builder: (context, x) =>
                                      new LoveMusicsListScreen())),
                    );
                  },
                ),
              )
            ],
          )),
      bottomNavigationBar: BlocBuilder<AudioMusicCubit, AudioMusicState>(
        builder: (context, x) => Audio(url, _playMusicList, playMusicRun),
      ),
    );
  }
}
