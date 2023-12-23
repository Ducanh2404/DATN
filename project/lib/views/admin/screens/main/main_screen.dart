import 'package:project/views/admin/controllers/MenuAppController.dart';
import 'package:project/views/admin/responsive.dart';
import 'package:project/views/admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // side menu desktop
            if (Responsive.isDesktop(context))
              Expanded(
                //  1/6 screen
                child: SideMenu(),
              ),
            Expanded(
              // 5/6 screen
              flex: 5,
              child: DashboardScreen(),
            ),
          ],
        ),
      ),
    );
  }
}
