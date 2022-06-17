import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vizitland_partner/models/businessLayer/baseRoute.dart';
import 'package:vizitland_partner/models/businessLayer/global.dart' as global;
import 'package:vizitland_partner/models/serviceVariantModel.dart';
import 'package:vizitland_partner/screens/serviceListScreen.dart';

class AddServiceVariantScreen extends BaseRoute {
  List<ServiceVariant> serviceVarientList = [];
  final ServiceVariant serviceVariant;
  final int serviceId;
  final int accessServiceId;

  AddServiceVariantScreen(this.serviceId,
      {a,
      o,
      this.serviceVariant,
      this.serviceVarientList,
      this.accessServiceId})
      : super(a: a, o: o, r: 'AddServiceVariantScreen');
  @override
  _AddServiceVariantVariantScreenState createState() =>
      new _AddServiceVariantVariantScreenState(this.serviceVariant,
          this.serviceId, this.serviceVarientList, this.accessServiceId);
}

class _AddServiceVariantVariantScreenState extends BaseRouteState {
  ServiceVariant serviceVariant = new ServiceVariant();
  int serviceId;
  int accessServiceId;
  List<ServiceVariant> serviceVarientList;
  // TextEditingController _cServiceName = new TextEditingController();
  // TextEditingController _cServicePrice0 = new TextEditingController();
  // TextEditingController _cServiceTime = new TextEditingController();
  List<TextEditingController> _cServicePrice = [];
  List<TextEditingController> _cServiceTime;

  ScrollController _controller;

  GlobalKey<ScaffoldState> _scaffoldKey;
  ServiceVariant _serviceVariant = new ServiceVariant();
  var dropdownval;

  _AddServiceVariantVariantScreenState(this.serviceVariant, this.serviceId,
      this.serviceVarientList, this.accessServiceId)
      : super();

  // List<FormServiceVarient> forms = List.empty(growable: true);
  GlobalKey<FormState> form;

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   _cServicePrice = <TextEditingController>[];
    //   _cServiceTime = <TextEditingController>[];
    //   for (var i = 0; i < serviceVarientList.length; i++) {
    //     var textEditingPriceController = TextEditingController(text: serviceVarientList[i].price.toString());
    //     _cServicePrice.add(textEditingPriceController);
    //     var textEditingTimeController =
    //         TextEditingController();
    //     _cServiceTime.add(textEditingTimeController);
    //   }
    // });
    return sc(
      WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop();
          return null;
        },
        child: Scaffold(
          // bottomNavigationBar: Container(
          //   margin: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
          //   width: MediaQuery.of(context).size.width,
          //   height: 50,
          //   child: TextButton(
          //     onPressed: () {
          //       FocusScope.of(context).unfocus();
          //       _addServiceVariant();
          //     },
          //     child: Text(
          //       AppLocalizations.of(context).btn_save_service_variant,
          //     ),
          //   ),
          //   decoration: BoxDecoration(
          //       color: Theme.of(context).primaryColor,
          //       borderRadius: BorderRadius.all(Radius.circular(10))),
          // ),
          resizeToAvoidBottomInset: false,
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: <Widget>[
                Container(
                  // height: 100,
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
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  margin: EdgeInsets.only(top: 80),
                  child: serviceVarientList.length < 0
                      ? Center(
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text("",
                                    style:
                                        Theme.of(context).textTheme.headline1),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(""),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          height: 200.0,
                          child: ListView.builder(
                            controller: _controller,
                            // physics: NeverScrollableScrollPhysics(),
                            // scrollDirection: Axis.horizontal,
                            physics: AlwaysScrollableScrollPhysics(),
                            addAutomaticKeepAlives: true,
                            shrinkWrap: true,
                            itemCount: serviceVarientList.length,
                            itemBuilder: (BuildContext context, int i) =>
                                // forms[i]
                                _form(i),
                          ),
                        ),
                  //   ],
                  // ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // _cServiceName.dispose();
    // _cServicePrice.dispose();
    // _cServiceTime.dispose();
    for (TextEditingController textEditingController in _cServicePrice) {
      textEditingController?.dispose();
    }
    for (TextEditingController textEditingController in _cServiceTime) {
      textEditingController?.dispose();
    }
    form = null;
    super.dispose();
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener); //the listener for up and down.
    super.initState();
    _init();
  }

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
    if (_controller.offset <= _controller.position.minScrollExtent &&
        !_controller.position.outOfRange) {
      setState(() {
        //you can do anything here
      });
    }
  }

