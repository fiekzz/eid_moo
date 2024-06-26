class WhatsNewModel {
  bool? success;
  String? message;
  List<WhatsNewData>? data;

  WhatsNewModel({this.success, this.message, this.data});

  WhatsNewModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <WhatsNewData>[];
      json['data'].forEach((v) {
        data!.add(new WhatsNewData.fromJson(v));
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

class WhatsNewData {
  String? id;
  int? price;
  int? part;
  String? description;
  DateTime? createdAt;
  String? status;
  String? masjidId;
  List<Booking>? booking;
  Masjid? masjid;

  WhatsNewData(
      {this.id,
      this.price,
      this.part,
      this.description,
      this.createdAt,
      this.status,
      this.masjidId,
      this.booking,
      this.masjid});

  WhatsNewData.fromJson(Map<String, dynamic> json) {
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
    if (this.booking != null) {
      data['Booking'] = this.booking!.map((v) => v.toJson()).toList();
    }
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

class Booking {
  Booking();

  Booking.fromJson(Map<String, dynamic> json) {

  }

  Map<String, dynamic> toJson() {
    return Map<String, dynamic>();
  }
}