class MyMasjidDetailsModel {
  bool? success;
  String? message;
  MyMasjidDetailsData? data;

  MyMasjidDetailsModel({this.success, this.message, this.data});

  MyMasjidDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new MyMasjidDetailsData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class MyMasjidDetailsData {
  String? id;
  String? name;
  String? address;
  String? userAuthId;
  int? sales;
  List<Post>? post;

  MyMasjidDetailsData(
      {this.id,
      this.name,
      this.address,
      this.userAuthId,
      this.sales,
      this.post});

  MyMasjidDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    userAuthId = json['userAuthId'];
    sales = json['Sales'];
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
    data['Sales'] = this.sales;
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
  String? description;
  String? createdAt;
  String? status;
  String? masjidId;
  List<Booking>? booking;

  Post(
      {this.id,
      this.price,
      this.part,
      this.description,
      this.createdAt,
      this.status,
      this.masjidId,
      this.booking});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    part = json['part'];
    description = json['description'];
    createdAt = json['CreatedAt'];
    status = json['Status'];
    masjidId = json['masjidId'];
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
    data['description'] = this.description;
    data['CreatedAt'] = this.createdAt;
    data['Status'] = this.status;
    data['masjidId'] = this.masjidId;
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
  String? createdAt;

  Booking(
      {this.id,
      this.price,
      this.part,
      this.userAuthId,
      this.postId,
      this.createdAt});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    part = json['part'];
    userAuthId = json['userAuthId'];
    postId = json['postId'];
    createdAt = json['CreatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['part'] = this.part;
    data['userAuthId'] = this.userAuthId;
    data['postId'] = this.postId;
    data['CreatedAt'] = this.createdAt;
    return data;
  }
}
