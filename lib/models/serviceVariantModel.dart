class ServiceVariant {
  int vendor_id;
  String varient;
  int price;
  int time;
  int service_id;
  int varient_id;
  String serviceName;
  String varientImage;
  int adminId;
  String enVarient;
  String enServiceName;
  String createdAt;
  String updatedAt;

  ServiceVariant(
      {this.vendor_id,
      this.varient_id,
      this.service_id,
      this.varient,
      this.price,
      this.time,
      this.serviceName,
      this.varientImage,
      this.adminId,
      this.enVarient,
      this.enServiceName,
      this.createdAt,
      this.updatedAt});
  Map<String, dynamic> toJson() => {
        'vendor_id': vendor_id != null ? vendor_id : null,
        'varient_id': varient_id != null ? varient_id : null,
        'service_id': service_id != null ? service_id : null,
        'price': price != null ? price : null,
        'varient': varient != null ? varient : null,
        'time': time != null ? time : null,
        'serviceName': serviceName != null ? serviceName : null,
        'varientImage': varientImage != null ? varientImage : null,
        'adminId': adminId != null ? adminId : null,
        'enVarient': enVarient != null ? enVarient : null,
        'enServiceName': enServiceName != null ? enServiceName : null,
        'createdAt': createdAt != null ? createdAt : null,
        'updatedAt': updatedAt != null ? updatedAt : null,
      };

  ServiceVariant.fromJson(Map<String, dynamic> json) {
    try {
      vendor_id = json['vendor_id'] != null ? json['vendor_id'] : null;
      varient_id = json['id'] != null ? json['id'] : null;
      service_id = json['service_id'] != null ? json['service_id'] : null;
      price = json['price'] != null ? json['price'] : null;
      varient = json['varient'] != null ? json['varient'] : null;
      time = json['time'] != null ? json['time'] : null;
      serviceName = json['service_name'] != null ? json['service_name'] : null;
      varientImage =
          json['varient_image'] != null ? json['varient_image'] : null;
      adminId = json['admin_id'] != null ? json['admin_id'] : null;
      enVarient = json['en_varient'] != null ? json['en_varient'] : null;
      enServiceName =
          json['en_service_name'] != null ? json['en_service_name'] : null;
      createdAt = json['created_at'] != null ? json['created_at'] : null;
      updatedAt = json['updated_at'] != null ? json['updated_at'] : null;
    } catch (e) {
      print("Exception - serviceVariantModel.dart - serviceModel.fromJson():" +
          e.toString());
    }
  }
}
