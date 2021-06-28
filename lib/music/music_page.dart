import 'package:cc_music/bloc/audio_cubit.dart';
import 'package:cc_music/bloc/audio_music_cubit.dart';
import 'package:cc_music/bloc/audio_musics_cubit.dart';
import 'package:cc_music/common/music.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MusicsListScreen extends StatefulWidget {
  @override
  _MusicsListScreen createState() => _MusicsListScreen();
}

class _MusicsListScreen extends State {
  Widget build(BuildContext context) {
    return _musicP(context);
  }

  Widget _musicP(BuildContext context) {
    var temp = BlocProvider.of<AudioMusicsCubit>(context).state;
    var itemCount = temp.length;
    return Scaffold(
      appBar: AppBar(
        title: Text("播放列表"),
      ),
      body: Center(
          // child: ListView.separated(
          //     itemBuilder: itemBuilder(context, index) {
          //       Music item = temp[index];
          //       Music music = BlocProvider.of<AudioMusicCubit>(context).state.music;
          //           return ListTile(
          //             title: Text(item.name ?? ''),
          //             subtitle: Text(music.mp3Rid == item.mp3Rid
          //                 ? '正在播放... ' + item.artist
          //                 : (item.artist ?? '')),
          //             trailing: IconButton(
          //                 icon: Icon(Icons.close),
          //                 onPressed: () {
          //                   // List<Music> playMusicList =
          //                   //     BlocProvider.of<AudioMusicsCubit>(context).getMusics();
          //                   // playMusicList.forEach((element) {
          //                   //   if (element.mp3Rid == item.mp3Rid) {
          //                   //     playMusicList.remove(item);
          //                   //   }
          //                   // });
          //                   BlocProvider.of<AudioMusicsCubit>(context).setMusics([]);
          //                 }),
          //             onTap: () {
          //               BlocProvider.of<AudioMusicCubit>(context).setMusic(item);
          //               BlocProvider.of<AudioCubit>(context).play(context, item);
          //             },
          //           );
          //     },
          //     separatorBuilder: (context, index) => Divider(height: .0),
          //     itemCount: itemCount
          // ),
          // ListView.builder(itemBuilder: itemBuilder)
          child: ListView(
        // itemExtent: BlocProvider.of<AudioMusicsCubit>(context).state.length,
        children: BlocProvider.of<AudioMusicsCubit>(context)
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
                onPressed: () {
                  List<Music> tempPlayMusicList = [];
                  List<Music> playMusicList =
                      BlocProvider.of<AudioMusicsCubit>(context).getMusics();
                  print(playMusicList);
                  playMusicList.forEach((element) {
                    if (element.mp3Rid == item.mp3Rid) {
                      // playMusicList.remove(item);
                    } else {
                      tempPlayMusicList.add(element);
                    }
                  });
                  // print(tempPlayMusicList);
                  BlocProvider.of<AudioMusicsCubit>(context)
                      .setMusics(tempPlayMusicList);

                  // 用于刷新状态
                  BlocProvider.of<AudioMusicCubit>(context).setMusic(
                      BlocProvider.of<AudioMusicCubit>(context).getMusic());
                }),
            onTap: () {
              BlocProvider.of<AudioMusicCubit>(context).setMusic(item);
              BlocProvider.of<AudioCubit>(context).play(context, item);
            },
          );
        }).toList(),
      )),
    );
  }
}
