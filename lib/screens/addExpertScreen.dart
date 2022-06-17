import 'dart:developer';
import 'dart:io';
import 'dart:ui';

import 'package:vizitland_partner/dialogs/saveExpertDialog.dart';
import 'package:vizitland_partner/models/businessLayer/baseRoute.dart';
import 'package:vizitland_partner/models/businessLayer/global.dart' as global;
import 'package:vizitland_partner/models/expertModel.dart';
import 'package:vizitland_partner/models/partnerVarientModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddExpertScreen extends BaseRoute {
  final Expert experts;
  final List<PartnerVarientModel> selectedVarient;
  final List<MultiSelectItem<PartnerVarientModel>> items;
  AddExpertScreen({a, o, this.experts, this.selectedVarient, this.items})
      : super(a: a, o: o, r: 'AddExpertScreen');
  @override
  _AddExpertScreenState createState() =>
      new _AddExpertScreenState(this.experts, this.selectedVarient, this.items);
}

class _AddExpertScreenState extends BaseRouteState {
  Expert experts = new Expert();
  List<PartnerVarientModel> selectedVarient;
  List<MultiSelectItem<PartnerVarientModel>> items;
  TextEditingController _cStaffName = new TextEditingController();
  TextEditingController _cStaffPhone = new TextEditingController();
  TextEditingController _cStaffPassword = new TextEditingController();
  TextEditingController _cStaffConfirmPassword = new TextEditingController();
  TextEditingController _cStaffDescription = new TextEditingController();
  bool _showConfirmPasswordDescription = false;
  bool _showConfirmPassword = true;
  bool _showPassword = true;
  String selectedValue = null;
  final _dropdownFormKey = GlobalKey<FormState>();
  final _multiSelectKey = GlobalKey<FormFieldState>();
  GlobalKey<ScaffoldState> _scaffoldKey;
  File _tImage;
  File _tCertificate;
  String _password = '';
  String _confirmpassword = '';
  int _radioValue = 0;
  int _radioValueGender = 0;

  List<dynamic> _list = [];
  List<PartnerVarientModel> _varientList = [];
  int screenId;
  bool _isDataLoaded = false;
  List<DropdownMenuItem<PartnerVarientModel>> _dropdownMenuItems;
  // PartnerVarientModel _selectedVarient;
  List<PartnerVarientModel> _selectedVarient = [];
  List<MultiSelectItem<PartnerVarientModel>> _items = [];

  var _fEmail = FocusNode();
  var _fPhone = FocusNode();
  var _fPassword = FocusNode();
  var _fConfirmPassword = FocusNode();
  Expert _experts = new Expert();
  var dropdownval;
  _AddExpertScreenState(this.experts, this.selectedVarient, this.items)
      : super();

