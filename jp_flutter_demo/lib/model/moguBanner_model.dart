class MoguBanner {
  String title;
  String image;
  String link;

  MoguBanner({this.title = "", this.image = "", this.link = ""});

  MoguBanner.fromMap(Map<String, dynamic> parsedMap): this(title: parsedMap["title"], image: parsedMap["image"], link: parsedMap["link"],);
  
  @override
  String toString() {
    return "MoguBanner --- title: $title, image: $image, link: $link";
  }
}