import 'package:project/all_imports.dart';

class MenuItems extends StatefulWidget {
  const MenuItems({Key? key}) : super(key: key);

  @override
  _MenuItemsState createState() => _MenuItemsState();
}

class _MenuItemsState extends State<MenuItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: Color(0xFF29324e)),
      alignment: Alignment.center,
      child: SizedBox(
          width: 1600,
          child: Row(
            children: [
              MenuBar(
                style: MenuStyle(
                  surfaceTintColor:
                      MaterialStatePropertyAll<Color>(Color(0xFF29324e)),
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Color(0xFF29324e)),
                  shadowColor:
                      MaterialStatePropertyAll<Color>(Colors.transparent),
                ),
                children: <Widget>[
                  SubmenuButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    menuChildren: <Widget>[
                      MenuItemButton(
                        onPressed: () {},
                        child: const MenuAcceleratorLabel('Laptop'),
                      ),
                      MenuItemButton(
                        onPressed: () {},
                        child: const MenuAcceleratorLabel('Linh kiện'),
                      ),
                      MenuItemButton(
                        onPressed: () {},
                        child: const MenuAcceleratorLabel('Màn hình'),
                      ),
                    ],
                    child: const MenuAcceleratorLabel('Danh mục sản phẩm'),
                  ),
                  MenuItemButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    child: const MenuAcceleratorLabel('Khuyến mãi'),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
