class VendorServiceModel {
  int id;
  String serviceName;
  String serviceImage;
  int isActive;
  int userId;
  int serviceFor;
  String createdAt;
  String updatedAt;
  String deletedAt;
  List<AccessVarients> accessVarients;

  VendorServiceModel(
      {this.id,
      this.serviceName,
      this.serviceImage,
      this.isActive,
      this.userId,
      this.serviceFor,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.accessVarients});

  VendorServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['service_name'];
    serviceImage = json['service_image'];
    isActive = json['isActive'];
    userId = json['user_id'];
    serviceFor = json['service_for'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['access_varients'] != null) {
      accessVarients = <AccessVarients>[];
      json['access_varients'].forEach((v) {
        accessVarients.add(new AccessVarients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_name'] = this.serviceName;
    data['service_image'] = this.serviceImage;
    data['isActive'] = this.isActive;
    data['user_id'] = this.userId;
    data['service_for'] = this.serviceFor;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.accessVarients != null) {
      data['access_varients'] =
          this.accessVarients.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AccessVarients {
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

  AccessVarients(
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

  AccessVarients.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceId = json['service_id'];
    varient = json['varient'];
    price = json['price'];
    time = json['time'];
    serviceName = json['service_name'];
    varientImage = json['varient_image'];
    adminId = json['admin_id'];
    enVarient = json['en_varient'];
    enServiceName = json['en_service_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_id'] = this.serviceId;
    data['varient'] = this.varient;
    data['price'] = this.price;
    data['time'] = this.time;
    data['service_name'] = this.serviceName;
    data['varient_image'] = this.varientImage;
    data['admin_id'] = this.adminId;
    data['en_varient'] = this.enVarient;
    data['en_service_name'] = this.enServiceName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
