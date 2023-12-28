import 'package:project/views/admin/controllers/MenuAppController.dart';
import 'package:project/views/admin/responsive.dart';
import 'package:project/views/admin/screens/dashboard/components/products_manage.dart';
import 'package:project/views/admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/side_menu.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget displayWidget = const ProductsManage();

  void changeWidget(Widget widget) {
    setState(() {
      displayWidget = widget;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(
        changeWidget: changeWidget,
      ),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // side menu desktop
            if (Responsive.isDesktop(context))
              Expanded(
                //  1/6 screen
                child: SideMenu(changeWidget: changeWidget),
              ),
            Expanded(
              flex: 5,
              child: DashboardScreen(
                displayWidget: displayWidget,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
