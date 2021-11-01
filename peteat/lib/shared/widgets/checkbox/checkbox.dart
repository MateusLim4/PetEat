import 'package:flutter/material.dart';
import 'package:peteat/shared/themes/app_colors.dart';

import '../my-globals.dart';

class CheckboxSun extends StatefulWidget {
  const CheckboxSun({Key? key}) : super(key: key);

  @override
  State<CheckboxSun> createState() => _CheckboxSun();
}

class _CheckboxSun extends State<CheckboxSun> {
  bool isChecked = domingo!;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return AppColors.secondary;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
          domingo = isChecked;
        });
      },
    );
  }
}

class CheckboxMon extends StatefulWidget {
  const CheckboxMon({Key? key}) : super(key: key);

  @override
  State<CheckboxMon> createState() => _CheckboxMon();
}

class _CheckboxMon extends State<CheckboxMon> {
  bool isChecked = segunda!;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return AppColors.secondary;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
          segunda = isChecked;
        });
      },
    );
  }
}

class CheckboxTu extends StatefulWidget {
  const CheckboxTu({Key? key}) : super(key: key);

  @override
  State<CheckboxTu> createState() => _CheckboxTu();
}

class _CheckboxTu extends State<CheckboxTu> {
  bool isChecked = terca!;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return AppColors.secondary;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
          terca = isChecked;
        });
      },
    );
  }
}

class CheckboxWd extends StatefulWidget {
  const CheckboxWd({Key? key}) : super(key: key);

  @override
  State<CheckboxWd> createState() => _CheckboxWd();
}

class _CheckboxWd extends State<CheckboxWd> {
  bool isChecked = quarta!;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return AppColors.secondary;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
          quarta = isChecked;
        });
      },
    );
  }
}

class CheckboxTh extends StatefulWidget {
  const CheckboxTh({Key? key}) : super(key: key);

  @override
  State<CheckboxTh> createState() => _CheckboxTh();
}

class _CheckboxTh extends State<CheckboxTh> {
  bool isChecked = quinta!;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return AppColors.secondary;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
          quinta = isChecked;
        });
      },
    );
  }
}

class CheckboxFr extends StatefulWidget {
  const CheckboxFr({Key? key}) : super(key: key);

  @override
  State<CheckboxFr> createState() => _CheckboxFr();
}

class _CheckboxFr extends State<CheckboxFr> {
  bool isChecked = sexta!;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return AppColors.secondary;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
          sexta = isChecked;
        });
      },
    );
  }
}

class CheckboxSt extends StatefulWidget {
  const CheckboxSt({Key? key}) : super(key: key);

  @override
  State<CheckboxSt> createState() => _CheckboxSt();
}

class _CheckboxSt extends State<CheckboxSt> {
  bool isChecked = sabado!;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return AppColors.secondary;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
          sabado = isChecked;
        });
      },
    );
  }
}
