class Ms {
  final String name;
  final String mp3Rid;
  final String headImg;

  Ms(this.name, this.mp3Rid, this.headImg);

  Ms.fromJson(Map<String, dynamic> json)
    : name = json['NAME'],
      mp3Rid = json['MP3RID'],
      headImg = json['hts_MVPIC'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'mp3Rid': mp3Rid,
    'headImg': headImg,
  };
}