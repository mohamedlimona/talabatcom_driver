class ListOrdersModel {
  ListOrdersModel({
    required this.success,
    required this.data,
    required this.message,
  });
  late final bool success;
  late final List<Data> data;
  late final String message;

  ListOrdersModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['message'] = message;
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.userId,
    required this.marketId,
    required this.orderStatusId,
    required this.tax,
    this.deliveryFee,
    required this.hint,
    required this.active,
    required this.driverId,
    required this.deliveryAddressId,
    required this.paymentId,
    required this.createdAt,
    required this.updatedAt,
    required this.timing,
    this.reasonRefused,
    required this.disable,
    required this.user,
    required this.payment,
    required this.address,
  });
  late final int id;
  late final int userId;
  late final int marketId;
  late final int orderStatusId;
  late final int tax;
  late final int? deliveryFee;
  late final String? hint;
  late final bool active;
  late final int driverId;
  late final int deliveryAddressId;
  late final int paymentId;
  late final String createdAt;
  late final String updatedAt;
  late final int timing;
  late final Null reasonRefused;
  late final int disable;
  late final User user;
  late final Payment payment;
  late final Address address;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    userId = json['user_id'];
    marketId = json['market_id'];
    orderStatusId = json['order_status_id'];
    tax = json['tax'];
    deliveryFee = null;
    hint = json['hint'];
    active = json['active'];
    driverId = json['driver_id'];
    deliveryAddressId = json['delivery_address_id'];
    paymentId = json['payment_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    timing = json['timing'];
    reasonRefused = null;
    disable = json['disable'];
    user = User.fromJson(json['user']);
    payment = Payment.fromJson(json['payment']);
    address = Address.fromJson(json['address']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['user_id'] = userId;
    _data['market_id'] = marketId;
    _data['order_status_id'] = orderStatusId;
    _data['tax'] = tax;
    _data['delivery_fee'] = deliveryFee;
    _data['hint'] = hint;
    _data['active'] = active;
    _data['driver_id'] = driverId;
    _data['delivery_address_id'] = deliveryAddressId;
    _data['payment_id'] = paymentId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['timing'] = timing;
    _data['reason_refused'] = reasonRefused;
    _data['disable'] = disable;
    _data['user'] = user.toJson();
    _data['payment'] = payment.toJson();
    _data['address'] = address.toJson();
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.apiToken,
    this.deviceToken,
    this.stripeId,
    this.cardBrand,
    this.cardLastFour,
    this.trialEndsAt,
    this.braintreeId,
    this.paypalEmail,
    required this.createdAt,
    required this.updatedAt,
    this.parentId,
    required this.rate,
    required this.customFields,
    required this.hasMedia,
    required this.media,
  });
  late final int id;
  late final String name;
  late final String email;
  late final String phone;
  late final String apiToken;
  late final String? deviceToken;
  late final Null stripeId;
  late final Null cardBrand;
  late final Null cardLastFour;
  late final Null trialEndsAt;
  late final Null braintreeId;
  late final Null paypalEmail;
  late final String createdAt;
  late final String updatedAt;
  late final Null parentId;
  late final int rate;
  late final List<dynamic> customFields;
  late final bool hasMedia;
  late final List<Media> media;

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    apiToken = json['api_token'];
    deviceToken = null;
    stripeId = null;
    cardBrand = null;
    cardLastFour = null;
    trialEndsAt = null;
    braintreeId = null;
    paypalEmail = null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    parentId = null;
    rate = json['rate'];
    customFields = List.castFrom<dynamic, dynamic>(json['custom_fields']);
    hasMedia = json['has_media'];
    media = List.from(json['media']).map((e)=>Media.fromJson(e)).toList();
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
    _data['rate'] = rate;
    _data['custom_fields'] = customFields;
    _data['has_media'] = hasMedia;
    _data['media'] = media.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Media {
  Media({
    required this.id,
    required this.modelType,
    required this.modelId,
    required this.collectionName,
    required this.name,
    required this.fileName,
    required this.mimeType,
    required this.disk,
    required this.size,
    required this.manipulations,
    required this.customProperties,
    required this.responsiveImages,
    required this.orderColumn,
    required this.createdAt,
    required this.updatedAt,
    required this.url,
    required this.thumb,
    required this.icon,
    required this.formatedSize,
  });
  late final int id;
  late final String modelType;
  late final int modelId;
  late final String collectionName;
  late final String name;
  late final String fileName;
  late final String mimeType;
  late final String disk;
  late final int size;
  late final List<dynamic> manipulations;
  late final CustomProperties customProperties;
  late final List<dynamic> responsiveImages;
  late final int orderColumn;
  late final String createdAt;
  late final String updatedAt;
  late final String url;
  late final String thumb;
  late final String icon;
  late final String formatedSize;

  Media.fromJson(Map<String, dynamic> json){
    id = json['id'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    collectionName = json['collection_name'];
    name = json['name'];
    fileName = json['file_name'];
    mimeType = json['mime_type'];
    disk = json['disk'];
    size = json['size'];
    manipulations = List.castFrom<dynamic, dynamic>(json['manipulations']);
    customProperties = CustomProperties.fromJson(json['custom_properties']);
    responsiveImages = List.castFrom<dynamic, dynamic>(json['responsive_images']);
    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    url = json['url'];
    thumb = json['thumb'];
    icon = json['icon'];
    formatedSize = json['formated_size'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['model_type'] = modelType;
    _data['model_id'] = modelId;
    _data['collection_name'] = collectionName;
    _data['name'] = name;
    _data['file_name'] = fileName;
    _data['mime_type'] = mimeType;
    _data['disk'] = disk;
    _data['size'] = size;
    _data['manipulations'] = manipulations;
    _data['custom_properties'] = customProperties.toJson();
    _data['responsive_images'] = responsiveImages;
    _data['order_column'] = orderColumn;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['url'] = url;
    _data['thumb'] = thumb;
    _data['icon'] = icon;
    _data['formated_size'] = formatedSize;
    return _data;
  }
}

class CustomProperties {
  CustomProperties({
    required this.uuid,
    required this.userId,
    required this.generatedConversions,
  });
  late final String uuid;
  late final int userId;
  late final GeneratedConversions generatedConversions;

  CustomProperties.fromJson(Map<String, dynamic> json){
    uuid = json['uuid'];
    userId = json['user_id'];
    generatedConversions = GeneratedConversions.fromJson(json['generated_conversions']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['uuid'] = uuid;
    _data['user_id'] = userId;
    _data['generated_conversions'] = generatedConversions.toJson();
    return _data;
  }
}

class GeneratedConversions {
  GeneratedConversions({
    required this.thumb,
    required this.icon,
  });
  late final bool thumb;
  late final bool icon;

  GeneratedConversions.fromJson(Map<String, dynamic> json){
    thumb = json['thumb'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['thumb'] = thumb;
    _data['icon'] = icon;
    return _data;
  }
}

class Payment {
  Payment({
    required this.id,
    required this.price,
    required this.description,
    required this.userId,
    required this.status,
    required this.method,
    required this.createdAt,
    required this.updatedAt,
    required this.transactionId,
    required this.customFields,
  });
  late final int id;
  late final int price;
  late final String description;
  late final int userId;
  late final String status;
  late final String method;
  late final String createdAt;
  late final String updatedAt;
  late final String transactionId;
  late final List<dynamic> customFields;

  Payment.fromJson(Map<String, dynamic> json){
    id = json['id'];
    price = json['price'];
    description = json['description'];
    userId = json['user_id'];
    status = json['status'];
    method = json['method'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    transactionId = json['transaction_id'];
    customFields = List.castFrom<dynamic, dynamic>(json['custom_fields']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['price'] = price;
    _data['description'] = description;
    _data['user_id'] = userId;
    _data['status'] = status;
    _data['method'] = method;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['transaction_id'] = transactionId;
    _data['custom_fields'] = customFields;
    return _data;
  }
}

class Address {
  Address({
    required this.id,
    required this.area,
    required this.street,
    required this.buildingNum,
    required this.flatNum,
    required this.landmark,
    required this.type,
    required this.latitude,
    required this.longitude,
    required this.isDefault,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String area;
  late final String street;
  late final String buildingNum;
  late final String flatNum;
  late final String landmark;
  late final String type;
  late final dynamic latitude;
  late final dynamic longitude;
  late final dynamic isDefault;
  late final int userId;
  late final String createdAt;
  late final String updatedAt;

  Address.fromJson(Map<String, dynamic> json){
    id = json['id'];
    area = json['area'];
    street = json['street'];
    buildingNum = json['building_num'];
    flatNum = json['flat_num'];
    landmark = json['landmark'];
    type = json['type'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isDefault = json['is_default'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['area'] = area;
    _data['street'] = street;
    _data['building_num'] = buildingNum;
    _data['flat_num'] = flatNum;
    _data['landmark'] = landmark;
    _data['type'] = type;
    _data['latitude'] = latitude;
    _data['longitude'] = longitude;
    _data['is_default'] = isDefault;
    _data['user_id'] = userId;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}
