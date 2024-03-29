import 'package:project/all_imports.dart';
import 'package:project/views/admin/main.dart';

/// a. creating StatefulWidget
class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State createState() {
    return _HomeState();
  }
}

/// b. Creating state for stateful widget
class _HomeState extends State {
  bool isAdmin = false;
  @override
  initState() {
    getCurrentUser();
    super.initState();
  }

  Future<void> getCurrentUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: user.email)
          .get()
          .then((QuerySnapshot query) => {
                query.docs.forEach((doc) {
                  Map<String, dynamic> data =
                      doc.data() as Map<String, dynamic>;
                  if (data['status'] == '0') {
                    setState(() {
                      isAdmin = true;
                    });
                  } else {
                    setState(() {
                      isAdmin = false;
                    });
                  }
                })
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isAdmin
        ? Admin()
        : SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFf3f3f3),
              ),
              child: const Column(children: [
                Header(),
                CarouselBanner(),
                Categories(),
                PruductSlider(
                  category: 'PC Gaming',
                  thumbnailImg:
                      'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/product-thumbnail%2Fcategory1.jpg?alt=media&token=c9a25f49-d7e4-4137-9349-63588f6dd362',
                ),
                PruductSlider(
                  category: 'Màn Hình Máy Tính',
                  thumbnailImg:
                      'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/product-thumbnail%2Fcat_big_68_1697793723.jpg?alt=media&token=fa2dd161-036c-4121-ad22-544574b5ed7e',
                ),
                PruductSlider(
                  category: 'Laptop - Máy Tính Xách Tay',
                  thumbnailImg:
                      'https://firebasestorage.googleapis.com/v0/b/datn-cdbee.appspot.com/o/product-thumbnail%2Fcat_big_79_1697613978.jpg?alt=media&token=f3a50b7d-64de-4d30-affe-d9294774cca5',
                ),
                Sales(),
                Brand(),
                Footer(),
              ]),
            ),
          );
  }
}

class Footer extends StatelessWidget {
  const Footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        FooterInfo(),
        FooterMain(),
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        HeaderTop(),
        HeaderBottom(),
        MenuItems(),
      ],
    );
  }
}
