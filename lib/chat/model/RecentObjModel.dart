/*

{
  "author": {
    "id": "dfadsfdsaff"
  },
  "createdAt": 1682855727969,
  "id": "dfafdsfdsffads",
  "type": "text",
  "text": "hi hellow!!!!",
  "detail": {
    "name": "",
    "img": "",
    "count": ""
  }
}


 */

class RecentObjModel {
  RecentObjModel({
    this.author,
    this.createdAt,
    this.id,
    this.type,
    this.text,
    this.detail,
  });

  RecentObjModel.fromJson(dynamic json) {
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    createdAt = json['createdAt'];
    id = json['id'];
    type = json['type'];
    text = json['text'];
    detail = json['detail'] != null ? Detail.fromJson(json['detail']) : null;
  }

  Author? author;
  num? createdAt;
  String? id;
  String? type;
  String? text;
  Detail? detail;

  RecentObjModel copyWith({
    Author? author,
    num? createdAt,
    String? id,
    String? type,
    String? text,
    Detail? detail,
  }) =>
      RecentObjModel(
        author: author ?? this.author,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
        type: type ?? this.type,
        text: text ?? this.text,
        detail: detail ?? this.detail,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (author != null) {
      map['author'] = author?.toJson();
    }
    map['createdAt'] = createdAt;
    map['id'] = id;
    map['type'] = type;
    map['text'] = text;
    if (detail != null) {
      map['detail'] = detail?.toJson();
    }
    return map;
  }
}

class Detail {
  Detail({
    this.name,
    this.img,
    this.count,
    this.uid,
    this.qualification,
    this.gender,
  });

  Detail.fromJson(dynamic json) {
    name = json['name'];
    img = json['img'];
    count = json['count'];
    uid = json['uid'];
    qualification = json['qualification '];
    gender = json['gender'];
  }

  String? name;
  String? img;
  String? count;
  String? uid;
  String? qualification;
  String? gender;

  Detail copyWith({
    String? name,
    String? img,
    String? count,
    String? uid,
  }) =>
      Detail(
        name: name ?? this.name,
        img: img ?? this.img,
        count: count ?? this.count,
        uid: uid ?? this.uid,
        qualification: qualification ?? this.qualification,
        gender: gender ?? this.gender,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['img'] = img;
    map['count'] = count;
    map['uid'] = uid;
    map['qualification'] = qualification;
    map['gender'] = gender;
    return map;
  }
}

class Author {
  Author({
    this.id,
  });

  Author.fromJson(dynamic json) {
    id = json['id'];
  }

  String? id;

  Author copyWith({
    String? id,
  }) =>
      Author(
        id: id ?? this.id,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    return map;
  }
}
