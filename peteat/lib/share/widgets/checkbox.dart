import 'package:flutter/material.dart';
import 'package:peteat/share/presets/app_colors.dart';
import 'package:peteat/share/widgets/my-globals.dart';

class CheckBox extends StatefulWidget {
  const CheckBox({Key? key}) : super(key: key);

  @override
  State<CheckBox> createState() => _CheckBox();
}

class _CheckBox extends State<CheckBox> {
  bool _isChecked = isChecked!;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return AppColors.primary;
      }
      return AppColors.secondary;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: _isChecked,
      onChanged: (bool? value) {
        setState(() {
          _isChecked = value!;
          if (_isChecked == true) {
            isChecked = true;
          }
        });
      },
    );
  }
}
