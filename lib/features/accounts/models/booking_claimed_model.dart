class BookingClaimedModel {
  bool? success;
  String? message;
  BookingClaimedData? data;

  BookingClaimedModel({this.success, this.message, this.data});

  BookingClaimedModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new BookingClaimedData.fromJson(json['data']) : null;
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

class BookingClaimedData {
  String? id;
  int? price;
  int? part;
  String? userAuthId;
  String? postId;
  String? createdAt;
  bool? wantOneThird;
  bool? claimedOneThird;

  BookingClaimedData(
      {this.id,
      this.price,
      this.part,
      this.userAuthId,
      this.postId,
      this.createdAt,
      this.wantOneThird,
      this.claimedOneThird});

  BookingClaimedData.fromJson(Map<String, dynamic> json) {
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