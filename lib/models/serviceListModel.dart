
class ServiceList {
  int serviceId;
  String serviceName;
  int accessServiceId;
  String serviceImage;
  String createdAt;
  String updatedAt;
  String deletedAt;
  int vendorId;
  String enServiceName;
  List<Varients> varients = [];
  ServicesAccess servicesAccess;

  ServiceList(
      {this.serviceId,
      this.serviceName,
      this.accessServiceId,
      this.serviceImage,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.vendorId,
      this.enServiceName,
      this.varients,
      this.servicesAccess});

  Map<String, dynamic> toJson() {
      final Map<String, dynamic> data = new Map<String, dynamic>();
      data['service_id'] = this.serviceId;
      data['service_name'] = this.serviceName;
      data['access_service_id'] = this.accessServiceId;
      data['service_image'] = this.serviceImage;
      data['created_at'] = this.createdAt;
      data['updated_at'] = this.updatedAt;
      data['deleted_at'] = this.deletedAt;
      data['vendor_id'] = this.vendorId;
      data['en_service_name'] = this.enServiceName;
      if (this.varients != null) {
        data['varients'] = this.varients.map((v) => v.toJson()).toList();
      }
      if (this.servicesAccess != null) {
        data['services_access'] = this.servicesAccess.toJson();
      }
      return data;
    }

  ServiceList.fromJson(Map<String, dynamic> json) {
    try {
      serviceId = json['service_id'] != null ? json['vendor_id'] : null;
      serviceName = json['service_name'] != null ? json['service_id'] : null;
      accessServiceId = json['access_service_id'] != null ? json['service_name'] : null;
      serviceImage = json['service_image'] != null ? json['service_image'] : null;
      createdAt = json['created_at'] != null ? json['created_at'] : null;
      updatedAt = json['updated_at'] != null ? json['isActive'] : null;
      deletedAt = json['deleted_at'] != null ? json['user_id'] : null;
      vendorId = json['vendor_id'] != null ? json['service_for'] : null;
      enServiceName = json['en_service_name'] != null ? json['updated_at'] : null;
      // varients = (json['varients'] != null)
      //     ? List<Variants>.from(
      //         json['varients'].map((e) => Variants.fromJson(e)))
      //     : [];
      if (json['varients'] != null) {
        varients = <Varients>[];
        json['varients'].forEach((v) {
          varients.add(new Varients.fromJson(v));
        });
      }
      servicesAccess = json['services_access'] != null
        ? new ServicesAccess.fromJson(json['services_access'])
        : null;
    } catch (e) {
      print("Exception - serviceModel.dart - serviceModel.fromJson():" +
          e.toString());
    }
  }
}

class Varients {
  int varientId;
  int serviceId;
  String varient;
  int price;
  int time;
  String serviceName;
  int vendorId;
  int accessVarientId;
  String deletedAt;
  String enVarient;
  String enServiceName;

  Varients(
      {this.varientId,
      this.serviceId,
      this.varient,
      this.price,
      this.time,
      this.serviceName,
      this.vendorId,
      this.accessVarientId,
      this.deletedAt,
      this.enVarient,
      this.enServiceName});

  Varients.fromJson(Map<String, dynamic> json) {
    varientId = json['varient_id'];
    serviceId = json['service_id'];
    varient = json['varient'];
    price = json['price'];
    time = json['time'];
    serviceName = json['service_name'];
    vendorId = json['vendor_id'];
    accessVarientId = json['access_varient_id'];
    deletedAt = json['deleted_at'];
    enVarient = json['en_varient'];
    enServiceName = json['en_service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['varient_id'] = this.varientId;
    data['service_id'] = this.serviceId;
    data['varient'] = this.varient;
    data['price'] = this.price;
    data['time'] = this.time;
    data['service_name'] = this.serviceName;
    data['vendor_id'] = this.vendorId;
    data['access_varient_id'] = this.accessVarientId;
    data['deleted_at'] = this.deletedAt;
    data['en_varient'] = this.enVarient;
    data['en_service_name'] = this.enServiceName;
    return data;
  }
}

class ServicesAccess {
  int id;
  String serviceName;
  String serviceImage;
  int isActive;
  int userId;
  int serviceFor;
  String createdAt;
  String updatedAt;
  String deletedAt;

  ServicesAccess(
      {this.id,
      this.serviceName,
      this.serviceImage,
      this.isActive,
      this.userId,
      this.serviceFor,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  ServicesAccess.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['service_name'];
    serviceImage = json['service_image'];
    isActive = json['isActive'];
    userId = json['user_id'];
    serviceFor = json['service_for'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
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
    return data;
  }
}
