
class JPMealModel {
  String id = "";
  List<String> categories = [];
  String title = "";
  int affordability = 0;
  int complexity = 0;
  String imageUrl = "";
  int duration = 0;
  List<String> ingredients = [];
  List<String> steps = [];
  bool isGlutenFree = false;
  bool isVegan = false;
  bool isVegetarian = false;
  bool isLactoseFree = false;
  
  // 自定义属性
  String get complexityStr {
    // 复杂度文本（根据 complexity）
    switch (complexity) {
      case 1: return "中等";
      case 2: return "困难";
      default: return "简单";
    }
  }

  // JPMealModel(
  //     {this.id,
  //     this.categories,
  //     this.title,
  //     this.affordability,
  //     this.complexity,
  //     this.imageUrl,
  //     this.duration,
  //     this.ingredients,
  //     this.steps,
  //     this.isGlutenFree,
  //     this.isVegan,
  //     this.isVegetarian,
  //     this.isLactoseFree});

  JPMealModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categories = json['categories'].cast<String>();
    title = json['title'];
    affordability = json['affordability'];
    complexity = json['complexity'];
    imageUrl = json['imageUrl'];
    duration = json['duration'];
    ingredients = json['ingredients'].cast<String>();
    steps = json['steps'].cast<String>();
    isGlutenFree = json['isGlutenFree'];
    isVegan = json['isVegan'];
    isVegetarian = json['isVegetarian'];
    isLactoseFree = json['isLactoseFree'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categories'] = this.categories;
    data['title'] = this.title;
    data['affordability'] = this.affordability;
    data['complexity'] = this.complexity;
    data['imageUrl'] = this.imageUrl;
    data['duration'] = this.duration;
    data['ingredients'] = this.ingredients;
    data['steps'] = this.steps;
    data['isGlutenFree'] = this.isGlutenFree;
    data['isVegan'] = this.isVegan;
    data['isVegetarian'] = this.isVegetarian;
    data['isLactoseFree'] = this.isLactoseFree;
    return data;
  }
}