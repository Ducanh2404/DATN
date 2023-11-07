import 'package:project/all_imports.dart';

class TransparentButton extends MaterialStateProperty<Color?> {
  @override
  Color? resolve(Set<MaterialState> states)  {
              if (states.contains(MaterialState.hovered))
                return Colors.transparent;
              if (states.contains(MaterialState.focused) ||
                  states.contains(MaterialState.pressed))
                return Colors.transparent;
              return null;
            }
}