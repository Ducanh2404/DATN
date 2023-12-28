import 'package:project/all_imports.dart';
import 'package:project/views/admin/screens/dashboard/components/account_manage.dart';
import 'package:project/views/admin/screens/dashboard/components/categories_manage.dart';
import 'package:project/views/admin/screens/dashboard/components/order_manage.dart';
import 'package:project/views/admin/screens/dashboard/components/products_manage.dart';

class SideMenu extends StatelessWidget {
  final Function(Widget) changeWidget;
  const SideMenu({
    Key? key,
    required this.changeWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              padding: EdgeInsets.all(20),
              child: Image(
                image: AssetImage('img/logo.png'),
              )),
          DrawerListTile(
            title: "Sản phẩm",
            press: () {
              changeWidget(ProductsManage());
              Navigator.pop(context);
            },
            icon: FaIcon(
              FontAwesomeIcons.boxOpen,
              size: 18,
            ),
          ),
          DrawerListTile(
            title: "Đơn hàng",
            icon: FaIcon(
              FontAwesomeIcons.receipt,
              size: 18,
            ),
            press: () {
              changeWidget(OrderManage());
              Navigator.pop(context);
              ;
            },
          ),
          DrawerListTile(
            title: "Danh Mục",
            icon: FaIcon(
              FontAwesomeIcons.tableList,
              size: 18,
            ),
            press: () {
              changeWidget(CategoriesManage());
              Navigator.pop(context);
            },
          ),
          DrawerListTile(
            title: "Tài khoản",
            icon: FaIcon(
              FontAwesomeIcons.user,
              size: 18,
            ),
            press: () {
              changeWidget(AccountManage());
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.press,
    required this.icon,
  }) : super(key: key);

  final FaIcon icon;
  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 10.0,
      leading: icon,
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
