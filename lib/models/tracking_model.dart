class Trackingmodel {
  Trackingmodel({
    required this.success,
    required this.data,
    required this.message,
  });
  late final bool success;
  late final Data data;
  late final String message;
  
  Trackingmodel.fromJson(Map<String, dynamic> json){
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
    required this.orderStatusId,
    required this.userId,
    required this.userLatitude,
    required this.userLongitude,
    required this.userRate,
    required this.paymentMethod,
    required this.totalPayment,
    required this.user,
  });
  late final int id;
  late final int orderStatusId;
  late final int userId;
  late final double userLatitude;
  late final double userLongitude;
  late final int userRate;
  late final String paymentMethod;
  late final dynamic totalPayment;
  late final User user;
  
  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    orderStatusId = json['order_status_id'];
    userId = json['user_id'];
    userLatitude = json['user_latitude'];
    userLongitude = json['user_longitude'];
    userRate = json['user_rate'];
    paymentMethod = json['payment_method'];
    totalPayment = json['total_payment'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['order_status_id'] = orderStatusId;
    _data['user_id'] = userId;
    _data['user_latitude'] = userLatitude;
    _data['user_longitude'] = userLongitude;
    _data['user_rate'] = userRate;
    _data['payment_method'] = paymentMethod;
    _data['total_payment'] = totalPayment;
    _data['user'] = user.toJson();
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.name,
     this.email,
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
    required this.customFields,
    required this.hasMedia,
    required this.media,
  });
  late final int id;
  late final String name;
  late final Null email;
  late final String phone;
  late final String apiToken;
  late final dynamic deviceToken;
  late final Null stripeId;
  late final Null cardBrand;
  late final Null cardLastFour;
  late final Null trialEndsAt;
  late final Null braintreeId;
  late final Null paypalEmail;
  late final String createdAt;
  late final String updatedAt;
  late final List<dynamic> customFields;
  late final bool hasMedia;
  late final List<Media> media;
  
  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = null;
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