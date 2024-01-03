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
                image_url:
                    'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/sales%2Fsale1.jpg?alt=media&token=b95063ab-6f2d-4e21-8feb-a74a731df772',
              ),
              SizedBox(width: 16),
              BannerSale(
                image_url:
                    'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/sales%2Fsale2.jpg?alt=media&token=29624020-fba4-4af8-81a0-04c1bc1f5a74',
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              BannerSale(
                image_url:
                    'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/sales%2Fsale3.jpg?alt=media&token=7509112f-a3c3-4bec-b740-e9ff6e0b0cf9',
              ),
              SizedBox(width: 16),
              BannerSale(
                image_url:
                    'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/sales%2Fsale4.jpg?alt=media&token=d8931315-32b0-4e89-98ce-96a37d4bf26e',
              ),
            ],
          ),
        ],
      ),
      category: '',
    );
  }
}
