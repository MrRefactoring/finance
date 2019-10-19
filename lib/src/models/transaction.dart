class Transaction {
  String title;
  String description;
  String price;
  DateTime date;
  String category;

  Transaction();

  static Transaction fromJson(Map<String, dynamic> json) {
    final transaction = Transaction();

    transaction.title = json['title'];
    transaction.description = json['description'];
    transaction.price = json['price'];
    transaction.date = DateTime.parse(json['date']);
    transaction.category = json['category'];

    return transaction;
  }

  Map<String, dynamic> toJson() => {
        'title': this.title,
        'description': this.description,
        'price': this.price,
        'date': this.date.toString(),
        'category': this.category,
      };
}
