import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:vizitland_partner/dialogs/saveServiceDialog.dart';
import 'package:vizitland_partner/models/businessLayer/baseRoute.dart';
import 'package:vizitland_partner/models/businessLayer/global.dart' as global;
import 'package:vizitland_partner/models/partnerVarientModel.dart';
import 'package:vizitland_partner/models/serviceModel.dart';
import 'package:vizitland_partner/models/serviceVariantModel.dart';
import 'package:vizitland_partner/screens/addServiceVariantScreen.dart';

class AddServiceScreen extends BaseRoute {
  final Service service;

  AddServiceScreen({a, o, this.service})
      : super(a: a, o: o, r: 'AddServiceScreen');
  @override
  _AddServiceScreenState createState() =>
      new _AddServiceScreenState(this.service);
}

class _AddServiceScreenState extends BaseRouteState {
  Service service = new Service();
  File _tImage;
  TextEditingController _cServiceName = new TextEditingController();
  Service _service = new Service();
  GlobalKey<ScaffoldState> _scaffoldKey;
  var dropdownval;

  List<dynamic> _list = [];
  List<ServiceVariant> _varientList = [];
  List<ServiceVariant> _selectedVarientList = [];
  List<Service> _serviceList = [];
  bool _isDataLoaded = false;
  List<DropdownMenuItem<ServiceVariant>> _dropdownVarientItems;
  List<DropdownMenuItem<Service>> _dropdownServiceItems;
  final _multiSelectKey = GlobalKey<FormFieldState>();
  ServiceVariant _selectedVarient;
  Service _selectedService;
  List<MultiSelectItem<ServiceVariant>> _varientItems = [];
  List<MultiSelectItem<Service>> _serviceItems = [];
  List<MultiSelectItem<ServiceVariant>> _items = [];

  String _serviceSelected = '';
  String _varientSelected = '';
  int accessVarientId;
  String _serviceImage = '';

  _AddServiceScreenState(this.service) : super();

