import 'dart:convert';

import 'package:cc_music/bloc/audio_cubit.dart';
import 'package:cc_music/bloc/audio_love_musics_cubit.dart';
import 'package:cc_music/bloc/audio_music_cubit.dart';
import 'package:cc_music/bloc/audio_musics_cubit.dart';
import 'package:cc_music/common/audio.dart';
import 'package:cc_music/common/music.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoveMusicsListScreen extends StatefulWidget {
  @override
  _LoveMusicsListScreen createState() => _LoveMusicsListScreen();
}

class _LoveMusicsListScreen extends State {
  Widget build(BuildContext context) {
    return _musicP(context);
  }

  Widget _musicP(BuildContext context) {
    var temp = BlocProvider.of<AudioLoveMusicsCubit>(context).state.musics;
    var itemCount = temp.length;
    return Scaffold(
      appBar: AppBar(
        title: Text("我喜欢的音乐"),
      ),
      body: Center(
          child: ListView(
        // itemExtent: BlocProvider.of<AudioMusicsCubit>(context).state.length,
        children: BlocProvider.of<AudioLoveMusicsCubit>(context)
            .getMusics()
            .map<Widget>((Music item) {
          Music music = BlocProvider.of<AudioMusicCubit>(context).state.music;
          return ListTile(
            title: Text(item.name ?? ''),
            subtitle: (music.mp3Rid == item.mp3Rid
                ? Text('正在播放... ' + item.artist,
                    style: TextStyle(color: Colors.red))
                : Text(item.artist ?? '')),
            trailing: IconButton(
                icon: Icon(Icons.close),
                onPressed: () async {
                  List<Music> tempPlayMusicList = [];
                  List<Music> playMusicList =
                      BlocProvider.of<AudioLoveMusicsCubit>(context)
                          .getMusics();
                  print(playMusicList);
                  playMusicList.forEach((element) {
                    if (element.mp3Rid == item.mp3Rid) {
                      // playMusicList.remove(item);
                    } else {
                      tempPlayMusicList.add(element);
                    }
                  });
                  // print(tempPlayMusicList);
                  BlocProvider.of<AudioLoveMusicsCubit>(context)
                      .setMusics(tempPlayMusicList);

                  // 刷新存储
                  final prefs = await SharedPreferences.getInstance();
                  prefs.setString('counter', json.encode(tempPlayMusicList));

                  // 用于刷新状态
                  BlocProvider.of<AudioMusicCubit>(context).setMusic(
                      BlocProvider.of<AudioMusicCubit>(context).getMusic());
                }),
            onTap: () {
              BlocProvider.of<AudioMusicCubit>(context).setMusic(item);
              BlocProvider.of<AudioCubit>(context).play(context, item, 1);

              // 播放的话，加入播放列表
              List<String> temp = [];
              List<Music> temp1 =
                  BlocProvider.of<AudioMusicsCubit>(context).getMusics();
              temp1.forEach((e) => {temp.add(e.mp3Rid)});
              List<Music> playMusicList =
                  BlocProvider.of<AudioLoveMusicsCubit>(context).getMusics();
              print(playMusicList);
              playMusicList.forEach((element) {
                if (!temp.contains(element.mp3Rid)) {
                  temp1.add(element);
                }
              });
              BlocProvider.of<AudioMusicsCubit>(context).setMusics(temp1);
            },
          );
        }).toList(),
      )),
    );
  }
}
