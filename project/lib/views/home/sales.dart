import 'package:project/all_imports.dart';

class Sales extends StatelessWidget {
  const Sales({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      title: 'chuyên trang khuyến mãi',
      morebtn: false,
      content: const Column(
        children: [
          Row(
            children: [
              BannerSale(
                image_url: 'img/sales/sale1.jpg',
              ),
              SizedBox(width: 16),
              BannerSale(
                image_url: 'img/sales/sale1.jpg',
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              BannerSale(
                image_url: 'img/sales/sale1.jpg',
              ),
              SizedBox(width: 16),
              BannerSale(
                image_url: 'img/sales/sale1.jpg',
              ),
            ],
          ),
        ],
      ),
      category: '',
    );
  }
}