  Future selectTime() async {
    try {
      final TimeOfDay _picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        initialEntryMode: TimePickerEntryMode.input,
      );
      return _picked;
    } catch (e) {
      print("Exception - addServiceVariantScreen.dart - selectTime(): " +
          e.toString());
      return null;
    }
  }

  _addServiceVariant(int index) async {
    try {
      // onSave();
      _serviceVariant.vendor_id = global.user.id;
      if (_cServicePrice[index].text != "") {
        _serviceVariant.price = int.parse(_cServicePrice[index].text);
      }
      if (_cServiceTime[index].text != "") {
        _serviceVariant.time = int.parse(_cServiceTime[index].text);
      }
      _serviceVariant.varient = serviceVarientList[index].varient;
      _serviceVariant.service_id = serviceVarientList[index].service_id;
      _serviceVariant.varient_id = serviceVarientList[index].varient_id;
      if (serviceVarientList[index].varient.isNotEmpty &&
          _cServicePrice[index].text.isNotEmpty &&
          _cServiceTime[index].text.isNotEmpty) {
        bool isConnected = await br.checkConnectivity();
        if (isConnected) {
          showOnlyLoaderDialog();

          if (_serviceVariant.varient_id != null) {
            await apiHelper
                .addServiceVariant(_serviceVariant, accessServiceId)
                .then((result) {
              if (result != null) {
                if (result.status == "1") {
                  hideLoader();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ServiceListScreen(
                            a: widget.analytics,
                            o: widget.observer,
                            screenId: 1,
                          )));
                } else {
                  hideLoader();
                  showSnackBar(
                      key: _scaffoldKey, snackBarMessage: '${result.message}');
                }
              }
            });
          } else //update
          {
            await apiHelper.editServiceVariant(_serviceVariant).then((result) {
              if (result != null) {
                if (result.status == "1") {
                  hideLoader();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ServiceListScreen(
                            a: widget.analytics,
                            o: widget.observer,
                            screenId: 1,
                          )));
                } else {
                  hideLoader();
                  showSnackBar(
                      key: _scaffoldKey, snackBarMessage: '${result.message}');
                }
              }
            });
          }
        } else {
          showNetworkErrorSnackBar(_scaffoldKey);
        }
      } else if (serviceVarientList[index].varient.isEmpty) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage:
                AppLocalizations.of(context).txt_please_enter_name);
      } else if (_cServicePrice[index].text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage:
                AppLocalizations.of(context).txt_please_enter_price);
      } else if (_cServiceTime[index].text.isEmpty) {
        showSnackBar(
            key: _scaffoldKey,
            snackBarMessage:
                AppLocalizations.of(context).txt_please_enter_time);
      }
    } catch (e) {
      print("Exception - addServiceVariantScreen.dart - _addServiceVariant():" +
          e.toString());
    }
  }

  _init() async {
    try {
      setState(() {
        _cServicePrice = <TextEditingController>[];
        _cServiceTime = <TextEditingController>[];
        for (var i = 0; i < serviceVarientList.length; i++) {
          var textEditingPriceController = TextEditingController(text: ' ');
          _cServicePrice.add(textEditingPriceController);
          var textEditingTimeController = TextEditingController(text: ' ');
          _cServiceTime.add(textEditingTimeController);
        }
        // for (var i = 0; i < serviceVarientList.length; i++) {
        //   ServiceVariant _serviceVarient =
        //       ServiceVariant(varient_id: forms.length);
        //   forms.add(FormServiceVarient(
        //     name: serviceVarientList[i].varient,
        //     serviceVariant: _serviceVarient,
        //   ));
        // }
      });
      // if (serviceVariant != null) {
      //   if (serviceVariant.varient_id != null) {
      //     _cServiceName.text = serviceVariant.varient;
      //     _cServicePrice.text = serviceVariant.price.toString();
      //     _cServiceTime.text = serviceVariant.time.toString();
      //     _serviceVariant.varient_id = serviceVariant.varient_id;
      //   }
      // }
    } catch (e) {
      print("Exception - addSeviceVariantScreen.dart - init():" + e.toString());
    }
  }

  // onSave() {
  //   bool allValid = true;

  //   //If any form validation function returns false means all forms are not valid
  //   forms.forEach((element) => allValid = (allValid && element.isValid()));

  //   if (allValid) {
  //     for (int i = 0; i < serviceVarientList.length; i++) {
  //       FormServiceVarient item = forms[i];
  //       debugPrint("Name: ${serviceVarientList[i].varient}");
  //       debugPrint("Price: ${item.serviceVariant.price.toString()}");
  //       debugPrint("Time: ${item.serviceVariant.time.toString()}");
  //     }
  //     //Submit Form Here
  //   } else {
  //     debugPrint("Form is Not Valid");
  //   }
  // }

  Widget _form(int index) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: form,
                child: Container(
                  padding:
                      const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${serviceVarientList[index].varient}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.orange),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                // child: ClipOval(
                                //   child: Material(
                                //     color: Colors.orange, // button color
                                //     child: InkWell(
                                //       splashColor: Colors.green, // splash color
                                //       onTap: () {}, // button pressed
                                //       child: Column(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.center,
                                //         children: <Widget>[
                                //           Icon(Icons.call), // icon
                                //           Text("Call"), // text
                                //         ],
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                child: ElevatedButton.icon(
                                  onPressed: () => {
                                    FocusScope.of(context).unfocus(),
                                    _addServiceVariant(index),
                                    this.serviceVarientList.removeAt(index),
                                  }, //widget.onSave(),
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    AppLocalizations.of(context)
                                        .btn_save_service_variant,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context)
                                          .primaryColor, //Color.fromARGB(255, 3, 133, 194),
                                      fixedSize: const Size(208, 43),
                                      padding: EdgeInsets.all(0)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          AppLocalizations.of(context).lbl_price,
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: TextFormField(
                          controller: _cServicePrice[index],
                          keyboardType: TextInputType.number,
                          onChanged: (value) =>
                              serviceVariant.price = int.parse(value),
                          onSaved: (value) =>
                              serviceVariant.price = int.parse(value),
                          validator: (value) =>
                              value.length >= 5 ? null : "Price is Not Valid",
                          decoration: InputDecoration(
                            hintText: '${global.currency.currency_sign}' +
                                AppLocalizations.of(context).hnt_price,
                            contentPadding:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          AppLocalizations.of(context).lbl_time,
                          style: Theme.of(context).primaryTextTheme.subtitle2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: TextFormField(
                          controller: _cServiceTime[index],
                          keyboardType: TextInputType.number,
                          onChanged: (value) =>
                              serviceVariant.time = int.parse(value),
                          onSaved: (value) =>
                              serviceVariant.time = int.parse(value),
                          validator: (value) =>
                              value.length == 2 ? null : "Time is Not Valid",
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).hnt_time,
                            contentPadding:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
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
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }
}
