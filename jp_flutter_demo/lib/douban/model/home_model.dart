class Person {
  String name = "";
  String avatarURL = "";

  Person.fromMap(Map<String, dynamic> json) {
    this.name = json["name"];
    // 有空值的情况，需要判断
    Map<String, dynamic>? avatars = json["avatars"];
    if (avatars != null) {
      String? medium = avatars["medium"];
      if (medium != null) {
        this.avatarURL = medium;
      }
    }
  }
}

class Actor extends Person {
  Actor.fromMap(Map<String, dynamic> json): super.fromMap(json);
}

class Director extends Person {
  Director.fromMap(Map<String, dynamic> json): super.fromMap(json);
}

int counter = 1;

class MovieItem {
  int rank = 0;
  String imageURL = "";
  String title = "";
  String playDate = "";
  double rating = 0;
  List<String> genres = [];
  List<Actor> casts = [];
  Director? director;
  String originalTitle = "";

  MovieItem.fromMap(Map<String, dynamic> json) {
    this.rank = counter++;
    this.imageURL = json["images"]["medium"];
    this.title = json["title"];
    this.playDate = json["year"];
    // 有些分数被解析成int类型了，所以要转成String再转成double
    this.rating = double.tryParse(json["rating"]["average"].toString()) ?? 0; 
    this.genres = json["genres"].cast<String>();
    this.casts = (json["casts"] as List<dynamic>).map((item) {
      return Actor.fromMap(item);
    }).toList();
    this.director = Director.fromMap(json["directors"][0]);
    this.originalTitle = json["original_title"];
  }

  @override
  String toString() {
    return 'MovieItem{rank: $rank, imageURL: $imageURL, title: $title, playDate: $playDate, rating: $rating, genres: $genres, casts: $casts, director: $director, originalTitle: $originalTitle}';
  }
}