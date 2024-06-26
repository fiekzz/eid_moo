class UserBookingHistoryModel {
  bool? success;
  String? message;
  List<UserBookingHistoryData>? data;

  UserBookingHistoryModel({this.success, this.message, this.data});

  UserBookingHistoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserBookingHistoryData>[];
      json['data'].forEach((v) {
        data!.add(new UserBookingHistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserBookingHistoryData {
  String? id;
  int? price;
  int? part;
  String? userAuthId;
  String? postId;
  DateTime? createdAt;
  bool? wantOneThird;
  bool? claimedOneThird;
  Post? post;

  UserBookingHistoryData(
      {this.id,
      this.price,
      this.part,
      this.userAuthId,
      this.postId,
      this.createdAt,
      this.wantOneThird,
      this.claimedOneThird,
      this.post});

  UserBookingHistoryData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    part = json['part'];
    userAuthId = json['userAuthId'];
    postId = json['postId'];
    createdAt = DateTime.tryParse(json['CreatedAt'].toString())?.toLocal();
    wantOneThird = json['wantOneThird'];
    claimedOneThird = json['claimedOneThird'];
    post = json['Post'] != null ? new Post.fromJson(json['Post']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['part'] = this.part;
    data['userAuthId'] = this.userAuthId;
    data['postId'] = this.postId;
    data['CreatedAt'] = this.createdAt;
    data['wantOneThird'] = this.wantOneThird;
    data['claimedOneThird'] = this.claimedOneThird;
    if (this.post != null) {
      data['Post'] = this.post!.toJson();
    }
    return data;
  }
}

class Post {
  String? id;
  int? price;
  int? part;
  String? description;
  DateTime? createdAt;
  String? status;
  String? masjidId;
  Masjid? masjid;

  Post(
      {this.id,
      this.price,
      this.part,
      this.description,
      this.createdAt,
      this.status,
      this.masjidId,
      this.masjid});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    part = json['part'];
    description = json['description'];
    createdAt = DateTime.tryParse(json['CreatedAt'].toString())?.toLocal();
    status = json['Status'];
    masjidId = json['masjidId'];
    masjid =
        json['Masjid'] != null ? new Masjid.fromJson(json['Masjid']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['part'] = this.part;
    data['description'] = this.description;
    data['CreatedAt'] = this.createdAt;
    data['Status'] = this.status;
    data['masjidId'] = this.masjidId;
    if (this.masjid != null) {
      data['Masjid'] = this.masjid!.toJson();
    }
    return data;
  }
}

class Masjid {
  String? name;
  String? id;

  Masjid({this.name, this.id});

  Masjid.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
