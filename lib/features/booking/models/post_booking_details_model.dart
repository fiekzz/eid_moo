class PostBookingDetailsModel {
  bool? success;
  String? message;
  PostBookingDetailsData? data;

  PostBookingDetailsModel({this.success, this.message, this.data});

  PostBookingDetailsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new PostBookingDetailsData.fromJson(json['data']) : null;
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

class PostBookingDetailsData {
  String? id;
  int? price;
  int? part;
  String? description;
  DateTime? createdAt;
  String? status;
  String? masjidId;
  Masjid? masjid;
  List<Booking>? booking;

  PostBookingDetailsData(
      {this.id,
      this.price,
      this.part,
      this.description,
      this.createdAt,
      this.status,
      this.masjidId,
      this.masjid,
      this.booking});

  PostBookingDetailsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    part = json['part'];
    description = json['description'];
    createdAt = DateTime.tryParse(json['CreatedAt'].toString())?.toLocal();
    status = json['Status'];
    masjidId = json['masjidId'];
    masjid =
        json['Masjid'] != null ? new Masjid.fromJson(json['Masjid']) : null;
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
    if (this.masjid != null) {
      data['Masjid'] = this.masjid!.toJson();
    }
    if (this.booking != null) {
      data['Booking'] = this.booking!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Masjid {
  String? id;
  String? name;
  String? address;

  Masjid({this.id, this.name, this.address});

  Masjid.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
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