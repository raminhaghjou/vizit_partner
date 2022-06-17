import 'package:vizitland_partner/models/serviceVariantModel.dart';

class Service {
  int vendor_id;
  String service_name;
  int access_service_id;
  String service_image;
  int service_id;
  int id;
  int isActive;
  int userId;
  int serviceFor;
  String createdAt;
  String updatedAt;
  String deletedAt;
  List<ServiceVariant> varients = [];

  Service(
      {this.service_id,
      this.id,
      this.service_name,
      this.access_service_id,
      this.service_image,
      this.isActive,
      this.userId,
      this.serviceFor,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.varients});
  Map<String, dynamic> toJson() => {
        'vendor_id': vendor_id != null ? vendor_id : null,
        'service_id': service_id != null ? service_id : null,
        'access_service_id':
            access_service_id != null ? access_service_id : null,
        'id': id != null ? id : null,
        'service_name': service_name != null ? service_name : null,
        'service_image': service_image != null ? service_image : null,
        'isActive': isActive != null ? isActive : null,
        'user_id': userId != null ? userId : null,
        'service_for': serviceFor != null ? serviceFor : null,
        'created_at': createdAt != null ? createdAt : null,
        'updated_at': updatedAt != null ? updatedAt : null,
        'deleted_at': deletedAt != null ? deletedAt : null,
        'varients':
            varients != null ? varients.map((v) => v.toJson()).toList() : null,
      };

  Service.fromJson(Map<String, dynamic> json) {
    try {
      vendor_id = json['vendor_id'] != null ? json['vendor_id'] : null;
      id = json['id'] != null ? json['id'] : null;
      service_id = json['service_id'] != null ? json['service_id'] : null;
      access_service_id =
          json['access_service_id'] != null ? json['access_service_id'] : null;
      service_name = json['service_name'] != null ? json['service_name'] : null;
      service_image =
          json['service_image'] != null ? json['service_image'] : null;
      createdAt = json['created_at'] != null ? json['created_at'] : null;
      isActive = json['isActive'] != null ? json['isActive'] : null;
      userId = json['user_id'] != null ? json['user_id'] : null;
      serviceFor = json['service_for'] != null ? json['service_for'] : null;
      updatedAt = json['updated_at'] != null ? json['updated_at'] : null;
      deletedAt = json['deleted_at'] != null ? json['deleted_at'] : null;
      varients = (json['access_varients'] != null)
          ? List<ServiceVariant>.from(
              json['access_varients'].map((e) => ServiceVariant.fromJson(e)))
          : [];
    } catch (e) {
      print("Exception - serviceModel.dart - serviceModel.fromJson():" +
          e.toString());
    }
  }
}
