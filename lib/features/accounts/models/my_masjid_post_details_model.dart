class MyMasjidPostDetailsModel {
  bool? success;
  String? message;
  MyMasjidPostDetailsData? data;

  MyMasjidPostDetailsModel({this.success, this.message, this.data});

  MyMasjidPostDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null
        ? new MyMasjidPostDetailsData.fromJson(json['data'])
        : null;
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

class MyMasjidPostDetailsData {
  String? id;
  int? price;
  int? part;
  String? description;
  DateTime? createdAt;
  String? status;
  String? masjidId;
  List<Booking>? booking;

  MyMasjidPostDetailsData(
      {this.id,
      this.price,
      this.part,
      this.description,
      this.createdAt,
      this.status,
      this.masjidId,
      this.booking});

  MyMasjidPostDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    part = json['part'];
    description = json['description'];
    createdAt = DateTime.tryParse(json['CreatedAt'].toString())?.toLocal();
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
  DateTime? createdAt;
  UserAuth? userAuth;
  bool? wantOneThird;
  bool? claimedOneThird;

  Booking({
    this.id,
    this.price,
    this.part,
    this.userAuthId,
    this.postId,
    this.createdAt,
    this.userAuth,
    this.wantOneThird,
    this.claimedOneThird,
  });

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    part = json['part'];
    userAuthId = json['userAuthId'];
    claimedOneThird = bool.tryParse(json['claimedOneThird'].toString());
    postId = json['postId'];
    wantOneThird = bool.tryParse(json['wantOneThird'].toString());
    createdAt = DateTime.tryParse(json['CreatedAt'].toString())?.toLocal();
    userAuth = json['userAuth'] != null
        ? new UserAuth.fromJson(json['userAuth'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['part'] = this.part;
    data['userAuthId'] = this.userAuthId;
    data['postId'] = this.postId;
    data['CreatedAt'] = this.createdAt;
    if (this.userAuth != null) {
      data['userAuth'] = this.userAuth!.toJson();
    }
    return data;
  }
}

class UserAuth {
  String? id;
  String? email;
  String? name;
  String? phoneNumber;

  UserAuth({this.id, this.email, this.name, this.phoneNumber});

  UserAuth.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    return data;
  }
}
