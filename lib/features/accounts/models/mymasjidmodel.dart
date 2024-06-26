class MyMasjidModel {
  bool? success;
  String? message;
  List<MyMasjidModelData>? data;

  MyMasjidModel({this.success, this.message, this.data});

  MyMasjidModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MyMasjidModelData>[];
      json['data'].forEach((v) {
        data!.add(new MyMasjidModelData.fromJson(v));
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

class MyMasjidModelData {
  String? id;
  String? name;
  String? address;
  String? userAuthId;
  List<Post>? post;

  MyMasjidModelData({this.id, this.name, this.address, this.userAuthId, this.post});

  MyMasjidModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    userAuthId = json['userAuthId'];
    if (json['Post'] != null) {
      post = <Post>[];
      json['Post'].forEach((v) {
        post!.add(new Post.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['userAuthId'] = this.userAuthId;
    if (this.post != null) {
      data['Post'] = this.post!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Post {
  String? id;
  int? price;
  int? part;
  List<Booking>? booking;

  Post({this.id, this.price, this.part, this.booking});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    part = json['part'];
    if (json['Booking'] != null) {
      booking = <Booking>[];
      json['Booking'].forEach((v) {
        booking!.add(new Booking.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['part'] = this.part;
    if (this.booking != null) {
      data['Booking'] = this.booking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Booking {
  String? id;
  int? price;
  int? part;
  String? userAuthId;
  String? postId;

  Booking({this.id, this.price, this.part, this.userAuthId, this.postId});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    part = json['part'];
    userAuthId = json['userAuthId'];
    postId = json['postId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['part'] = this.part;
    data['userAuthId'] = this.userAuthId;
    data['postId'] = this.postId;
    return data;
  }
}