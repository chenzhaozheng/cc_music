import 'package:cc_music/bloc/audio_cubit.dart';
import 'package:cc_music/bloc/audio_music_cubit.dart';
import 'package:cc_music/bloc/audio_musics_cubit.dart';
import 'package:cc_music/bloc/audio_search_musics_cubit.dart';
import 'package:cc_music/common/search_content.dart';
import 'package:cc_music/music/music_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

import 'music.dart';

typedef SearchItemCall = void Function(String item);
var list2 = <Music>[];
Music playMusicRun = Music();
List<Music> _playMusicList = List<Music>();

class SearchBarDelegate extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => '为你推荐';
  // @override
  // // TODO: implement query
  // String get query => 'sss';
  // @override
  set query(String value) {
    // TODO: implement
    super.query = value;
  }

  // String get query => 'test';

  // @override
  // String get textInputAction;

  @override
  List<Widget> buildActions(BuildContext context) {
    print('buildActions');
    //右侧显示内容 这里放清除按钮
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    print('buildLeading');
    //左侧显示内容 这里放了返回按钮
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        print('onPressed');
        if (query.isEmpty) {
          close(context, null);
        } else {
          query = "";
          showSuggestions(context);
        }
      },
    );
  }

  ScrollController _scrollController = ScrollController();

  @override
  Widget buildResults(BuildContext context) {
    print('buildResults');
    void _handleChanged(Music music, bool inPlayMusicList) {
      var isRepeat = false;
      var index = 0;
      _playMusicList.forEach((element) {
        if (element.mp3Rid == music.mp3Rid) {
          isRepeat = true;
        }
        index++;
      });
      playMusicRun = music;
      if (!isRepeat) if (inPlayMusicList)
        _playMusicList.add(music);
      else
        _playMusicList.remove(music);

      BlocProvider.of<AudioMusicsCubit>(context).setMusics(_playMusicList);
      BlocProvider.of<AudioMusicCubit>(context).setMusic(music);
      BlocProvider.of<AudioCubit>(context).play(context, music, 1);
    }

    BlocProvider.of<AudioSearchMusicsCubit>(context).queryMusics(query, 0);
    var pageList = 1;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print('滑动到了最底部cc');
        BlocProvider.of<AudioSearchMusicsCubit>(context)
            .queryMusics(query, pageList++);
      }
    });

    void addVideo() {
      var musics = BlocProvider.of<AudioMusicsCubit>(context).getMusics();
      var searchMusics =
          BlocProvider.of<AudioSearchMusicsCubit>(context).getMusics();
      searchMusics.forEach((element) {
        var isRepeat = false;
        musics.forEach((element1) {
          if (element1.name == element.name) {
            isRepeat = true;
          }
        });
        if (!isRepeat) {
          musics.add(element);
        }
      });
      print(musics);
      BlocProvider.of<AudioMusicsCubit>(context).setMusics(musics);
      Toast.show("已加入播放列表", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
    }

    return Container(
        child: BlocBuilder<AudioSearchMusicsCubit, List<Music>>(
            builder: (context, musics) => Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.library_add),
                            onPressed: () => {addVideo()}),
                        TextButton(
                            onPressed: () => {addVideo()},
                            child: Text('加入播放列表')),
                      ],
                    ),
                    Expanded(
                        child: ListView(
                            controller: _scrollController,
                            children: musics.map<Widget>(
                              (Music item) {
                                return MusicListItem(
                                    playMusicRun:
                                        BlocProvider.of<AudioMusicCubit>(
                                                context)
                                            .getMusic(),
                                    music: item,
                                    inPlayMusicList: musics.contains(item),
                                    onChanged: _handleChanged);
                              },
                            ).toList()))
                  ],
                )));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print('buildSuggestions');
    //点击了搜索窗显示的页面
    return SearchContentView();
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    print('appBarTheme');
    return super.appBarTheme(context);
  }
}
