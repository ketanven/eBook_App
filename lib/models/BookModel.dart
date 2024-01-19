

class BookModel {
  String? id;
  String? title;
  String? description;
  String? rating;
  int? pages;
  String? language;
  String? author;
  int? numberofRating;
  String? aboutAuthor;
  String? bookurl;
  String? category;
  String? coverUrl;

  BookModel(
      {this.id,
      this.title,
      this.description,
      this.rating,
      this.pages,
      this.language,
      this.author,
      this.aboutAuthor,
      this.bookurl,
      this.category,
      this.coverUrl,
      this.numberofRating});

  BookModel.fromJson(Map<String, dynamic> json) {
    if (json["id"] is String) {
      id = json["id"];
    }
    if (json["title"] is String) {
      title = json["title"];
    }
    if (json["description"] is String) {
      description = json["description"];
    }
    if (json["rating"] is String) {
      rating = json["rating"];
    }
    if (json["pages"] is int) {
      pages = json["pages"];
    }
    if (json["language"] is String) {
      language = json["language"];
    }

    if (json["author"] is String) {
      author = json["author"];
    }
    if (json["aboutAuthor"] is String) {
      aboutAuthor = json["aboutAuthor"];
    }
    if (json["numberofRating"] is int) {
      numberofRating = json["numberofRating"];
    }
    if (json["bookurl"] is String) {
      bookurl = json["bookurl"];
    }

    if (json["category"] is String) {
      category = json["category"];
    }
    if (json["coverUrl"] is String) {
      coverUrl = json["coverUrl"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["title"] = title;
    _data["description"] = description;
    _data["rating"] = rating;
    _data["pages"] = pages;
    _data["language"] = language;
    _data["author"] = author;
    _data["aboutAuthor"] = aboutAuthor;
    _data["numberofRating"] = numberofRating;
    _data["bookurl"] = bookurl;
    _data["category"] = category;
    _data["coverUrl"] = coverUrl;
    return _data;
  }
}
