
class DriverInfoModel {
  DriverInfoModel({
    required this.success,
    required this.data,
    required this.message,
  });
  late final bool success;
  late final Data data;
  late final String message;

  DriverInfoModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = Data.fromJson(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.toJson();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.apiToken,
    required this.deviceToken,
    this.stripeId,
    this.cardBrand,
    this.cardLastFour,
    this.trialEndsAt,
    this.braintreeId,
    this.paypalEmail,
    required this.createdAt,
    required this.updatedAt,
    this.parentId,
    required this.driver,
    required this.customFields,
    required this.hasMedia,
    required this.media,
  });
  late final int id;
  late final String name;
  late final String email;
  late final String phone;
  late final String apiToken;
  late final String deviceToken;
  late final Null stripeId;
  late final Null cardBrand;
  late final Null cardLastFour;
  late final Null trialEndsAt;
  late final Null braintreeId;
  late final Null paypalEmail;
  late final String createdAt;
  late final String updatedAt;
  late final Null parentId;
  late final Driver driver;
  late final List<dynamic> customFields;
  late final bool hasMedia;
  late final List<dynamic> media;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    apiToken = json['api_token'];
    deviceToken = json['device_token'];
    stripeId = null;
    cardBrand = null;
    cardLastFour = null;
    trialEndsAt = null;
    braintreeId = null;
    paypalEmail = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    parentId = null;
    driver = Driver.fromJson(json['driver']);
    customFields = List.castFrom<dynamic, dynamic>(json['custom_fields']);
    hasMedia = json['has_media'];
    media = List.castFrom<dynamic, dynamic>(json['media']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['phone'] = phone;
    _data['api_token'] = apiToken;
    _data['device_token'] = deviceToken;
    _data['stripe_id'] = stripeId;
    _data['card_brand'] = cardBrand;
    _data['card_last_four'] = cardLastFour;
    _data['trial_ends_at'] = trialEndsAt;
    _data['braintree_id'] = braintreeId;
    _data['paypal_email'] = paypalEmail;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['parent_id'] = parentId;
    _data['driver'] = driver.toJson();
    _data['custom_fields'] = customFields;
    _data['has_media'] = hasMedia;
    _data['media'] = media;
    return _data;
  }
}

class Driver {
  Driver({
    required this.id,
    required this.userId,
    required this.deliveryFee,
    required this.totalOrders,
    required this.earning,
    required this.available,
    required this.createdAt,
    required this.updatedAt,
    this.birthOfDate,
    required this.driverFrontLicense,
    this.driverBackLicense,
    required this.IDFront,
    required this.IDBack,
    required this.VehicleFrontLicense,
    this.VehicleBackLicense,
    this.nationalID,
    required this.longitude,
    required this.latitude,
    required this.check,
    required this.customFields,
  });
  late final int id;
  late final int userId;
  late final int deliveryFee;
  late final int totalOrders;
  late final int earning;
  late final bool available;
  late final String createdAt;
  late final String updatedAt;
  late final Null birthOfDate;
  late final String driverFrontLicense;
  late final Null driverBackLicense;
  late final String IDFront;
  late final String IDBack;
  late final String VehicleFrontLicense;
  late final Null VehicleBackLicense;
  late final Null nationalID;
  late final int longitude;
  late final int latitude;
  late final bool check;
  late final List<dynamic> customFields;

  Driver.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    deliveryFee = json['delivery_fee'];
    totalOrders = json['total_orders'];
    earning = json['earning'];
    available = json['available'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    birthOfDate = null;
    driverFrontLicense = json['driver_front_license'];
    driverBackLicense = null;
    IDFront = json['ID_front'];
    IDBack = json['ID_back'];
    VehicleFrontLicense = json['Vehicle_front_license'];
    VehicleBackLicense = null;
    nationalID = null;
    longitude = json['longitude'];
    latitude = json['latitude'];
    check = json['check'];
    customFields = List.castFrom<dynamic, dynamic>(json['custom_fields']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['delivery_fee'] = deliveryFee;
    _data['total_orders'] = totalOrders;
    _data['earning'] = earning;
    _data['available'] = available;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['birth_of_date'] = birthOfDate;
    _data['driver_front_license'] = driverFrontLicense;
    _data['driver_back_license'] = driverBackLicense;
    _data['ID_front'] = IDFront;
    _data['ID_back'] = IDBack;
    _data['Vehicle_front_license'] = VehicleFrontLicense;
    _data['Vehicle_back_license'] = VehicleBackLicense;
    _data['nationalID'] = nationalID;
    _data['longitude'] = longitude;
    _data['latitude'] = latitude;
    _data['check'] = check;
    _data['custom_fields'] = customFields;
    return _data;
  }
}