  @override
  Widget build(BuildContext context) {
    return sc(
      WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          return null;
        },
        child: Scaffold(
            bottomNavigationBar: Container(
              margin: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: TextButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  _addExperts();
                },
                child: Text(
                  AppLocalizations.of(context).btn_save_expert,
                ),
              ),
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
            ),
            resizeToAvoidBottomInset: false,
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              Theme.of(context).primaryColor,
                              BlendMode.screen,
                            ),
                            child: Image.asset(
                              'assets/banner.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: Platform.isAndroid
                              ? EdgeInsets.only(bottom: 15, left: 10, top: 10)
                              : EdgeInsets.only(bottom: 15, left: 10, top: 20),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.keyboard_arrow_left_outlined,
                                  color: Colors.black,
                                ),
                                Text(
                                  AppLocalizations.of(context).lbl_back,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17.5),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      margin: EdgeInsets.only(top: 80),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                margin: EdgeInsets.only(top: 30, bottom: 10),
                                child: Text(
                                  experts != null
                                      ? AppLocalizations.of(context)
                                          .lbl_edit_expert
                                      : AppLocalizations.of(context)
                                          .lbl_add_Expert,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline3,
                                )),
                            Expanded(
                              child: SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 15,
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom,
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppLocalizations.of(context)
                                            .lbl_expert_name,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle2,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          textCapitalization:
                                              TextCapitalization.words,
                                          controller: _cStaffName,
                                          focusNode: _fEmail,
                                          onFieldSubmitted: (val) {
                                            FocusScope.of(context)
                                                .requestFocus(_fPassword);
                                          },
                                          decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)
                                                    .hnt_expert_name,
                                            contentPadding: EdgeInsets.only(
                                                top: 5, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        AppLocalizations.of(context)
                                            .lbl_expert_phone,
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .subtitle2,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          textCapitalization:
                                              TextCapitalization.words,
                                          keyboardType: TextInputType.number,
                                          controller: _cStaffPhone,
                                          focusNode: _fPhone,
                                          onFieldSubmitted: (val) {
                                            FocusScope.of(context)
                                                .requestFocus(_fPhone);
                                          },
                                          decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)
                                                    .hnt_expert_phone,
                                            contentPadding: EdgeInsets.only(
                                                top: 5, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .lbl_expert_password,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle2,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          controller: _cStaffPassword,
                                          obscureText: _showPassword,
                                          validator: (val) => val.length < 6
                                              ? AppLocalizations.of(context)
                                                  .lbl_expert_password
                                              : null,
                                          onSaved: (val) => _password = val,
                                          decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)
                                                    .hnt_expert_password,
                                            contentPadding: EdgeInsets.only(
                                                top: 10, left: 10, right: 10),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _showPassword
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _showPassword =
                                                      !_showPassword;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .lbl_expert_confirmpassword,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle2,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          controller: _cStaffConfirmPassword,
                                          obscureText: _showConfirmPassword,
                                          validator: (val) => val.length < 6
                                              ? AppLocalizations.of(context)
                                                  .lbl_expert_confirmpassword
                                              : null,
                                          onSaved: (val) =>
                                              _confirmpassword = val,
                                          decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)
                                                    .hnt_expert_confirmpassword,
                                            contentPadding: EdgeInsets.only(
                                                top: 10, left: 10, right: 10),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                _showConfirmPassword
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _showConfirmPassword =
                                                      !_showConfirmPassword;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .lbl_expert_staff_can_edit_service_varient,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle2,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            new Radio(
                                              value: 0,
                                              groupValue: _radioValue,
                                              onChanged:
                                                  _handleRadioValueChange,
                                            ),
                                            new Text(
                                              AppLocalizations.of(context)
                                                  .lbl_yes,
                                              style:
                                                  new TextStyle(fontSize: 16.0),
                                            ),
                                            new Radio(
                                              value: 1,
                                              groupValue: _radioValue,
                                              onChanged:
                                                  _handleRadioValueChange,
                                            ),
                                            new Text(
                                              AppLocalizations.of(context)
                                                  .lbl_no,
                                              style: new TextStyle(
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .lbl_expert_service_for,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle2,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            new Radio(
                                              value: 1,
                                              groupValue: _radioValueGender,
                                              onChanged: _handleRadioGender,
                                            ),
                                            new Text(
                                              AppLocalizations.of(context)
                                                  .lbl_men,
                                              style:
                                                  new TextStyle(fontSize: 16.0),
                                            ),
                                            new Radio(
                                              value: 2,
                                              groupValue: _radioValueGender,
                                              onChanged: _handleRadioGender,
                                            ),
                                            new Text(
                                              AppLocalizations.of(context)
                                                  .lbl_women,
                                              style: new TextStyle(
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(.4),
                                          border: Border.all(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 2,
                                          ),
                                        ),
                                        margin: EdgeInsets.only(top: 10),
                                        // child: Text(
                                        //   AppLocalizations.of(context)
                                        //       .lbl_staff_varient,
                                        //   style: Theme.of(context)
                                        //       .primaryTextTheme
                                        //       .subtitle2,
                                        // ),
                                        child: Column(
                                          children: <Widget>[
                                            MultiSelectBottomSheetField(
                                              key: _multiSelectKey,
                                              initialChildSize: 0.4,
                                              listType:
                                                  MultiSelectListType.CHIP,
                                              searchable: true,
                                              buttonText: Text(
                                                  AppLocalizations.of(context)
                                                      .lbl_staff_varient),
                                              title: Text(
                                                  AppLocalizations.of(context)
                                                      .lbl_staff_varient),
                                              cancelText: Text(
                                                  AppLocalizations.of(context)
                                                      .lbl_back),
                                              confirmText: Text(
                                                  AppLocalizations.of(context)
                                                      .lbl_accepted),
                                              validator: (values) {
                                                if (values == null ||
                                                    values.isEmpty) {
                                                  return "Required";
                                                }
                                                return null;
                                              },
                                              initialValue: _selectedVarient,
                                              items: _items,
                                              onConfirm: (values) {
                                                setState(() {
                                                  values.forEach((element) {
                                                      _varientList.add(element);
                                                      _selectedVarient
                                                          .add(element);
                                                    });
                                                  //_selectedVarient = values;
                                                });
                                                _multiSelectKey.currentState
                                                    .validate();
                                              },
                                              chipDisplay:
                                                  MultiSelectChipDisplay(
                                                onTap: (value) {
                                                  setState(() {
                                                    _selectedVarient
                                                        .remove(value);
                                                  });
                                                  _multiSelectKey.currentState
                                                      .validate();
                                                  return _selectedVarient;
                                                },
                                              ),
                                            ),
                                            // _selectedVarient == null ||
                                            //         _selectedVarient.isEmpty
                                            //     ? Container(
                                            //         padding: EdgeInsets.all(10),
                                            //         alignment:
                                            //             Alignment.centerLeft,
                                            //         child: Text(
                                            //           "None selected",
                                            //           style: TextStyle(
                                            //               color:
                                            //                   Colors.black54),
                                            //         ))
                                            // :
                                            Container(),
                                          ],
                                        ),
                                      ),
                                      // DecoratedBox(
                                      //   decoration: BoxDecoration(
                                      //         // gradient: LinearGradient(
                                      //         //   colors: [
                                      //         //     Colors.redAccent,
                                      //         //     Colors.blueAccent,
                                      //         //     Colors.purpleAccent
                                      //         //     //add more colors
                                      //         //   ]),
                                      //         border: Border.all(color: Colors.black12, width:1), //border of dropdown button
                                      //         borderRadius: BorderRadius.circular(5),
                                      //         // boxShadow: <BoxShadow>[
                                      //         //   BoxShadow(
                                      //         //       color: Color.fromRGBO(0, 0, 0, 0.1), //shadow for button
                                      //         //       blurRadius: 1) //blur radius of shadow
                                      //         // ]
                                      //   ),
                                      // child:Padding(
                                      //   padding: const EdgeInsets.only(left:10, right:10, top: 3),
                                      //   child:
                                      //   // DropdownButtonFormField(
                                      //   //   decoration: InputDecoration(
                                      //   //     enabledBorder: OutlineInputBorder(
                                      //   //       borderSide: BorderSide(color: Colors.blue, width: 2),
                                      //   //       borderRadius: BorderRadius.circular(20),
                                      //   //     ),
                                      //   //     border: OutlineInputBorder(
                                      //   //       borderSide: BorderSide(color: Colors.blue, width: 2),
                                      //   //       borderRadius: BorderRadius.circular(20),
                                      //   //     ),
                                      //   //     filled: true,
                                      //   //     fillColor: Colors.blueAccent,
                                      //   //   ),
                                      //   //   validator: (value) => value == null ? "Select a country" : null,
                                      //   //   dropdownColor: Colors.blueAccent,
                                      //   //   value: _selectedVarient,
                                      //   //   onChanged: onChangeDropdownItem,
                                      //   //   items: _dropdownMenuItems)
                                      //   DropdownButton(
                                      //     value: _selectedVarient,
                                      //     items: _dropdownMenuItems,
                                      //     onChanged: onChangeDropdownItem,
                                      //     isExpanded: true, //make true to take width of parent widget
                                      //     underline: Container(), //empty line
                                      //     style: TextStyle(fontSize: 16, color: Colors.black),
                                      //     iconEnabledColor: Colors.black54,
                                      //   )
                                      // ),),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .lbl_description,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle2,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: TextFormField(
                                          textCapitalization:
                                              TextCapitalization.sentences,
                                          controller: _cStaffDescription,
                                          maxLines: 5,
                                          obscureText:
                                              _showConfirmPasswordDescription,
                                          decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)
                                                    .hnt_description,
                                            contentPadding: EdgeInsets.only(
                                                top: 10, left: 10, right: 10),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .lbl_upload_image,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle2,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2,
                                              color: Theme.of(context)
                                                  .inputDecorationTheme
                                                  .enabledBorder
                                                  .borderSide
                                                  .color),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        margin: EdgeInsets.only(top: 5),
                                        height: 300,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: _tImage == null
                                            ? experts == null
                                                ? GestureDetector(
                                                    onTap: () {
                                                      _showCupertinoModalSheet();
                                                      setState(() {});
                                                    },
                                                    child: Center(
                                                        child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.image,
                                                          size: 55,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .headline1
                                                              .color,
                                                        ),
                                                        Text(AppLocalizations
                                                                .of(context)
                                                            .lbl_tap_to_add_image)
                                                      ],
                                                    )),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      _showCupertinoModalSheet();
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      child: CachedNetworkImage(
                                                        imageUrl: global
                                                                .baseUrlForImage +
                                                            experts.staff_image,
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          height: 90,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  image:
                                                                      imageProvider)),
                                                        ),
                                                        placeholder: (context,
                                                                url) =>
                                                            Center(
                                                                child:
                                                                    CircularProgressIndicator()),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                      ),
                                                    ),
                                                  )
                                            : GestureDetector(
                                                onTap: () {
                                                  _showCupertinoModalSheet();
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: FileImage(
                                                                _tImage),
                                                            fit: BoxFit
                                                                .contain)),
                                                  ),
                                                ),
                                              ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .lbl_upload_certificate,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle2,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2,
                                              color: Theme.of(context)
                                                  .inputDecorationTheme
                                                  .enabledBorder
                                                  .borderSide
                                                  .color),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                        margin: EdgeInsets.only(top: 5),
                                        height: 300,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: _tCertificate == null
                                            ? experts == null
                                                ? GestureDetector(
                                                    onTap: () {
                                                      _showCupertinoModalSheetCertificate()();
                                                      setState(() {});
                                                    },
                                                    child: Center(
                                                        child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.image,
                                                          size: 55,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .headline1
                                                              .color,
                                                        ),
                                                        Text(AppLocalizations
                                                                .of(context)
                                                            .lbl_tap_to_add_image)
                                                      ],
                                                    )),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      _showCupertinoModalSheetCertificate()();
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  10)),
                                                      child: CachedNetworkImage(
                                                        imageUrl: global
                                                                .baseUrlForImage +
                                                            experts
                                                                .staff_certificate,
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          height: 90,
                                                          decoration: BoxDecoration(
                                                              image: DecorationImage(
                                                                  fit: BoxFit
                                                                      .contain,
                                                                  image:
                                                                      imageProvider)),
                                                        ),
                                                        placeholder: (context,
                                                                url) =>
                                                            Center(
                                                                child:
                                                                    CircularProgressIndicator()),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(Icons.error),
                                                      ),
                                                    ),
                                                  )
                                            : GestureDetector(
                                                onTap: () {
                                                  _showCupertinoModalSheetCertificate();
                                                },
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: FileImage(
                                                                _tCertificate),
                                                            fit: BoxFit
                                                                .contain)),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            )),
      ),
    );
  }

  // void _showMultiSelect(BuildContext context) async {
  //   await showModalBottomSheet(
  //     isScrollControlled: true, // required for min/max child size
  //     context: context,
  //     builder: (ctx) {
  //       return  MultiSelectBottomSheet(
  //         items: _items,
  //         initialValue: _selectedAnimals,
  //         onConfirm: (values) {...},
  //         maxChildSize: 0.8,
  //       );
  //     },
  //   );
  // }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
      }
    });
  }

  void _handleRadioGender(int value) {
    setState(() {
      _radioValueGender = value;
      switch (_radioValueGender) {
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  getVarients() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getVarients(global.user.id).then((result) {
          if (result != null) {
            if (result.status == "1") {
              // _varientList = result.recordList;
              _list = result.recordList;
              _items = _list
                  .map((varient) => MultiSelectItem<PartnerVarientModel>(
                      varient, varient.varient))
                  .toList();
            } else {
              // _varientList = [];
              _items = [];
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print(
          "Exception - addExpertScreen.dart - _getVarients():" + e.toString());
    }
  }

  // List<DropdownMenuItem<PartnerVarientModel>> buildDropdownMenuItems(
  //     List varients) {
  //   List<DropdownMenuItem<PartnerVarientModel>> items = List();
  //   for (PartnerVarientModel varient in varients) {
  //     items.add(
  //       DropdownMenuItem(
  //         value: varient,
  //         child: Text(varient.varient.toString()),
  //       ),
  //     );
  //   }
  //   return items;
  // }

  // onChangeDropdownItem(PartnerVarientModel selectedCompany) {
  //   setState(() {
  //     // _selectedVarient = selectedCompany;
  //   });
  // }

  init() async {
    try {
      await getVarients().then((value) {
        _selectedVarient.addAll(_varientList);
        setState(() {
          _selectedVarient.addAll(_varientList);
        });
      });
      //_dropdownMenuItems = buildDropdownMenuItems(_varientList);
      // _selectedVarient = _dropdownMenuItems[0].value;
      _isDataLoaded = true;
      if (experts != null) {
        if (experts.staff_id != null) {
          _cStaffName.text = experts.staff_name;
          _cStaffPhone.text = experts.staff_phone.toString();
          _radioValue = experts.staff_varient_editable;
          _radioValueGender = experts.staff_service_for;
          _cStaffDescription.text = experts.staff_description;
          _experts.staff_id = experts.staff_id;
        }
      }
      setState(() {});
    } catch (e) {
      print("Exception - addExpertScreen.dart - init():" + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  // @protected
  // @mustCallSuper
  // Future<void> didChangeDependencies() async {
  //     await getVarients();
  //  }

  _addExperts() async {
    try {
      _experts.vendor_id = global.user.id;
      _experts.staff_name = _cStaffName.text.trim();
      _experts.staff_phone = int.parse(_cStaffPhone.text.trim());
      _experts.staff_password = _cStaffPassword.text;
      _experts.staff_varient_editable = _radioValue;
      _experts.staff_service_for = _radioValueGender;
      List<int> _varientId = [];
      for (PartnerVarientModel varient in _selectedVarient) {
        _varientId.add(varient.varientId);
      }
      _experts.staff_varient = _varientId.join(',');
      _experts.staff_description = _cStaffDescription.text.trim();

      if (_cStaffName.text.isNotEmpty && _cStaffDescription.text.isNotEmpty) {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();

          if (_experts.staff_id == null) {
            if (_tImage != null) {
              await apiHelper
                  .addExpert(
                      _experts.vendor_id,
                      _experts.staff_name,
                      _experts.staff_phone,
                      _experts.staff_password,
                      _experts.staff_varient_editable,
                      _experts.staff_service_for,
                      _experts.staff_varient,
                      _experts.staff_description,
                      _tImage,
                      _tCertificate)
                  .then((result) {
                if (result.status == "1") {
                  hideLoader();
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => SaveExpertDialog(
                            a: widget.analytics,
                            o: widget.observer,
                          ));
                } else {
                  hideLoader();
                  showSnackBar(
                      key: _scaffoldKey, snackBarMessage: '${result.message}');
                }
              });
            } else {
              hideLoader();
              showSnackBar(
                  key: _scaffoldKey,
                  snackBarMessage:
                      AppLocalizations.of(context).txt_please_select_image);
            }
          } else //update
          {
            await apiHelper
                .editExpert(
                    _experts.vendor_id,
                    _experts.staff_name,
                    _experts.staff_phone,
                    _experts.staff_password,
                    _experts.staff_varient_editable,
                    _experts.staff_service_for,
                    _experts.staff_varient,
                    _experts.staff_description,
                    _tImage,
                    _tCertificate,
                    _experts.staff_id)
                .then((result) {
              if (result.status == "1") {
                hideLoader();
                showDialog(
                    context: context,
                    builder: (BuildContext context) => SaveExpertDialog(
                          a: widget.analytics,
                          o: widget.observer,
                        ));
              } else {
                hideLoader();
                showSnackBar(
                    key: _scaffoldKey, snackBarMessage: '${result.message}');
              }
            });
          }
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      } else if (_cStaffName.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage:
                AppLocalizations.of(context).txt_please_enter_name);
      } else if (_cStaffDescription.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage:
                AppLocalizations.of(context).txt_please_enter_description);
      }
    } catch (e) {
      print("Exception - addExpertScreen.dart - addExpert():" + e.toString());
    }
  }

  _showCupertinoModalSheet() {
    try {
      FocusScope.of(context).unfocus();

      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(AppLocalizations.of(context).lbl_action),
          actions: [
            CupertinoActionSheetAction(
              child: Text(AppLocalizations.of(context).lbl_take_picture,
                  style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br.openCamera();
                hideLoader();

                setState(() {});
              },
            ),
            CupertinoActionSheetAction(
              child: Text(AppLocalizations.of(context).lbl_choose_from_library,
                  style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tImage = await br.selectImageFromGallery();
                hideLoader();
                setState(() {});
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text(AppLocalizations.of(context).lbl_cancel,
                style: TextStyle(color: Color(0xFFFA692C))),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } catch (e) {
      print("Exception - addExpertScreen.dart - _showCupertinoModalSheet():" +
          e.toString());
    }
  }

  _showCupertinoModalSheetCertificate() {
    try {
      FocusScope.of(context).unfocus();

      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
          title: Text(AppLocalizations.of(context).lbl_action),
          actions: [
            CupertinoActionSheetAction(
              child: Text(AppLocalizations.of(context).lbl_take_picture,
                  style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tCertificate = await br.openCamera();
                hideLoader();

                setState(() {});
              },
            ),
            CupertinoActionSheetAction(
              child: Text(AppLocalizations.of(context).lbl_choose_from_library,
                  style: TextStyle(color: Color(0xFF171D2C))),
              onPressed: () async {
                Navigator.pop(context);
                showOnlyLoaderDialog();
                _tCertificate = await br.selectImageFromGallery();
                hideLoader();
                setState(() {});
              },
            )
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text(AppLocalizations.of(context).lbl_cancel,
                style: TextStyle(color: Color(0xFFFA692C))),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      );
    } catch (e) {
      print(
          "Exception - addExpertScreen.dart - _showCupertinoModalSheetCertificate():" +
              e.toString());
    }
  }
}