  @override
  Widget build(BuildContext context) {
    // print("service-- :" + service.access_service_id.toString());
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
                  _addService();
                },
                child: Text(
                  AppLocalizations.of(context).btn_save_service,
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
                                  service != null
                                      ? AppLocalizations.of(context)
                                          .lbl_edit_service
                                      : AppLocalizations.of(context)
                                          .lbl_Add_service,
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
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .lbl_service_name,
                                          style: Theme.of(context)
                                              .primaryTextTheme
                                              .subtitle2,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12,
                                              width:
                                                  1), //border of dropdown button
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10, top: 3),
                                            child: DropdownButton(
                                              value: _selectedService,
                                              items: _serviceList.map<
                                                      DropdownMenuItem<
                                                          Service>>(
                                                  (Service value) {
                                                return DropdownMenuItem(
                                                  value: value,
                                                  child: Row(
                                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      new CircleAvatar(
                                                        backgroundImage:
                                                            new NetworkImage(
                                                                "https://salon.vizitland.com/" +
                                                                    value
                                                                        .service_image),
                                                      ),
                                                      // Icon(valueItem.bank_logo),
                                                      SizedBox(
                                                        width: 15,
                                                      ),
                                                      Text(value.service_name),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),

                                              onChanged: onChangeDropdownItem,
                                              isExpanded:
                                                  true, //make true to take width of parent widget
                                              underline:
                                                  Container(), //empty line
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black),
                                              iconEnabledColor: Colors.black54,
                                            )),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      DecoratedBox(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black12,
                                              width:
                                                  1), //border of dropdown button
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10, top: 3),
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
                                                confirmText: Text(
                                                    AppLocalizations.of(context)
                                                        .lbl_accepted),
                                                cancelText: Text(
                                                    AppLocalizations.of(context)
                                                        .lbl_back),
                                                validator: (values) {
                                                  if (values == null ||
                                                      values.isEmpty) {
                                                    return "Required";
                                                  }
                                                  return null;
                                                },
                                                initialValue:
                                                    _selectedVarientList,
                                                items: _items,
                                                onConfirm: (values) {
                                                  setState(() {
                                                    values.forEach((element) {
                                                      _varientList.add(element);
                                                      _selectedVarientList
                                                          .add(element);
                                                    });
                                                    // _varientList = values;
                                                    // _selectedVarientList =
                                                    //     values;
                                                  });
                                                  _multiSelectKey.currentState
                                                      .validate();
                                                },
                                                chipDisplay:
                                                    MultiSelectChipDisplay(
                                                  onTap: (value) {
                                                    setState(() {
                                                      _selectedVarientList
                                                          .remove(value);
                                                    });
                                                    _multiSelectKey.currentState
                                                        .validate();
                                                    return _selectedVarientList;
                                                  },
                                                ),
                                              ),
                                              Container(),
                                            ],
                                          ),
                                          // DropdownButton(
                                          //   value: _selectedVarient,
                                          //   items: _varientList.map<
                                          //           DropdownMenuItem<
                                          //               AccessVarients>>(
                                          //       (AccessVarients value) {
                                          //     return DropdownMenuItem(
                                          //       value: value,
                                          //       child: Row(
                                          //         // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          //         children: [
                                          //           new CircleAvatar(
                                          //             backgroundImage:
                                          //                 new NetworkImage(
                                          //                     "https://salon.vizitland.com/" +
                                          //                         value
                                          //                             .varientImage),
                                          //           ),
                                          //           // Icon(valueItem.bank_logo),
                                          //           SizedBox(
                                          //             width: 15,
                                          //           ),
                                          //           Text(value.varient),
                                          //         ],
                                          //       ),
                                          //     );
                                          //   }).toList(),

                                          //   onChanged:
                                          //       onChangeDropdownVarientItem,
                                          //   isExpanded:
                                          //       true, //make true to take width of parent widget
                                          //   underline:
                                          //       Container(), //empty line
                                          //   style: TextStyle(
                                          //       fontSize: 16,
                                          //       color: Colors.black),
                                          //   iconEnabledColor: Colors.black54,
                                          // )
                                        ),
                                      ),
                                      // Container(
                                      //   margin: EdgeInsets.only(top: 10),
                                      //   child: Text(
                                      //     AppLocalizations.of(context).lbl_upload_image,
                                      //     style: Theme.of(context).primaryTextTheme.subtitle2,
                                      //   ),
                                      // ),
                                      // Container(
                                      //   decoration: BoxDecoration(
                                      //     border: Border.all(width: 2, color: Theme.of(context).inputDecorationTheme.enabledBorder.borderSide.color),
                                      //     borderRadius: BorderRadius.all(
                                      //       Radius.circular(10),
                                      //     ),
                                      //   ),
                                      //   margin: EdgeInsets.only(top: 5),
                                      //   height: 300,
                                      //   width: MediaQuery.of(context).size.width,
                                      //   child: _tImage == null
                                      //       ? service == null
                                      //           ? GestureDetector(
                                      //               onTap: () {
                                      //                 _showCupertinoModalSheet();
                                      //                 setState(() {});
                                      //               },
                                      //               child: Center(
                                      //                   child: Column(
                                      //                 mainAxisAlignment: MainAxisAlignment.center,
                                      //                 children: [
                                      //                   Icon(
                                      //                     Icons.image,
                                      //                     size: 55,
                                      //                     color: Theme.of(context).primaryTextTheme.headline1.color,
                                      //                   ),
                                      //                   Text(AppLocalizations.of(context).lbl_tap_to_add_image)
                                      //                 ],
                                      //               )),
                                      //             )
                                      //           : GestureDetector(
                                      //               onTap: () {
                                      //                 _showCupertinoModalSheet();
                                      //               },
                                      //               child: ClipRRect(
                                      //                 borderRadius: BorderRadius.all(Radius.circular(10)),
                                      //                 child: CachedNetworkImage(
                                      //                   imageUrl: global.baseUrlForImage + service.service_image,
                                      //                   imageBuilder: (context, imageProvider) => Container(
                                      //                     height: 90,
                                      //                     decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.contain, image: imageProvider)),
                                      //                   ),
                                      //                   placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                      //                   errorWidget: (context, url, error) => Icon(Icons.error),
                                      //                 ),
                                      //               ),
                                      //             )
                                      //       : GestureDetector(
                                      //           onTap: () {
                                      //             _showCupertinoModalSheet();
                                      //           },
                                      //           child: ClipRRect(
                                      //             borderRadius: BorderRadius.all(Radius.circular(10)),
                                      //             child: Container(
                                      //               decoration: BoxDecoration(image: DecorationImage(image: FileImage(_tImage), fit: BoxFit.contain)),
                                      //             ),
                                      //           ),
                                      //         ),
                                      // ),
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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  _addService() async {
    try {
      _service.vendor_id = global.user.id;
      _service.service_name = _serviceSelected;
      _service.access_service_id = accessVarientId;
      List<int> _varientId = [];
      for (ServiceVariant varient in _selectedVarientList) {
        _varientId.add(varient.varient_id);
      }
      _varientSelected = _varientId.join(',');
      // _serviceImage = _selectedService.serviceImage;

      File file = new File(_selectedService.service_image);
      String imageName = path.basename(file.path);

      _selectedService.service_id = _selectedService.id;

      if (_serviceSelected != '') {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();
          // if (_service.service_id == null) {
          if (_selectedService.id != null) {
            // if (_tImage != null) {
            await apiHelper
                .addService(
                    _service.vendor_id,
                    _service.service_name,
                    _varientSelected,
                    accessVarientId,
                    _selectedService.service_image)
                .then((result) {
              if (result.status == "1") {
                hideLoader();
                showDialog(
                    // context: context,
                    // builder: (BuildContext context) => SaveServiceDialog(
                    //       a: widget.analytics,
                    //       o: widget.observer,
                    //     ));
                    context: context,
                    builder: (BuildContext context) => AddServiceVariantScreen(
                          _selectedService.service_id,
                          serviceVarientList: _varientList,
                          accessServiceId: _service.access_service_id,
                          a: widget.analytics,
                          o: widget.observer,
                        ));
              } else {
                hideLoader();
                showSnackBar(
                    key: _scaffoldKey, snackBarMessage: '${result.message}');
              }
            });
            // } else {
            //   hideLoader();
            //   showSnackBar(
            //       key: _scaffoldKey,
            //       snackBarMessage:
            //           AppLocalizations.of(context).txt_please_select_image);
            // }
          } else //update
          {
            await apiHelper
                .editService(
                    _service.vendor_id,
                    _service.service_name,
                    _varientSelected,
                    accessVarientId,
                    _selectedService.service_image,
                    _selectedService.service_id)
                .then((result) {
              if (result.status == "1") {
                hideLoader();
                showDialog(
                    context: context,
                    builder: (BuildContext context) => SaveServiceDialog(
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
      } else if (_cServiceName.text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage:
                AppLocalizations.of(context).txt_please_enter_name);
      }
    } catch (e) {
      print(
          "Exception - addServicesScreen.dart - _addService():" + e.toString());
    }
  }

  // getVarients() async {
  //   try {
  //     bool isConnected = await br.checkConnectivity();
  //     if (isConnected) {
  //       await apiHelper.getVendorService(global.user.id).then((result) {
  //         if (result != null) {
  //           if (result.status == "1") {
  //             _varientList = result.recordList;
  //             _list = result.recordList;
  //             _items = _list
  //                 .map((varient) => MultiSelectItem<PartnerVarientModel>(
  //                     varient, varient.varient))
  //                 .toList();
  //           } else {
  //             // _varientList = [];
  //             _items = [];
  //           }
  //         }
  //       });
  //     } else {
  //       showNetworkErrorSnackBar(_scaffoldKey);
  //     }
  //   } catch (e) {
  //     print(
  //         "Exception - addExpertScreen.dart - _getVarients():" + e.toString());
  //   }
  // }

  getVarients() async {
    try {
      bool isConnected = await br.checkConnectivity();
      if (isConnected) {
        await apiHelper.getVendorService(global.user.id).then((result) {
          if (result != null) {
            if (result.status == "1") {
              _serviceList = result.recordList;
              _list = result.recordList;
              _serviceItems = _list
                  .map((serv) => MultiSelectItem<Service>(serv, serv.varients))
                  .toList();
              _varientList = [];
              _varientList = _serviceList[0].varients;

              setState(() {
                _items = _varientList
                    .map((varient) => MultiSelectItem<ServiceVariant>(
                        varient, varient.varient))
                    .toList();
              });
              // _varientItems = _list
              //     .map((varient) =>
              //         MultiSelectItem<AccessVarient>(varient, varient.varient))
              //     .toList();
            } else {
              _varientList = [];
              _serviceItems = [];
            }
          }
        });
      } else {
        showNetworkErrorSnackBar(_scaffoldKey);
      }
    } catch (e) {
      print(
          "Exception - addServiceScreen.dart - _getVarients():" + e.toString());
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

  List<DropdownMenuItem<Service>> buildDropdownMenuItems(List varients) {
    List<DropdownMenuItem<Service>> items = List();
    for (Service varient in varients) {
      items.add(
        DropdownMenuItem(
          value: varient,
          child: Text(varient.service_name.toString()),
        ),
      );
    }
    return items;
  }

  List<DropdownMenuItem<ServiceVariant>> buildDropdownVarientMenuItems(
      List varients) {
    List<DropdownMenuItem<ServiceVariant>> items = List();
    for (ServiceVariant varient in varients) {
      items.add(
        DropdownMenuItem(
          value: varient,
          child: Text(varient.varient.toString()),
        ),
      );
    }
    return items;
  }

  // onChangeDropdownItem(PartnerVarientModel selectedCompany) {
  //   setState(() {
  //     // _selectedVarient = selectedCompany;
  //   });
  // }

  onChangeDropdownItem(Service newSelectedVarient) {
    setState(() {
      _selectedService = newSelectedVarient;
      _varientList = [];
      _selectedVarientList = [];
      _varientList = _selectedService.varients;
      _selectedVarient = _selectedService.varients[0];
      _serviceSelected = newSelectedVarient.service_name;
      _selectedVarientList.addAll(_varientList);
      // accessVarientId = newSelectedVarient.service_id;
      accessVarientId = newSelectedVarient.id;
      _items = _varientList
          .map((varient) =>
              MultiSelectItem<ServiceVariant>(varient, varient.varient))
          .toList();
      // _varientList = _varientList
      //     .where((val) => val.serviceName == newSelectedVarient.serviceName)
      //     .toList();
    });
  }

  onChangeDropdownVarientItem(ServiceVariant newSelectedVarient) {
    setState(() {
      _selectedVarient = newSelectedVarient;
      _varientSelected = newSelectedVarient.varient;
      accessVarientId = newSelectedVarient.service_id;
    });
  }

  _init() async {
    try {
      await getVarients().then((value) {
        _selectedVarientList = [];
        _selectedVarientList.addAll(_varientList);
        _selectedService = _serviceList[0];
        _selectedVarient = _selectedService.varients[0];
        setState(() {
          _serviceSelected = _selectedService.service_name;
          // accessVarientId = _selectedService.service_id;
          accessVarientId = _selectedService.id;
          _items = _selectedService.varients
              .map((varient) =>
                  MultiSelectItem<ServiceVariant>(varient, varient.varient))
              .toList();
          _selectedVarientList.addAll(_varientList);
        });
        // print("Async done!");
      });
      _dropdownServiceItems = buildDropdownMenuItems(_serviceList);
      _dropdownVarientItems = buildDropdownVarientMenuItems(_varientList);
      var seen = Set<PartnerVarientModel>();
      // List<PartnerVarientModel> uniquelist = _dropdownMenuItems.where((country) => seen.add(country)).toList();
      // _selectedVarient = _dropdownMenuItems
      //     .map((e) => DropdownMenuItem<PartnerVarientModel>(e.key, e.value));
      // for (PartnerVarientModel varient in _varientList) {
      //   _selectedVarient.add(varient);
      // }
      if (service != null) {
        if (service.service_id != null) {
          _cServiceName.text = service.service_name;
          _service.service_id = service.service_id;
        }
      }
    } catch (e) {
      print("Exception - addServiceScreen.dart - init():" + e.toString());
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
      print("Exception - addServicesScreen.dart - _showCupertinoModalSheet():" +
          e.toString());
    }
  }
}
