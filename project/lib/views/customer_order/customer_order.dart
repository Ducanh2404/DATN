import 'package:project/all_imports.dart';

class CustomerOrder extends StatefulWidget {
  const CustomerOrder({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomerOrder> createState() => _CustomerOrderState();
}

class _CustomerOrderState extends State<CustomerOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFf3f3f3),
          ),
          child: Column(children: [
            Header(),
            CustomerOrderList(),
            Footer(),
          ]),
        ),
      ),
    );
  }
}
