import 'package:project/all_imports.dart';

class CollectionProducts extends StatelessWidget {
  final String title;
  const CollectionProducts({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 32),
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title.toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 21))
        ],
      ),
    );
  }
}
