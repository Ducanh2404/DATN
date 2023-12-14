import 'package:project/all_imports.dart';

class ShipInfo extends StatefulWidget {
  const ShipInfo({
    super.key,
  });

  @override
  State<ShipInfo> createState() => _ShipInfoState();
}

class _ShipInfoState extends State<ShipInfo> {
  List<String> cities = [
    'Hà Nội',
    'Hồ Chí Minh',
    'Bà Rịa',
    'Bạc Liêu',
    'Bảo Lộc',
    'Bắc Giang ',
    'Bắc Kạn',
    'Hà Tĩnh',
    'Huế',
    'Nam Định',
    'Thanh Hóa',
  ];
  final TextEditingController cityController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String? selectedCity;
  PayMethod? method = PayMethod.banking;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Thông tin giao hàng",
            style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
        SizedBox(
          height: 24,
        ),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                          style: BorderStyle.solid)),
                  labelText: 'Họ và tên người nhận',
                ),
              ),
            ),
            SizedBox(
              width: 24,
            ),
            Expanded(
              flex: 5,
              child: TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.grey,
                          style: BorderStyle.solid)),
                  labelText: 'Số điện thoại',
                ),
              ),
            )
          ],
        ),
        SizedBox(
          height: 24,
        ),
        Row(
          children: [
            Expanded(
              flex: 5,
              child: DropdownMenu(
                inputDecorationTheme: InputDecorationTheme(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                            style: BorderStyle.solid))),
                expandedInsets: EdgeInsets.all(0),
                controller: cityController,
                requestFocusOnTap: true,
                label: Text('Chọn tỉnh/thành phố'),
                onSelected: (String? city) {
                  setState(() {
                    selectedCity = city;
                  });
                },
                dropdownMenuEntries: cities.map((city) {
                  return DropdownMenuEntry<String>(
                    value: '',
                    label: city,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 24,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                    border: BorderDirectional(
                        bottom: BorderSide(width: 1, color: Colors.grey))),
                child: TextField(
                  maxLines: 3,
                  controller: addressController,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                            style: BorderStyle.solid)),
                    labelText: 'Địa chỉ nhận hàng',
                  ),
                ),
              ),
            )
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Text("Hình thức thanh toán",
              style:
                  const TextStyle(fontWeight: FontWeight.w900, fontSize: 20)),
        ),
        Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: const Text('Thanh toán khi nhận hàng'),
              leading: Radio<PayMethod>(
                value: PayMethod.banking,
                groupValue: method,
                onChanged: (PayMethod? value) {
                  setState(() {
                    method = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Thanh toán chuyển khoản'),
              leading: Radio<PayMethod>(
                value: PayMethod.money,
                groupValue: method,
                onChanged: (PayMethod? value) {
                  setState(() {
                    method = value;
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

enum PayMethod { banking, money }
