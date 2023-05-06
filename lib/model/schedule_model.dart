class GetScheduleModelClass {
  String? id;
  double? latitude;
  double? longitude;
  String? logTime;
  String? arrivalTimeFrom;
  String? arrivalTimeTo;
  String? reservationPaymentToken;
  bool? isTimePassedChecked;
  bool? isPartnerResponseTimePassedChecked;
  bool? isPendingPayment;
  Null? lastPartnerAssignTime;
  TaskObject? taskObject;
  Null? feedback;
  List<ReservationEvents>? reservationEvents;
  Customer? customer;

  GetScheduleModelClass(
      {this.id,
        this.latitude,
        this.longitude,
        this.logTime,
        this.arrivalTimeFrom,
        this.arrivalTimeTo,
        this.reservationPaymentToken,
        this.isTimePassedChecked,
        this.isPartnerResponseTimePassedChecked,
        this.isPendingPayment,
        this.lastPartnerAssignTime,
        this.taskObject,
        this.feedback,
        this.reservationEvents,
        this.customer});

  GetScheduleModelClass.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    logTime = json['logTime'];
    arrivalTimeFrom = json['arrivalTimeFrom'];
    arrivalTimeTo = json['arrivalTimeTo'];
    reservationPaymentToken = json['reservationPaymentToken'];
    isTimePassedChecked = json['isTimePassedChecked'];
    isPartnerResponseTimePassedChecked =
    json['isPartnerResponseTimePassedChecked'];
    isPendingPayment = json['isPendingPayment'];
    lastPartnerAssignTime = json['lastPartnerAssignTime'];
    taskObject = json['taskObject'] != null
        ? new TaskObject.fromJson(json['taskObject'])
        : null;
    feedback = json['feedback'];
    if (json['reservationEvents'] != null) {
      reservationEvents = <ReservationEvents>[];
      json['reservationEvents'].forEach((v) {
        reservationEvents!.add(new ReservationEvents.fromJson(v));
      });
    }
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['logTime'] = this.logTime;
    data['arrivalTimeFrom'] = this.arrivalTimeFrom;
    data['arrivalTimeTo'] = this.arrivalTimeTo;
    data['reservationPaymentToken'] = this.reservationPaymentToken;
    data['isTimePassedChecked'] = this.isTimePassedChecked;
    data['isPartnerResponseTimePassedChecked'] =
        this.isPartnerResponseTimePassedChecked;
    data['isPendingPayment'] = this.isPendingPayment;
    data['lastPartnerAssignTime'] = this.lastPartnerAssignTime;
    if (this.taskObject != null) {
      data['taskObject'] = this.taskObject!.toJson();
    }
    data['feedback'] = this.feedback;
    if (this.reservationEvents != null) {
      data['reservationEvents'] =
          this.reservationEvents!.map((v) => v.toJson()).toList();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class TaskObject {
  String? id;
  String? nickName;
  String? year;
  String? plateNumber;
  String? type;
  String? image;

  TaskObject(
      {this.id,
        this.nickName,
        this.year,
        this.plateNumber,
        this.type,
        this.image});

  TaskObject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickName = json['nickName'];
    year = json['year'];
    plateNumber = json['plateNumber'];
    type = json['type'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nickName'] = this.nickName;
    data['year'] = this.year;
    data['plateNumber'] = this.plateNumber;
    data['type'] = this.type;
    data['image'] = this.image;
    return data;
  }
}

class ReservationEvents {
  String? id;
  String? partnerId;
  String? customerId;
  String? reservationStatus;
  String? statusColor;
  String? statusText;
  Null? statusExtraText;
  String? logTime;

  ReservationEvents(
      {this.id,
        this.partnerId,
        this.customerId,
        this.reservationStatus,
        this.statusColor,
        this.statusText,
        this.statusExtraText,
        this.logTime});

  ReservationEvents.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    partnerId = json['partnerId'];
    customerId = json['customerId'];
    reservationStatus = json['reservationStatus'];
    statusColor = json['statusColor'];
    statusText = json['statusText'];
    statusExtraText = json['statusExtraText'];
    logTime = json['logTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['partnerId'] = this.partnerId;
    data['customerId'] = this.customerId;
    data['reservationStatus'] = this.reservationStatus;
    data['statusColor'] = this.statusColor;
    data['statusText'] = this.statusText;
    data['statusExtraText'] = this.statusExtraText;
    data['logTime'] = this.logTime;
    return data;
  }
}

class Customer {
  String? id;
  String? loginWith;
  String? methodUID;
  String? password;
  String? name;
  String? email;
  String? photoUrl;
  Null? homeLatitude;
  Null? homeLongitude;
  String? utcTimeZoneOffset;
  String? fcmToken;
  Null? userExtraDetails;

  Customer(
      {this.id,
        this.loginWith,
        this.methodUID,
        this.password,
        this.name,
        this.email,
        this.photoUrl,
        this.homeLatitude,
        this.homeLongitude,
        this.utcTimeZoneOffset,
        this.fcmToken,
        this.userExtraDetails});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    loginWith = json['loginWith'];
    methodUID = json['methodUID'];
    password = json['password'];
    name = json['name'];
    email = json['email'];
    photoUrl = json['photoUrl'];
    homeLatitude = json['homeLatitude'];
    homeLongitude = json['homeLongitude'];
    utcTimeZoneOffset = json['utcTimeZoneOffset'];
    fcmToken = json['fcmToken'];
    userExtraDetails = json['userExtraDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['loginWith'] = this.loginWith;
    data['methodUID'] = this.methodUID;
    data['password'] = this.password;
    data['name'] = this.name;
    data['email'] = this.email;
    data['photoUrl'] = this.photoUrl;
    data['homeLatitude'] = this.homeLatitude;
    data['homeLongitude'] = this.homeLongitude;
    data['utcTimeZoneOffset'] = this.utcTimeZoneOffset;
    data['fcmToken'] = this.fcmToken;
    data['userExtraDetails'] = this.userExtraDetails;
    return data;
  }
}