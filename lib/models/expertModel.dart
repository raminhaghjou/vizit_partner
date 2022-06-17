import 'package:vizitland_partner/models/reviewModel.dart';

class Expert {
  int vendor_id;
  String staff_name;
  int staff_phone;
  String staff_password;
  int staff_varient_editable;
  int staff_service_for;
  String staff_varient;
  String staff_image;
  String staff_certificate;
  String staff_description;
  int staff_id;
  List<Review> review = [];

  Expert();
  Map<String, dynamic> toJson() => {
        'vendor_id': vendor_id != null ? vendor_id : null,
        'staff_name': staff_name != null ? staff_name : null,
        'staff_phone': staff_phone != null ? staff_phone : null,
        'staff_password': staff_password != null ? staff_password : null,
        'staff_varient_editable':
            staff_varient_editable != null ? staff_varient_editable : null,
        'staff_service_for':
            staff_service_for != null ? staff_service_for : null,
        'staff_varient': staff_varient != null ? staff_varient : null,
        'staff_image': staff_image != null ? staff_image : null,
        'staff_certificate':
            staff_certificate != null ? staff_certificate : null,
        'staff_description':
            staff_description != null ? staff_description : null,
        'staff_id': staff_id != null ? staff_id : null,
      };

  Expert.fromJson(Map<String, dynamic> json) {
    try {
      vendor_id = json['vendor_id'] != null ? json['vendor_id'] : null;
      staff_name = json['staff_name'] != null ? json['staff_name'] : null;
      staff_phone = json['staff_phone'] != null ? json['staff_phone'] : null;
      staff_password =
          json['staff_password'] != null ? json['staff_password'] : null;
      staff_varient_editable = json['staff_varient_editable'] != null
          ? json['staff_varient_editable']
          : null;
      staff_service_for =
          json['staff_service_for'] != null ? json['staff_service_for'] : null;
      staff_varient =
          json['staff_varient'] != null ? json['staff_varient'] : null;
      staff_image = json['staff_image'] != null ? json['staff_image'] : null;
      staff_certificate =
          json['staff_certificate'] != null ? json['staff_certificate'] : null;
      staff_description =
          json['staff_description'] != null ? json['staff_description'] : null;
      staff_id = json['staff_id'] != null ? json['staff_id'] : null;
    } catch (e) {
      print("Exception - expertModel.dart - Expert.fromJson():" + e.toString());
    }
  }
}
