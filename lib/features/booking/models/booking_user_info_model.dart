class BookingUserInfoModel {
  bool? success;
  String? message;
  BookingUserInfoData? data;

  BookingUserInfoModel({this.success, this.message, this.data});

  BookingUserInfoModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new BookingUserInfoData.fromJson(json['data']) : null;
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

class BookingUserInfoData {
  String? id;
  String? email;
  String? name;
  String? phoneNumber;
  List<Booking>? booking;

  BookingUserInfoData({this.id, this.email, this.name, this.phoneNumber, this.booking});

  BookingUserInfoData.fromJson(Map<String, dynamic> json) {
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
    createdAt = DateTime.tryParse(json['CreatedAt'].toString())?.toLocal();
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