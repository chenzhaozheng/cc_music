import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cc_music/common/music.dart';
import 'package:dio/dio.dart';

_getMusics(content, int listPage) async {
  var url =
      'http://search.kuwo.cn/r.s?all=$content&ft=music&client=kt&cluster=0&pn=${listPage}&rn=20&rformat=json&encoding=utf8&vipver=MUSIC_8.0.3.1&';
  print(url);
  String result;
  try {
    var response = await Dio().get(
      url,
      options: Options(responseType: ResponseType.json),
    );
    try {
      // ignore: non_constant_identifier_names
      var JSON = JsonCodec();
      Map<String, dynamic> data2 =
          JSON.decode(response.data.replaceAll("'", '"'));
      return data2;
    } catch (e) {
      print("Error: $e");
    }
  } catch (exception) {
    print(exception);
    result = 'Failed getting IP address';
  }
}

class AudioSearchMusicsCubit extends Cubit<List<Music>> {
  AudioSearchMusicsCubit() : super([]);
  Future<void> queryMusics(String query, listPage) async {
    var data2 = await _getMusics(query, listPage);
    List<Music> list2 = [];
    if (listPage == 0) {
      list2 = [];
    } else {
      this.state.forEach((element) {
        list2.add(element);
      });
      // print('cccc');
      print(list2);
    }
    for (var da in data2['abslist']) {
      print(da);
      final name = da['NAME'].replaceAll('&nbsp;', '');
      final artist = da['ARTIST'].replaceAll('&nbsp;', '');
      list2.add(Music(
          name: name,
          mp3Rid: da['MP3RID'],
          headImg: da['hts_MVPIC'],
          artist: artist));
    }
    emit(list2);
  }

  void setMusics(List<Music> musics) => emit(musics);
  getMusics() => this.state;
}

class ChangeAudioMusicsBlocState {
  // final int index;
  ChangeAudioMusicsBlocState();
}
