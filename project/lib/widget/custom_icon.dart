import 'package:project/all_imports.dart';

class CustomIcon extends StatelessWidget {
  final String title;
  final Color titleColor;
  final IconData icon;
  final Color color;

  CustomIcon({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          FaIcon(size: 18, color: color, icon),
          Text(
            title,
            style: TextStyle(fontSize: 16, color: titleColor),
          ),
        ],
      ),
    );
  }
}