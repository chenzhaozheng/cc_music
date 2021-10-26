class Post {
  set name(String name) {}

  // Other functions and properties relevant to the class
  // ......
  /// Json is a Map<dynamic,dynamic> if i recall correctly.
  // static fromJson(json): Post {
  //   Post p = new Post()
  // }

  static fromJson(model) {
    Post p = new Post();
    p.name = '11';
    return model;
  }
}
