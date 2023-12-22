import 'package:project/all_imports.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
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
            press: () {},
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
            press: () {},
          ),
          DrawerListTile(
            title: "Danh Mục",
            icon: FaIcon(
              FontAwesomeIcons.tableList,
              size: 18,
            ),
            press: () {},
          ),
          DrawerListTile(
            title: "Tài khoản",
            icon: FaIcon(
              FontAwesomeIcons.user,
              size: 18,
            ),
            press: () {},
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
