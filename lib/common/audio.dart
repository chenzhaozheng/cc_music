import 'package:cc_music/common/music.dart';
import 'package:cc_music/common/music_play.dart';
import 'package:cc_music/music/music_page.dart';
import 'package:cc_music/music/second_screen.dart';
import 'package:flutter/material.dart';

// class Audio extends StatefulWidget {
//
//   // Audio(Music playMusicRun, List<Music> _playMusicList, url, {Key key}) : super(key: key);
//
//   @override
//   _AudioState createState() => _AudioState();
// }
//
// class _AudioState extends State<Audio> {
//
class Audio extends StatelessWidget {
  final List<Music> _playMusicList;
  final String url;
  Audio(this.url, this._playMusicList);

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
                      onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(builder: (context) => new SecondScreen()),
                        );
                      },
                    ),
                    new Expanded(
                        child: new MusicPlay()
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
}
