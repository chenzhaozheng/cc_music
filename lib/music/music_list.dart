import 'package:cc_music/common/music.dart';
import 'package:flutter/material.dart';

typedef void ChangedCallback(Music music, bool inPlayMusicList);

class MusicListItem extends StatelessWidget {
  MusicListItem(
      {Music music, this.inPlayMusicList, this.onChanged, this.playMusicRun})
      : music = music,
        super(key: new ObjectKey(music));
  final Music music;
  final Music playMusicRun;
  final bool inPlayMusicList;
  final ChangedCallback onChanged;

  TextStyle _getTextStyle(BuildContext context) {
    if (this.playMusicRun == this.music) {
      return new TextStyle(
        color: Colors.grey,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      onTap: () {
        // print('===');
        // print(music);
        // print('====');
        // print(inPlayMusicList);
        onChanged(music, !inPlayMusicList);
      },
      // leading: new CircleAvatar(
      //   backgroundColor: Colors.black54,
      //   child: new Text(music.name[0]),
      // ),
      title: new Text(music.name + '-' + music.artist,
          style: _getTextStyle(context)),
      // controller: _scrollController,
    );
  }
}
