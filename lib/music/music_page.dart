import 'package:cc_music/common/music.dart';
import 'package:flutter/material.dart';

class MusicsListScreen extends StatelessWidget {
  final musics;
  final music;

  const MusicsListScreen({Key key, this.musics, this.music}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('musics');
    print(this.musics);
    print(this.music);
    // var musicAlone = this.music;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("播放列表"),
      ),
      body: new Center(
          child: new ListView(
        children: musics.map<Widget>((Music music) {
          if (this.music && this.music.name == music.name) {
            return new ListTile(
              title: new Text(music.name),
              subtitle: new Text(music.artist + ' ' + '正在播放'),
              leading: new Icon(Icons.theaters, color: Colors.blue[500]),
            );
          }
          return new ListTile(
            title: new Text(music.name),
            subtitle: new Text(music.artist),
            leading: new Icon(Icons.theaters, color: Colors.blue[500]),
          );
        }).toList(),
      )),
    );
  }
}
