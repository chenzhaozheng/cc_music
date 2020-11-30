import 'package:flutter/material.dart';
import 'package:cc_music/common/music.dart';

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
