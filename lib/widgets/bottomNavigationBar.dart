import 'package:vizitland_partner/models/businessLayer/baseRoute.dart';
import 'package:vizitland_partner/screens/appointmentHistoryScreen.dart';
import 'package:vizitland_partner/screens/homeScreen.dart';
import 'package:vizitland_partner/screens/profileScreen.dart';
import 'package:vizitland_partner/screens/requestScreen.dart';
import 'package:vizitland_partner/widgets/drawerWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:rolling_nav_bar/rolling_nav_bar.dart';

class BottomNavigationWidget extends BaseRoute {
  BottomNavigationWidget({a, o}) : super(a: a, o: o, r: 'BottomNavigationWidget');
  @override
  _BottomNavigationWidgetState createState() => new _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends BaseRouteState {
  _BottomNavigationWidgetState() : super();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return exitAppDialog();
      },
      child: sc(
        Scaffold(
            bottomNavigationBar: Container(
              height: 61,
              width: MediaQuery.of(context).size.width,
              child: RollingNavBar.iconData(
                iconSize: 25,
                iconText: [
                  Text(
                    AppLocalizations.of(context).lbl_home_navigation,
                    style: TextStyle(fontSize: 10),
                  ),
                  Text(
                    AppLocalizations.of(context).lbl_request_navigation,
                    style: Theme.of(context).primaryTextTheme.bodyText2,
                  ),
                  Text(
                    AppLocalizations.of(context).lbl_appointment_navigation,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).primaryTextTheme.bodyText2,
                  ),
                  Text(
                    AppLocalizations.of(context).lbl_profile_navigation,
                    style: Theme.of(context).primaryTextTheme.bodyText2,
                  )
                ],
                iconData: [Icons.home, Icons.message, Icons.menu_book, Icons.person],
                animationCurve: Curves.easeOut,
                baseAnimationSpeed: 300,
                animationType: AnimationType.roll,
                indicatorColors: <Color>[Theme.of(context).primaryColor],
                onTap: _onItemTap,
              ),
            ),
            drawer: _selectedIndex == 0
                ? DrawerWidget(
                    a: widget.analytics,
                    o: widget.observer,
                  )
                : null,
            body: _children().elementAt(_selectedIndex)),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isloading = true;
  _onItemTap(int index) {
    _selectedIndex = index;
    setState(() {});
  }

  List<Widget> _children() => [HomeScreen(a: widget.analytics, o: widget.observer), RequestScreen(a: widget.analytics, o: widget.observer), AppointmentHistoryScreen(a: widget.analytics, o: widget.observer), ProfileScreen(a: widget.analytics, o: widget.observer)];

  @override
  void initState() {
    super.initState();
  }
}
