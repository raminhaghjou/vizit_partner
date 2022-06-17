import 'package:vizitland_partner/models/serviceVariantModel.dart';
import 'package:vizitland_partner/models/varientPriceTimeForm.dart';
import 'package:flutter/material.dart';
import 'package:vizitland_partner/models/businessLayer/global.dart' as global;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormServiceVarient extends StatefulWidget {
  final state = _FormServiceVarientState();
  //final OnDelete onDelete;

  FormServiceVarient({
    Key key,
    this.name,
    this.serviceVariant,
    //this.varientPriceTimeFormModel
  }) : super(key: key);

  final String name;
  VarientPriceTimeFormModel varientPriceTimeFormModel;
  ServiceVariant serviceVariant;

  @override
  _FormServiceVarientState createState() => state;

  TextEditingController _cServiceName = new TextEditingController();
  TextEditingController _cServicePrice = new TextEditingController();
  TextEditingController _cServiceTime = new TextEditingController();

  bool isValid() => state.validate();
}

class _FormServiceVarientState extends State<FormServiceVarient> {
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: form,
          child: Container(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
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
                      "${widget.name}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.orange),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextButton(
                          onPressed: () => {}, //widget.onSave(),
                          child: Text(
                            AppLocalizations.of(context).lbl_yes,
                            style: TextStyle(color: Colors.blue),
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
                    controller: widget._cServicePrice,
                    keyboardType: TextInputType.number,
                    onChanged: (value) =>
                        widget.serviceVariant.price = int.parse(value),
                    onSaved: (value) =>
                        widget.serviceVariant.price = int.parse(value),
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
                    controller: widget._cServiceTime,
                    keyboardType: TextInputType.number,
                    onChanged: (value) =>
                        widget.serviceVariant.time = int.parse(value),
                    onSaved: (value) =>
                        widget.serviceVariant.time = int.parse(value),
                    validator: (value) =>
                        value.length == 2 ? null : "Time is Not Valid",
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context).hnt_time,
                      contentPadding:
                          EdgeInsets.only(top: 10, left: 10, right: 10),
                    ),
                  ),
                ),
                // Expanded(
                //   child: SingleChildScrollView(
                //     physics: AlwaysScrollableScrollPhysics(),
                //     child: Padding(
                //       padding: EdgeInsets.only(
                //         top: 15,
                //         bottom: MediaQuery.of(context).viewInsets.bottom,
                //       ),
                //       child: Column(
                //         mainAxisSize: MainAxisSize.min,
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Container(
                //             margin: EdgeInsets.only(top: 30, bottom: 10),
                //             child: Text(
                //               widget.name,
                //               style: Theme.of(context).primaryTextTheme.headline3,
                //             ),
                //           ),
                //           // Container(
                //           //   margin: EdgeInsets.only(top: 10),
                //           //   child: Text(
                //           //     AppLocalizations.of(context).lbl_variant,
                //           //     style: Theme.of(context).primaryTextTheme.subtitle2,
                //           //   ),
                //           // ),
                //           // Padding(
                //           //   padding: const EdgeInsets.only(top: 5),
                //           //   child: TextFormField(
                //           //     textCapitalization: TextCapitalization.words,
                //           //     controller: widget._cServiceName,
                //           //     decoration: InputDecoration(hintText: AppLocalizations.of(context).hnt_service_name, contentPadding: EdgeInsets.only(top: 5, left: 10, right: 10)),
                //           //   ),
                //           // ),
                //           Container(
                //             margin: EdgeInsets.only(top: 10),
                //             child: Text(
                //               AppLocalizations.of(context).lbl_price,
                //               style: Theme.of(context).primaryTextTheme.subtitle2,
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(top: 5),
                //             child: TextFormField(
                //               controller: widget._cServicePrice,
                //               keyboardType: TextInputType.number,
                //               onChanged: (value) =>
                //                   widget._serviceVariant.price = value as int,
                //               onSaved: (value) =>
                //                   widget._serviceVariant.price = value as int,
                //               validator: (value) =>
                //                   value.length < 5 ? null : "Price is Not Valid",
                //               decoration: InputDecoration(
                //                 hintText: '${global.currency.currency_sign}' +
                //                     AppLocalizations.of(context).hnt_price,
                //                 contentPadding:
                //                     EdgeInsets.only(top: 10, left: 10, right: 10),
                //               ),
                //             ),
                //           ),
                //           Container(
                //             margin: EdgeInsets.only(top: 10),
                //             child: Text(
                //               AppLocalizations.of(context).lbl_time,
                //               style: Theme.of(context).primaryTextTheme.subtitle2,
                //             ),
                //           ),
                //           Padding(
                //             padding: const EdgeInsets.only(top: 5),
                //             child: TextFormField(
                //               controller: widget._cServiceTime,
                //               keyboardType: TextInputType.number,
                //               onChanged: (value) =>
                //                   widget._serviceVariant.time = value as int,
                //               onSaved: (value) =>
                //                   widget._serviceVariant.time = value as int,
                //               validator: (value) =>
                //                   value.length > 4 ? null : "Time is Not Valid",
                //               decoration: InputDecoration(
                //                 hintText: AppLocalizations.of(context).hnt_time,
                //                 contentPadding:
                //                     EdgeInsets.only(top: 10, left: 10, right: 10),
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                //   ],
                // ),
              ],
            ),
          ),
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
