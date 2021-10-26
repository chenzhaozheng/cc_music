class Music {
  Music(
      {this.name, this.mp3Rid, this.headImg, this.isPlay = false, this.artist});
  final String name;
  final String mp3Rid;
  final String headImg;
  final bool isPlay;
  final String artist;

  // Music({this.name, this.url});
  Music.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        mp3Rid = json['mp3Rid'],
        headImg = json['headImg'],
        isPlay = json['isPlay'],
        artist = json['artist'];

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mp3Rid': mp3Rid,
      'headImg': headImg,
      'isPlay': isPlay,
      'artist': artist,
    };
  }
}
