class PartnerVarientModel {
  int varientId;
  //int serviceId;
  String varient;
  // int price;
  // int time;
  // String serviceName;
  // int vendorId;
  // int accessVarientId;
  // String deletedAt;
  // String enVarient;
  // String enServiceName;
  // AccessVarient accessVarient;

  PartnerVarientModel(
      {this.varientId,
      //this.serviceId,
      this.varient,
      // this.price,
      // this.time,
      // this.serviceName,
      // this.vendorId,
      // this.accessVarientId,
      // this.deletedAt,
      // this.enVarient,
      // this.enServiceName,
      // this.accessVarient
      });

  PartnerVarientModel.fromJson(Map<String, dynamic> json) {
    try {
      varientId = json['varient_id'] != null ? json['varient_id'] : null;
      //serviceId = json['service_id'] != null ? json['service_id'] : null;
      varient = json['varient'] != null ? json['varient'] : null;
      // price = json['price'] != null ? json['price'] : null;
      // time = json['time'] != null ? json['time'] : null;
      // serviceName = json['service_name'] != null ? json['service_name'] : null;
      // vendorId = json['vendor_id'] != null ? json['vendor_id'] : null;
      // accessVarientId = json['access_varient_id'] != null ? json['access_varient_id'] : null;
      // deletedAt = json['deleted_at'] != null ? json['deleted_at'] : null;
      // enVarient = json['en_varient'] != null ? json['en_varient'] : null;
      // enServiceName = json['en_service_name'] != null ? json['en_service_name'] : null;
      // accessVarient = json['access_varient'] != null
      //     ? new AccessVarient.fromJson(json['access_varient'])
      //     : null;
    } catch (e) {
      print("Exception - serviceVariantModel.dart - serviceModel.fromJson():" + e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['varient_id'] = this.varientId != null ? this.varientId : null;
    //data['service_id'] = this.serviceId != null ? this.serviceId : null;
    data['varient'] = this.varient != null ? this.varient : null;
    // data['price'] = this.price != null ? this.price : null;
    // data['time'] = this.time != null ? this.time : null;
    // data['service_name'] = this.serviceName != null ? this.serviceName : null;
    // data['vendor_id'] = this.vendorId != null ? this.vendorId : null;
    // data['access_varient_id'] = this.accessVarientId != null ? this.accessVarientId : null;
    // data['deleted_at'] = this.deletedAt != null ? this.deletedAt : null;
    // data['en_varient'] = this.enVarient != null ? this.enVarient : null;
    // data['en_service_name'] = this.enServiceName != null ? this.enServiceName : null;
    // if (this.accessVarient != null) {
    //   data['access_varient'] = this.accessVarient.toJson();
    // }
    return data;
  }
}

class AccessVarient {
  int id;
  int serviceId;
  String varient;
  int price;
  int time;
  String serviceName;
  String varientImage;
  int adminId;
  String enVarient;
  String enServiceName;
  String createdAt;
  String updatedAt;

  AccessVarient(
      {this.id,
      this.serviceId,
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

  AccessVarient.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'] : null;
    serviceId = json['service_id'] != null ? json['service_id'] : null;
    varient = json['varient'] != null ? json['varient'] : null;
    price = json['price'] != null ? json['price'] : null;
    time = json['time'] != null ? json['time'] : null;
    serviceName = json['service_name'] != null ? json['service_name'] : null;
    varientImage = json['varient_image'] != null ? json['varient_image'] : null;
    adminId = json['admin_id'] != null ? json['admin_id'] : null;
    enVarient = json['en_varient'] != null ? json['en_varient'] : null;
    enServiceName = json['en_service_name'] != null ? json['en_service_name'] : null;
    createdAt = json['created_at'] != null ? json['created_at'] : null;
    updatedAt = json['updated_at'] != null ? json['updated_at'] : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id != null ? this.id : null;
    data['service_id'] = this.serviceId != null ? this.serviceId : null;
    data['varient'] = this.varient != null ? this.varient : null;
    data['price'] = this.price != null ? this.price : null;
    data['time'] = this.time != null ? this.time : null;
    data['service_name'] = this.serviceName != null ? this.serviceName : null;
    data['varient_image'] = this.varientImage != null ? this.varientImage : null;
    data['admin_id'] = this.adminId != null ? this.adminId : null;
    data['en_varient'] = this.enVarient != null ? this.enVarient : null;
    data['en_service_name'] = this.enServiceName != null ? this.enServiceName : null;
    data['created_at'] = this.createdAt != null ? this.createdAt : null;
    data['updated_at'] = this.updatedAt != null ? this.updatedAt : null;
    return data;
  }
}
