class Categories {
  static List<String> fromJson(List<dynamic> list) {
    return list.map<String>((category) => category).toList();
  }
}
