import 'package:project/all_imports.dart';

class ShipInfo extends StatefulWidget {
  final Function(String) method;
  final TextEditingController cityController;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final String fieldCityError;
  final String fieldNameError;
  final String fieldPhoneError;
  final String fieldAddressError;
  const ShipInfo({
    super.key,
    required this.cityController,
    required this.nameController,
    required this.phoneController,
    required this.addressController,
    required this.fieldCityError,
    required this.fieldNameError,
    required this.fieldPhoneError,
    required this.fieldAddressError,
    required this.method,
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
  String? selectedCity;
  PayMethod? method = PayMethod.banking;
  @override
  void dispose() {
    widget.cityController.dispose();
    widget.nameController.dispose();
    widget.phoneController.dispose();
    widget.addressController.dispose();
    super.dispose();
  }

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
                controller: widget.nameController,
                decoration: InputDecoration(
                  errorText: widget.fieldNameError.isNotEmpty
                      ? widget.fieldNameError
                      : null,
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.red,
                          style: BorderStyle.solid)),
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
                controller: widget.phoneController,
                decoration: InputDecoration(
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1,
                          color: Colors.red,
                          style: BorderStyle.solid)),
                  errorText: widget.fieldPhoneError.isNotEmpty
                      ? widget.fieldPhoneError
                      : null,
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
                errorText: widget.fieldCityError.isNotEmpty
                    ? widget.fieldCityError
                    : null,
                inputDecorationTheme: InputDecorationTheme(
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: Colors.red,
                            style: BorderStyle.solid)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: Colors.grey,
                            style: BorderStyle.solid))),
                expandedInsets: EdgeInsets.all(0),
                controller: widget.cityController,
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
                  controller: widget.addressController,
                  decoration: InputDecoration(
                    errorText: widget.fieldAddressError.isNotEmpty
                        ? widget.fieldAddressError
                        : null,
                    errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: Colors.red,
                            style: BorderStyle.solid)),
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
                    widget.method('cash');
                    method = value;
                  });
                },
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.all(0),
              title: const Text('Thanh toán chuyển khoản'),
              leading: Radio<PayMethod>(
                value: PayMethod.money,
                groupValue: method,
                onChanged: (PayMethod? value) {
                  setState(() {
                    widget.method('banking');
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
