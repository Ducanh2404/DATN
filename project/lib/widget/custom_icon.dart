import 'package:project/all_imports.dart';

class CustomIcon extends StatelessWidget {
  final String title;
  final Color titleColor;
  final IconData icon;
  final Color color;

  const CustomIcon({
    super.key,
    required this.title,
    required this.icon,
    required this.color,
    required this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          FaIcon(size: 18, color: color, icon),
          Text(
            title,
            style: TextStyle(
                fontSize: Responsive.isDesktop(context) ? 16 : 14,
                color: titleColor),
          ),
        ],
      ),
    );
  }
}
