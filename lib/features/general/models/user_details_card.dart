class UserInfoCardModel {
  bool? success;
  String? message;
  Data? data;

  UserInfoCardModel({this.success, this.message, this.data});

  UserInfoCardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  String? id;
  String? email;
  String? name;
  String? phoneNumber;
  List<Booking>? booking;
  List<Masjid>? masjid;

  Data(
      {this.id,
      this.email,
      this.name,
      this.phoneNumber,
      this.booking,
      this.masjid});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    if (json['Booking'] != null) {
      booking = <Booking>[];
      json['Booking'].forEach((v) {
        booking!.add(new Booking.fromJson(v));
      });
    }
    if (json['Masjid'] != null) {
      masjid = <Masjid>[];
      json['Masjid'].forEach((v) {
        masjid!.add(new Masjid.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['phoneNumber'] = this.phoneNumber;
    if (this.booking != null) {
      data['Booking'] = this.booking!.map((v) => v.toJson()).toList();
    }
    if (this.masjid != null) {
      data['Masjid'] = this.masjid!.map((v) => v.toJson()).toList();
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
  bool? wantOneThird;
  bool? claimedOneThird;

  Booking(
      {this.id,
      this.price,
      this.part,
      this.userAuthId,
      this.postId,
      this.createdAt,
      this.wantOneThird,
      this.claimedOneThird});

  Booking.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    part = json['part'];
    userAuthId = json['userAuthId'];
    postId = json['postId'];
    createdAt = json['CreatedAt'];
    wantOneThird = json['wantOneThird'];
    claimedOneThird = json['claimedOneThird'];
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
    return data;
  }
}

class Masjid {
  String? id;
  String? name;
  String? address;
  String? userAuthId;
  int? sales;

  Masjid({this.id, this.name, this.address, this.userAuthId, this.sales});

  Masjid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    userAuthId = json['userAuthId'];
    sales = json['Sales'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['userAuthId'] = this.userAuthId;
    data['Sales'] = this.sales;
    return data;
  }
}