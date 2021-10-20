import 'package:cc_music/bloc/audio_musics_cubit.dart';
import 'package:cc_music/common/music.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toast/toast.dart';

typedef void ChangedCallback(Music music, bool inPlayMusicList);

class MusicListItem extends StatelessWidget {
  MusicListItem(
      {Music music, this.inPlayMusicList, this.onChanged, this.playMusicRun})
      : music = music,
        super(key: ObjectKey(music));
  final Music music;
  final Music playMusicRun;
  final bool inPlayMusicList;
  final ChangedCallback onChanged;

  TextStyle _getTextStyle(BuildContext context) {
    if (this.playMusicRun == this.music) {
      return TextStyle(
        color: Colors.grey,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
          icon: Icon(Icons.add_circle_outline),
          onPressed: () {
            // Navigator.pop(context);
            var isRepeat = false;
            List<Music> playMusicList =
                BlocProvider.of<AudioMusicsCubit>(context).getMusics();
            playMusicList.forEach((element) {
              if (element.mp3Rid == music.mp3Rid) {
                isRepeat = true;
              }
            });
            if (!isRepeat) playMusicList.add(this.music);
            BlocProvider.of<AudioMusicsCubit>(context).setMusics(playMusicList);
            Toast.show("已加入播放列表", context,
                duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
          }),
      onTap: () {
        onChanged(music, !inPlayMusicList);
      },
      title:
          Text(music.name + '-' + music.artist, style: _getTextStyle(context)),
      // controller: _scrollController,
    );
  }
}
